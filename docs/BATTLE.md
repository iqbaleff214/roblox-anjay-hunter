# Battle System — Anjay Hunter

**Version:** 1.0  
**Status:** In Progress  
**Cross-reference:** GDD.md §8 (Battle System), §7 (Monster System), §6 (Pet System)

---

## Table of Contents

1. [Overview](#1-overview)
2. [Battle Types](#2-battle-types)
3. [State Machine](#3-state-machine)
4. [Turn Order & Priority](#4-turn-order--priority)
5. [Actions Per Turn](#5-actions-per-turn)
6. [Damage Formulas](#6-damage-formulas)
7. [Elemental System](#7-elemental-system)
8. [Status Effects](#8-status-effects)
9. [Passive Mechanics](#9-passive-mechanics)
10. [Capture Mechanic](#10-capture-mechanic)
11. [Dungeon Battle Rules](#11-dungeon-battle-rules)
12. [Wild Beast Encounter Rules](#12-wild-beast-encounter-rules)
13. [NPC Battle Rules](#13-npc-battle-rules)
14. [PvP Battle Rules](#14-pvp-battle-rules)
15. [Drop Tables](#15-drop-tables)
16. [Reward Distribution](#16-reward-distribution)
17. [Special Mechanics Reference](#17-special-mechanics-reference)
18. [Glossary](#18-glossary)

---

## 1. Overview

All battles are **turn-based**. All authoritative logic runs **server-side only**. Clients send action requests; server validates, resolves, and broadcasts results. No client has authority over damage values, HP changes, XP, loot, or currency.

**Core sequence per turn:**
1. Evaluate start-of-turn effects (DOTs, Regen ticks)
2. Determine turn order (SPD-descending; ties by raw SPD then random)
3. Collect action from each participant (or timeout for PvP)
4. Resolve actions in priority order
5. Check end condition
6. Loop or end

---

## 2. Battle Types

| Type | Opponent | Entry Trigger | Flee Allowed? | Energy Cost | Rep Change? |
|---|---|---|---|---|---|
| **Wild Hunt** | Roaming wild beast | Player walks within encounter range | Yes (70% base) | 10 per encounter | No |
| **Dungeon Run** | Monster waves + Boss | Player enters dungeon instance | Yes (exits dungeon) | 25 per run | No |
| **NPC Battle** | Scripted trainer pet | Player interacts with NPC | No | 0 | No |
| **PvP** | Another player's pet | Challenge accepted by both parties | No | 0 | Yes |

---

## 3. State Machine

```
IDLE
  │  Trigger: challenge accepted / wild beast engaged / dungeon wave starts
  ▼
INIT
  │  - Build participant list (attacker's active pet vs defender's active pet)
  │  - Sort turn order by Speed (descending); ties broken by raw SPD comparison,
  │    then math.random() if still equal
  │  - Evaluate battle-start passives (e.g. Petrifying Gaze, Aerial Predator)
  │  - Set battle_turn_counter = 0
  ▼
TURN_START
  │  - Increment battle_turn_counter by 1
  │  - Apply start-of-turn effects in this order:
  │      1. Regen tick (heal)
  │      2. Burn tick (damage)
  │      3. Poison tick (damage)
  │      4. Bleed tick (damage)
  │      5. Decrement all active effect durations by 1; remove at 0
  │  - Evaluate turn-based passives (e.g. Lunar Rage, Storm Conductor reset check,
  │    Constrictor SPD drain accumulation)
  │  - Check end condition before action (DOT may kill; resolve BATTLE_END if so)
  ▼
ACTION_SELECT
  │  - PvP: 30-second countdown; auto-Attack if timer expires
  │  - Wild / NPC / Dungeon: server-controlled AI selects action immediately
  │  - Valid actions: Attack, Use Skill, Use Item, Swap Pet, Flee
  ▼
ACTION_RESOLVE
  │  - Execute actions in priority order (see §4)
  │  - For each action:
  │      a. Resolve pre-action modifiers (always-first flags, ATK/DEF buffs)
  │      b. Calculate raw damage / heal
  │      c. Apply elemental multiplier
  │      d. Apply damage; check HP floor (min 1 if Undying Grit active)
  │      e. Roll status effect procs
  │      f. Apply status effects to target.ActiveEffects
  │      g. Trigger any on-hit passives (Knuckle Guard counter, Fox Fire mark)
  │  - After all actions resolve, evaluate passive explosions (Fox Fire at 3 marks)
  ▼
CHECK_END
  ├── Any side has 0 living pets? → BATTLE_END
  └── Otherwise → TURN_START (next turn)

BATTLE_END
  │  - Distribute XP to all pets that participated (split equally)
  │  - Award Silver, Gold, and loot to winner
  │  - Update PlayerData:
  │      · PvP: rep change for both parties
  │      · Codex: new species entry if applicable
  │      · Quest progress counters
  │      · Achievement triggers
  │      · Dungeon run counter (DungeonRunsToday)
  │  - Save PlayerData via ProfileService
  └── Return players to world / next wave
```

### 3.1 Dungeon Wave Loop

Dungeon replaces `IDLE → INIT` with a wave loop. After `BATTLE_END` for each wave (except wave 8), the state returns to `INIT` for the next wave without releasing the player. All pet HP and Stamina carry over between waves unchanged. Buffs and debuffs (ActiveEffects) persist across wave boundaries within the same run.

```
Wave 1 → BATTLE_END (wave cleared)
  │
  ├── wave < 8  → INIT (next wave, monsters re-spawned at next level tier)
  └── wave == 8 → BATTLE_END (boss killed / run complete) → distribute full run loot
```

---

## 4. Turn Order & Priority

### 4.1 Base Turn Order

Actions resolve in **descending SPD order** each turn. SPD is evaluated at the start of `ACTION_RESOLVE` using the pet's current SPD (including active buffs/debuffs at that moment).

**Tiebreaker (same SPD):**
1. Compare raw base SPD (stat before modifiers) — higher wins
2. If still tied: `math.random(0, 1)` — random winner

### 4.2 Always-First Skills

Certain skills have the `always_first = true` flag. When a pet uses an always-first skill:

- It is inserted at position 0 in the action queue, before all other actions for that turn, regardless of SPD
- It resolves before any other action that turn

**Always-first skill family (current):**

| Skill | Beast | Notes |
|---|---|---|
| Pounce | Tiger | — |
| Talon Dive | Eagle | — |
| Cavalry Charge | Horse (Stage 2) | — |
| Rolling Charge | Armadillo (Stage 2) | — |
| Silverback Charge | Gorilla (Stage 2) | — |
| Gale Wing | Thunderbird | Wind Elemental; does not grant Storm Stack |

**Always-first collision (two always-first skills in same turn):**
- Compare raw SPD of both pets — higher goes first
- If raw SPD is also equal: `math.random(0, 1)`

**Aerial Predator passive (Hawk):** Acts as an always-first priority override on `battle_turn_counter == 1` only. Hawk's action is inserted at position 0 before all always-first skill checks. If two Aerial Predator passives clash (mirror match): raw SPD tiebreaker, then random.

**Implementation note:** Store each pet's queued action with a `priority` field: `0 = always-first`, `1 = normal`. Sort action queue: by priority ascending, then by current SPD descending within each priority group.

### 4.3 Battle-Start Priority (Turn 0 Passives)

Evaluated once at `INIT`, before `battle_turn_counter` is set to 1:

| Passive | Beast | Resolution |
|---|---|---|
| Petrifying Gaze | Basilisk | Roll 20%; if hit, set `opponent.skip_action_turn1 = true` |
| Blood Frenzy (world) | Shark | Checked at world-encounter trigger — not a battle-start passive; see §12 |

`skip_action_turn1`: On turn 1's `ACTION_RESOLVE`, if this flag is set on a pet, its action is skipped entirely. The flag is cleared after turn 1 regardless of outcome.

---

## 5. Actions Per Turn

Each pet takes **exactly one action per turn** (except counter-attacks triggered by passives — those are free and do not replace the turn).

| Action | Effect | Turn Consumed? | Notes |
|---|---|---|---|
| **Attack** | Physical hit using basic ATK formula (§6.1) | Yes | No Stamina cost |
| **Use Skill** | Deduct SP cost; apply skill formula (§6.2); proc status effects | Yes | Fails if insufficient Stamina; treat as Attack instead (or show error) |
| **Use Item** | Apply consumable effect to own or target pet | Wild/NPC/Dungeon: No · PvP: Yes | See §5.1 |
| **Swap Pet** | Remove active pet; insert roster pet | Yes | HP/buffs of benched pet preserved |
| **Flee** | Attempt escape | Yes | See §5.2 |

### 5.1 Item Use in Battle

**HP Potion (Small):** `target.HP = math.min(target.MaxHP, target.HP + math.floor(target.MaxHP × 0.30))`  
**HP Potion (Large):** `target.HP = target.MaxHP`  
**Stamina Potion:** `target.Stamina = math.min(target.MaxStamina, target.Stamina + math.floor(target.MaxStamina × 0.50))`  

Items can only be used on own pets (not opponent). Using an item in PvP costs the turn — the opponent acts freely that turn.

Battle Tactician Game Pass: item use in PvP does **not** consume the turn.

### 5.2 Flee Attempt

```lua
flee_chance = 0.70  -- base 70%
roll = math.random()
if roll < flee_chance then
    -- escape succeeds
    BATTLE_END (no rewards, no rep change)
else
    -- flee fails; turn is wasted (opponent still acts)
end
```

Flee is only available in Wild Hunt and Dungeon Run. Fleeing a Dungeon Run exits the instance; partial loot from cleared waves is kept.

Certain beasts set `prevent_flee = true` for turn 1 (Hawk Aerial Predator world behaviour: player cannot flee on turn 1 after the dive animation). This is a world-behaviour flag, not a battle mechanic.

---

## 6. Damage Formulas

All damage values are integers (floor after final calculation). Minimum damage per hit: **1** (never 0, never negative).

### 6.1 Physical Attack (Basic)

```lua
raw    = attacker.ATK - defender.DEF
damage = math.max(1, raw) * elemental_multiplier
damage = math.floor(damage)
```

### 6.2 Skill Attack

```lua
raw    = (attacker.ATK * skill.power_mult) - defender.DEF
damage = math.max(1, raw) * elemental_multiplier
damage = math.floor(damage)
```

**Skill power multipliers:**

| Tier Label | Multiplier | Typical SP Cost | Use Case |
|---|---|---|---|
| Weak | ×0.8 | 8–12 | Fast hit with strong effect; multi-hit base |
| Normal | ×1.2 | 8–14 | Standard single-target |
| Strong | ×1.8 | 12–22 | Hard hitter; common at Stage 1–2 |
| Heavy | ×2.5 | 24–32 | Slow or conditional high-damage |
| Ultimate | ×3.5 | 38–50 | Stage 3 finisher; high SP cost |

### 6.3 DEF-Ignore Modifier

Some skills partially ignore target DEF:

```lua
effective_def = defender.DEF * (1 - ignore_pct)
raw    = (attacker.ATK * skill.power_mult) - effective_def
damage = math.max(1, raw) * elemental_multiplier
damage = math.floor(damage)
```

`ignore_pct` is a value between 0 and 1 (e.g., 0.30 = ignore 30% DEF). Full DEF bypass sets `effective_def = 0`.

### 6.4 Multi-Hit Skills

Skills that hit N times at ×M each resolve as N independent damage calculations, each floored separately. Each hit independently rolls for status effect procs.

```lua
for i = 1, hit_count do
    raw    = (attacker.ATK * per_hit_mult) - defender.DEF
    damage = math.max(1, raw) * elemental_multiplier
    damage = math.floor(damage)
    deal_damage(defender, damage)
    roll_status_proc(skill, defender)  -- independent per hit
end
```

### 6.5 Heal Skill

```lua
heal = math.floor(target.MaxHP * skill.heal_pct)
target.HP = math.min(target.MaxHP, target.HP + heal)
```

HP cannot exceed `MaxHP`. Heal cannot go below 0 (the `max(0, ...)` guard is implicit from the floor of a positive percent).

### 6.6 Status Effect Tick Damage (Burn / Poison / Bleed)

Applied at start of the affected pet's turn, before it acts:

```lua
tick_damage = math.floor(target.MaxHP * effect.tick_pct)
target.HP   = math.max(0, target.HP - tick_damage)
```

Tick damage does **not** apply elemental multipliers. It does not trigger passives (e.g., no Knuckle Guard counter on a Burn tick). Tick damage can kill — if HP reaches 0, `BATTLE_END` is triggered immediately before the pet takes its action.

### 6.7 ATK / DEF Modifier Application Order

When a pet has active ATK or DEF buffs/debuffs, apply them to the base stat before damage calculation:

```lua
effective_ATK = base_ATK * (1 + sum_of_atk_modifiers)
effective_DEF = base_DEF * (1 + sum_of_def_modifiers)
-- Armor Break modifier is negative, e.g. -0.30 for 30% DEF reduction
```

Modifiers stack **additively** within their category. Example: ATK +30% buff and ATK +15% buff = effective ATK × 1.45, not × 1.495.

Permanent battle modifiers (e.g., Wolf Pack Leader stacks, Wolverine Undying Grit ATK bonus) are stored in a separate `battle_passive_modifier` table and also applied additively to the sum.

---

## 7. Elemental System

### 7.1 Multiplier Table

| Attacker Element | Strong Against (×1.5) | Weak Against (×0.5) |
|---|---|---|
| Fire | Nature, Ice, Metal | Water |
| Water | Fire, Earth | Electric |
| Nature | Water, Earth | Fire |
| Earth | Electric, Metal | Nature |
| Electric | Water, Ice | Earth |
| Ice | Nature, Wind | Fire |
| Metal | Ice, Wind | Fire |
| Dark | Electric, Nature | Light |
| Light | Dark, Metal | Dark |
| Wind | Earth, Water | Ice |

Neutral cases (×1.0):
- Attacker has no element
- Defender has no element
- Both have the same element

### 7.2 Multiplier Lookup

```lua
function get_elemental_multiplier(atk_element, def_element)
    if atk_element == nil or def_element == nil then return 1.0 end
    if atk_element == def_element then return 1.0 end
    if STRONG_TABLE[atk_element][def_element] then return 1.5 end
    if WEAK_TABLE[atk_element][def_element] then return 0.5 end
    return 1.0
end
```

### 7.3 Elemental Source

The element used in the multiplier lookup is:
- **Attacker element:** The element of the **skill** being used (not the pet's imbued element), unless the skill is `Physical` type — in that case, use the pet's imbued element (if any).
- **Defender element:** The pet's imbued element (if any); otherwise nil.

Special case: if a Physical skill explicitly states it deals an elemental type (e.g., Earth Elemental counter from Armadillo Counter Plate), use that skill's element as the attacker element.

### 7.4 Element Imbuing

- Available at pet **Level 50+**
- One element per pet at a time
- Change element: **Re-imbue Stone** (200 Gold)
- Imbued element unlocks element-tagged skills in the Skill Shop

---

## 8. Status Effects

All effects stored in `pet.ActiveEffects` as an array of `{type, duration, magnitude}` entries. Duration decrements by 1 at **start of the affected pet's turn**, after ticks resolve. Effect is removed when duration reaches 0.

Multiple effects of the same type **do not stack duration** — applying the same effect again while it is active **resets** its duration to the new application's duration. Exception: Armor Break stacks independently per source (see below).

### 8.1 Reference Table

| Effect | Category | Trigger Source | What It Does | Default Duration | Default Magnitude | Apply Chance (default) |
|---|---|---|---|---|---|---|
| **Burn** | DOT | Fire skill | −5% MaxHP per turn | 3T | 0.05 | 30% |
| **Poison** | DOT | Nature / Dark skill | −3% MaxHP per turn | 5T | 0.03 | 30% |
| **Bleed** | DOT | Physical / certain skills | Variable % MaxHP/turn | 2–5T | 0.008–0.01 | varies per skill |
| **Freeze** | Control | Ice skill | Skip turn entirely | 1T | — | 25% |
| **Bind** | Control | Physical wrap / skill | Skip turn entirely | 1–2T | — | varies |
| **Shock** | Debuff | Electric skill | −25% SPD | 2T | −0.25 | 35% |
| **Armor Break** | Debuff | Earth / Metal / skill | −30% DEF | 2T | −0.30 | 40% |
| **Blind** | Debuff | Dark skill | 50% miss chance | 2T | 0.50 | 30% |
| **Regen** | Buff | Nature / Light skill | +5% MaxHP per turn | 3T | 0.05 | 100% (always) |
| **Taunt** | Control | Wind / skill | Forces opponent to target this pet | 2T | — | 100% (always) |

### 8.2 Detailed Behaviour

**Burn:**  
- Tick fires at `TURN_START`, before the affected pet's action
- `tick_damage = math.floor(pet.MaxHP × 0.05)` (uses MaxHP, not current HP)
- Can kill — check HP after tick before allowing action

**Poison:**  
- Same tick timing as Burn
- `tick_damage = math.floor(pet.MaxHP × 0.03)`
- Skills may specify a different magnitude (e.g. Scorpion Tail uses 0.03/turn at 5T)
- Can kill

**Bleed:**  
- Same tick timing; magnitude varies by skill (stored per-effect-instance)
- Bleed ticks reduced by 50% when Armored Scales (Crocodile) is active — apply as `tick_damage × 0.5`

**Freeze:**  
- Duration 1T — the affected pet loses its entire action next turn
- Tick does no damage; purely control
- On frozen turn: skip `ACTION_SELECT` and `ACTION_RESOLVE` for that pet
- Duration still decrements at turn start (so it lasts exactly 1 missed action)

**Bind:**  
- Same as Freeze but duration can be 1–2T depending on the skill
- Freeze and Bind are functionally identical in resolution; use the same `skip_action` flag
- Bind is the label used for physical constriction skills; Freeze for Ice elemental

**Shock:**  
- SPD modifier: `pet.SPD_modifier -= 0.25` while active
- Stored in `ActiveEffects`; recompute effective SPD each turn from base + modifier
- Stacks with other SPD reductions additively (e.g. Flood Gate's additional −20% stacks)

**Armor Break:**  
- DEF modifier: `pet.DEF_modifier -= 0.30` while active
- **Stacks:** unlike other debuffs, multiple Armor Break entries from different sources coexist in `ActiveEffects` as separate entries. Maximum 3 simultaneous stacks (−90% total DEF). Applying a 4th stack replaces the oldest.
- On expiry of one stack, only that stack is removed; others persist

**Blind:**  
- Miss chance: at damage resolution, roll `math.random() < 0.50`; if true, the action misses (deals 0 damage, no status procs)
- Blind does not prevent item use or self-buffs — only offensive actions
- Feather Veil (Sparrow): reflects Blind back at attacker at 50% duration (1T Blind applied to attacker)

**Regen:**  
- Tick fires at `TURN_START`, before Burn/Poison (i.e., Regen can partially offset DOTs)
- `heal = math.floor(pet.MaxHP × 0.05)`
- `pet.HP = math.min(pet.MaxHP, pet.HP + heal)`

**Taunt:**  
- While Taunt is active on a pet, the opponent **must** target that pet with offensive actions
- Does not prevent the taunted pet from acting normally
- Taunt is bypassed by King's Judgment (Lion Stage 3) and Stubborn Stance (Goat)

### 8.3 Effect Application

When a skill specifies a status effect with a proc chance:

```lua
function try_apply_effect(effect_type, chance, target, duration, magnitude)
    if math.random() < chance then
        apply_effect(target, effect_type, duration, magnitude)
    end
end
```

Some skills specify "always apply" (100% chance) — call `apply_effect` directly without a roll.

Effects that specify simultaneous application (e.g. Chaos Manifestation, World Serpent Coil):

```lua
-- Apply all effects in array order before damage resolves
for _, effect in ipairs(skill.simultaneous_effects) do
    apply_effect(target, effect.type, effect.duration, effect.magnitude)
end
-- Then calculate damage (Armor Break DEF reduction is now active)
deal_damage(attacker, target, skill)
```

---

## 9. Passive Mechanics

Passives are not stored in `ActiveEffects` — they are evaluated inline at specific trigger points. Each passive has a defined trigger hook.

### 9.1 Passive Trigger Hooks

| Passive Name | Beast | Trigger Hook | One-Per-Battle? |
|---|---|---|---|
| Blood Frenzy | Shark | Start of each turn (re-evaluated) | No |
| Pride | Lion | Start of each turn (compare ATK values) | No |
| Discharge | Platypus | On Electric skill hit | No |
| Echolocation | Bat | Pre-turn (reduce opponent dodge) | No |
| Fortune Scales | Koi | Start of each turn | No |
| Knuckle Guard | Gorilla | On taking Physical hit | No |
| Fox Fire | Kitsune | On offensive skill use | No |
| Constrictor | Anaconda | Start of each turn (after turn 1) | No |
| Petrifying Gaze | Basilisk | Battle start (INIT phase) | Yes |
| Pack Leader | Wolf | On dealing a killing blow | No (stacks up to 3) |
| Undying Grit | Wolverine | When HP would reach 0 | Yes (once per battle) |
| Aerial Predator | Hawk | Turn 1 action ordering | Yes (turn 1 only) |
| Lunar Rage | Werewolf | Start of each turn | No |
| Storm Conductor | Thunderbird | On Electric skill use / non-Electric use | No |
| Charge Tokens | Hamster | Various (see BEAST.md 030) | No |

### 9.2 Passive Implementation Notes

**Blood Frenzy (Shark):**  
Evaluate at `TURN_START` before action. Two independent conditions, each granting +20% ATK:
1. `self.HP / self.MaxHP < 0.50` → +20%
2. `target.ActiveEffects` contains any DOT tag (Burn, Poison, Bleed) → +20%
Both can be active: +40% total. Apply as `battle_passive_modifier_atk`.

**Pack Leader (Wolf):**  
Check `damage_dealt >= target.HP` at `ACTION_RESOLVE` after damage is applied. If target HP reaches 0 from Wolf's attack: `pack_leader_stacks = math.min(3, pack_leader_stacks + 1)`. Apply `battle_passive_modifier_atk = pack_leader_stacks × 0.15`.

**Undying Grit (Wolverine):**  
Before setting `target.HP = 0` from any damage source: check `undying_grit_available == true`. If so: `target.HP = 1`, `undying_grit_available = false`, apply permanent `battle_passive_modifier_atk += 0.30`.  
Does not fire on DOT ticks — Undying Grit only triggers on a direct hit (single damage event that would kill).

**Constrictor (Anaconda):**  
Maintain `constrictor_turn` counter per battle. At each `TURN_START` (starting turn 2): `constrictor_turn += 1`. Apply `target.aura_spd_penalty = math.min(0.30, constrictor_turn × 0.05)`. Store in a separate `aura_penalties` table on the target — not in `ActiveEffects`. Cannot be cleansed.

**Storm Conductor (Thunderbird):**  
On Electric skill use: `storm_stacks = math.min(6, storm_stacks + 1)`.  
On non-Electric, non-Wind skill use: `storm_stacks = 0`.  
Wind skill use: no change.  
Apply `battle_passive_modifier_atk = storm_stacks × 0.10` at damage calculation time.

**Fox Fire (Kitsune):**  
On each offensive skill use: roll 20% → if hit, `target.fox_fire_marks += 1`.  
After each increment: check `if target.fox_fire_marks >= 3 then trigger_fox_fire_explosion(target); target.fox_fire_marks = 0 end`.  
Fox fire explosion: Fire Elemental damage at ×1.5 power, uses Kitsune's current ATK, applies elemental multiplier against defender's element, no DEF subtraction (it is a pure elemental burst). Does not consume a turn.

**Lunar Rage (Werewolf):**  
At `TURN_START`: `if battle_turn_counter % 2 == 1 then` apply `battle_passive_modifier_atk = 0.25` and clear SPD modifier `else` apply `battle_passive_modifier_spd = 0.25` and clear ATK modifier `end`.  
When Lycan Transformation is active: multiply the active bonus by 2 (`0.50` instead of `0.25`) for its 3-turn duration.

---

## 10. Capture Mechanic

### 10.1 Rules

- Can only attempt capture when the target beast's HP is **below 50% of its MaxHP**
- Capture attempts available in **Wild Hunt** and **Dungeon Run** (for capturable dungeon monsters: Slime and Goblin only)
- Each attempt consumes **1 Trap** from the player's inventory
- A failed capture still consumes the Trap
- Capture attempt uses a full turn in Wild Hunt; does not consume a turn in Dungeon Run (resolve inline as a free action during the wave)

### 10.2 Formula

```lua
rarity_modifier = {
    Common    = 1.0,
    Uncommon  = 1.5,
    Rare      = 2.5,
    Epic      = 5.0,
    Legendary = 10.0
}

hp_factor      = 1 - (target.HP / target.MaxHP)  -- higher when HP lower
capture_chance = trap.base_rate * hp_factor * (1 / rarity_modifier[target.Rarity])
roll           = math.random()  -- uniform 0.0–1.0
captured       = roll < capture_chance
```

### 10.3 Trap Reference

| Trap | Base Rate | Acquisition |
|---|---|---|
| Basic Trap | 0.30 | Item Shop (50 Silver) |
| Iron Trap | 0.50 | Item Shop (200 Silver), Daily Quest reward |
| Gold Trap | 0.70 | Item Shop (50 Gold) |
| Legend Trap | 0.90 | Item Shop (300 Gold), Dungeon boss drop (5%), Bounty reward |

### 10.4 Effective Capture Chance Examples

Target at 25% HP remaining (`hp_factor = 0.75`):

| Trap | Common | Uncommon | Rare | Epic | Legendary |
|---|---|---|---|---|---|
| Basic (0.30) | 22.5% | 15.0% | 9.0% | 4.5% | 2.25% |
| Iron (0.50) | 37.5% | 25.0% | 15.0% | 7.5% | 3.75% |
| Gold (0.70) | 52.5% | 35.0% | 21.0% | 10.5% | 5.25% |
| Legend (0.90) | 67.5% | 45.0% | 27.0% | 13.5% | 6.75% |

**Pet Whisperer Game Pass:** +0.10 flat bonus to `base_rate` (effectively +10% base rate on all traps).

**Capture Boost Developer Product:** +0.20 flat bonus to `base_rate` for next 5 attempts. Store as `PlayerData.CaptureBoostCharges`.

### 10.5 Post-Capture

```lua
if captured then
    new_pet = create_pet_data(species, level=target.Level, owner=player.UserId)
    if #PlayerData.PetRosterIds >= PlayerData.PetSlots then
        -- prompt: "Your roster is full. Release a pet to add this one?"
        -- if player confirms release: remove selected pet, add new pet
        -- if player declines: capture lost (beast freed)
    else
        table.insert(PlayerData.PetRosterIds, new_pet.PetId)
        update_codex_entry(species)
    end
    end_wild_battle()  -- capture ends Wild Hunt battle immediately
end
```

New pet spawns at the **same level as the captured wild beast**, with base stats for that species and level. It does not inherit any of the wild beast's HP damage.

---

## 11. Dungeon Battle Rules

### 11.1 Structure

| Property | Value |
|---|---|
| Waves per run | 8 (waves 1–7 = monster waves, wave 8 = boss) |
| Daily run limit per dungeon | 3 runs (resets midnight UTC) |
| Max players per instance | 2 (solo or co-op) |
| Hunt Energy cost per run | 25 |
| Dungeon Veteran Pass | +1 run per dungeon per day |
| Dungeon Key Dev Product | +1 run to any dungeon today |

### 11.2 Wave Composition

Each wave spawns 1–7 monsters. Monster count per wave:

| Wave | Monster Count | Notes |
|---|---|---|
| 1 | 1 | Tutorial-pace first wave |
| 2 | 2 | — |
| 3 | 2 | — |
| 4 | 3 | — |
| 5 | 3 | — |
| 6 | 4 | — |
| 7 | 4 | — |
| 8 | 1 (Boss) | Boss has 3–5× base HP of regular monsters; see §11.3 |

For co-op (2 players): each player battles one monster simultaneously where wave count > 1. Boss wave is always 1v1 unless a co-op boss mechanic is implemented separately.

### 11.3 Monster Level Scaling

```lua
zone_max_level = { forest=100, mountain=300, volcano=600, abyss=1000 }
level_step     = math.floor(zone_max_level[dungeon.zone] * 0.08)
wave_level     = dungeon_entry_level + (wave_number - 1) * level_step
```

`dungeon_entry_level` is the minimum zone level (e.g., Forest = 21). Boss level = wave 7 level + level_step.

### 11.4 Pet HP and Stamina Between Waves

- HP and Stamina **carry over** between waves (no auto-restore)
- Buffs and debuffs in `ActiveEffects` persist across wave transitions
- Players may use items (HP/Stamina Potions) between waves during a brief inter-wave window (5 seconds)
- Swapping pets is allowed between waves; pet swap during combat follows normal turn rules

### 11.5 Dungeon Flee

- Player may flee at any point between turns
- Fleeing ends the dungeon run immediately
- **Partial loot** from all previously cleared waves is kept
- The current wave's loot is forfeited
- `DungeonRunsToday` counter is still incremented (the run is consumed)
- Energy is not refunded

### 11.6 Boss Encounter Rules

- Boss occupies wave 8 alone
- Boss has a unique move set (defined in monster config, not pet species config)
- Boss cannot be captured
- Boss is immune to Bind (Freeze and Bind effects fail silently; status is not applied)
- Boss has 50% resistance to all SPD debuffs (Shock, Constrictor, etc.) — apply `spd_debuff × 0.5`
- Boss HP and Stamina do not carry over if defeated; fight resets if player dies and re-attempts (only within daily run limit)

---

## 12. Wild Beast Encounter Rules

### 12.1 Encounter Trigger

Wild beasts roam in zone-appropriate areas. Encounter triggers when the player enters the beast's aggro radius (varies per species — passive beasts: 3–5 studs; aggressive beasts: 6–10 studs).

Each wild beast encounter costs **10 Hunt Energy**. Energy is deducted at trigger time, not at battle end.

### 12.2 Wild Beast Level Range

| Zone | Wild Beast Level Range |
|---|---|
| Starter Plains | 1–20 |
| Forest | 21–100 |
| Mountain | 101–300 |
| Volcano | 301–600 |
| Abyss | 601–1000 |

Wild beast level is randomised within the zone range: `math.random(zone_min_level, zone_max_level)`.

### 12.3 Wild Beast Rarity Spawn Rates

| Zone | Common | Uncommon | Rare | Epic | Legendary |
|---|---|---|---|---|---|
| Starter Plains | 90% | 10% | 0% | 0% | 0% |
| Forest | 65% | 30% | 5% | 0% | 0% |
| Mountain | 40% | 40% | 18% | 2% | 0% |
| Volcano | 20% | 35% | 35% | 9% | 1% |
| Abyss | 5% | 20% | 40% | 30% | 5% |

Legendary spawn rates apply only to standard field spawns. Some Legendaries (e.g. Thunderbird) have additional world-event conditions — see §12.4.

### 12.4 Special Spawn Conditions

| Beast | Zone | Extra Condition |
|---|---|---|
| Thunderbird | Mountain, Abyss | Storm Weather event active + player at summit |
| Werewolf | Abyss, Forest | Night time OR permanently-dark zone (fallback: Abyss unconditional) |
| Kitsune | Forest, Abyss | Appears as wisps; 3 vanish cycles before stable encounter |

If the time/weather system is not yet implemented, apply the fallback spawns listed.

### 12.5 Wild Flee Behaviour

Some beasts flee when the player approaches. Flee direction and speed are per-species (see BEAST.md individual entries). A fleeing beast that reaches a terrain boundary stops and resets to idle. The player can always re-engage.

### 12.6 Wild Beast AI

| Behaviour Tag | Description | Examples |
|---|---|---|
| `passive` | Does not initiate combat | Sparrow, Frog, Horse, Goat, Beaver |
| `flee_on_approach` | Runs away before encounter; can be re-engaged | Sparrow, Rabbit, Deer |
| `aggressive` | Charges on sight within aggro radius | Wolverine, Hawk, Wolf |
| `territorial` | Warns first; charges if warning is ignored | Gorilla, Goat |
| `ambush` | No warning; triggers on proximity | Crocodile, Anaconda, Basilisk |
| `world_event` | Special condition required (see §12.4) | Thunderbird, Werewolf, Kitsune |

AI in battle (Wild Hunt): wild beasts use a weighted random action selector from their skill pool. Weights: Attack 30%, Skill 60%, Flee (never). Dungeon monsters use a fixed priority list (defined per monster config).

---

## 13. NPC Battle Rules

### 13.1 Rules

- NPC battles are triggered by interacting with Trainer NPCs in the world
- Cannot flee from NPC battles
- NPC pet levels scale with zone (see zone level ranges in §12.2)
- Each NPC can be battled once per server session (refresh on re-join or after 24h cooldown, TBD at implementation)
- No Hunt Energy cost

### 13.2 NPC Silver Rewards

| Zone | Silver Reward Range |
|---|---|
| Starter Plains | 50–150 |
| Forest | 200–500 |
| Mountain | 500–1,500 |
| Volcano | 2,000–5,000 (+1–5 Gold) |
| Abyss | 8,000–20,000 (+5–15 Gold) |

Reward is calculated as a random value within the range: `math.random(min, max)` for Silver; same for bonus Gold if applicable.

**Hunter's VIP Game Pass:** +25% to all Silver and Gold earned from NPC battles.

### 13.3 NPC AI

NPCs use a scripted sequential skill rotation defined in the NPC config (not random). This makes higher-zone NPCs feel deliberate and counterable with the right preparation.

---

## 14. PvP Battle Rules

### 14.1 Challenge Flow

1. Player A sends challenge to Player B (via in-world proximity or menu)
2. Player B has 30 seconds to accept; after timeout, challenge expires
3. Both parties select their active pet (default: first pet in `ActivePetIds`)
4. Battle begins — no zone restriction (can PvP anywhere in the world)

### 14.2 PvP-Specific Rules

| Rule | Value |
|---|---|
| Action timeout per turn | 30 seconds; auto-Attack on expiry |
| Flee | Not allowed |
| Item use | Costs a turn (unless Battle Tactician pass owned) |
| Pet swap during battle | Allowed; costs a turn |
| Max rounds before draw | 50 turns; draw gives 0 rep change to both parties |

### 14.3 Rep Change

```lua
rank_diff = get_rank_tier(challenger) - get_rank_tier(defender)
-- rank_diff > 0 = challenger is higher ranked
-- rank_diff < 0 = challenger is lower ranked
-- rank_diff == 0 = same rank

if winner == challenger then
    if   rank_diff > 0  then winner_rep_gain = 15  -- beat lower rank
    elif rank_diff == 0 then winner_rep_gain = 25  -- beat same rank
    else                     winner_rep_gain = 40  -- beat higher rank
    end
    loser_rep_loss = -15 if rank_diff > 0, -25 if same, -5 if challenger is lower
else
    -- mirror the above from defender perspective
end

rep = math.max(0, rep + delta)  -- never drop below 0
-- rep never drops below current rank's Sub I floor (no de-rank from loss)
```

Rep floor per rank: rep cannot fall below the bottom threshold of the player's current Sub I (e.g., Iron Sub I floor = 500). This means a player at Iron III (rep 1,400) who loses heavily cannot drop below 500.

### 14.4 Rep Change Reference

| Outcome | vs Lower Rank | vs Same Rank | vs Higher Rank |
|---|---|---|---|
| Win | +15 | +25 | +40 |
| Lose | −25 | −15 | −5 |

### 14.5 PvP Level Balancing

No level scaling in PvP — raw stats are used. This is intentional: higher-level, higher-evolved pets have a genuine stat advantage. Skill and team composition are the equalising factors. The rep matchmaking ladder naturally separates skill levels over time.

---

## 15. Drop Tables

### 15.1 Wild Beast Drop

| Drop | Condition | Formula / Amount |
|---|---|---|
| Silver | Every win | `beast_level × 5` |
| XP (to active pet) | Every win | `beast_level × 30` |
| Gold | 2% chance per kill | `math.floor(beast_level × 0.1)`, min 1 |
| Basic Trap | 5% chance (Common beasts only) | 1 |
| Evolution Shard | 1% chance (Rare+ beasts only) | 1 |
| Collectible (common) | 3% chance | 1 random common collectible |

No capture attempt here — that is a separate in-battle action (see §10).

### 15.2 Dungeon Monster Drop (Non-Boss Waves)

| Drop | Condition | Formula / Amount |
|---|---|---|
| Silver | Every monster kill | `monster_level × 5` |
| XP | Every monster kill | `monster_level × 20` |
| Gold | 2% chance per kill | `math.floor(monster_level × 0.1)`, min 1 |
| Iron Trap | 3% chance | 1 |
| HP Potion (Small) | 5% chance | 1 |
| Capturable pet (Slime, Goblin) | Capture attempt available | See §10 |

### 15.3 Dungeon Boss Drop

Boss kill guarantees a **Silver payout** and **at least one item** from the loot table. All rolls are evaluated independently (player can get multiple items in one boss kill).

**Guaranteed drops on kill:**

| Drop | Amount |
|---|---|
| Silver | `boss_level × 50` |
| XP (to all participating pets) | `boss_level × 150` |
| Gold (range) | See zone table below |

**Zone-specific boss Gold drop:**

| Dungeon | Boss | Gold Drop Range |
|---|---|---|
| Forest Cave | Goblin Warchief | 10–20 Gold |
| Mountain Ruins | Lich King | 25–50 Gold |
| Dark Forest | Elder Treant | 60–120 Gold |
| Volcano Pit | Orc Overlord | 150–300 Gold |
| Abyss Rift | Abyssal Demon Lord | 400–800 Gold |

**Random loot table (independent rolls, all evaluated per kill):**

| Drop | Drop Rate | Quantity | Notes |
|---|---|---|---|
| Evolution Shard | 60% | 1 | — |
| Rare Collectible | 40% | 1 | — |
| Species-specific Evolution Item | 15% | 1 | Species varies by dungeon; see BEAST.md lore notes per entry |
| Evolution Crystal | 20% | 1 | — |
| Legend Trap | 5% | 1 | — |
| Stamina Potion | 10% | 2 | — |
| HP Potion (Large) | 10% | 1 | — |

**Dungeon Veteran Game Pass:** Auto-collect loot per wave (no click required). Drop rolls still evaluate normally — Veteran only skips the manual loot interaction step.

### 15.4 Boss Species-Specific Item Drop Reference

| Boss | Species Item | Drop Rate | Used For |
|---|---|---|---|
| Goblin Warchief | Goblin Warchief Crown | 15% | Goblin Warchief Stage 3 evolution |
| Lich King | Lich Bone Shard | 15% | Mountain-zone Stage 3 evolutions |
| Elder Treant | Treant Heartwood | 15% | Forest-zone Stage 3 evolutions (multiple beasts share this) |
| Orc Overlord | Orc Warbrand Fragment | 15% | Volcano-zone Stage 3 evolutions |
| Abyssal Demon Lord | Abyss Essence | 15% | Abyss-zone Stage 3 evolutions |

Individual beast Stage 3 evolution materials map to specific bosses — see BEAST.md per-entry Lore Notes for the exact item name and drop rate per beast.

### 15.5 NPC Battle Drop

| Drop | Condition | Amount |
|---|---|---|
| Silver | Win | Zone range (see §13.2) |
| XP | Win | `npc_avg_pet_level × 50` |
| Bonus Gold | Volcano / Abyss NPC only | 1–5 Gold (Volcano); 5–15 Gold (Abyss) |

---

## 16. Reward Distribution

### 16.1 XP Distribution

XP from each battle source is split **equally** across all pets that participated in the battle (i.e., were sent out at any point — not just the winning pet).

```lua
total_xp    = compute_xp(battle_type, opponent)
active_pets = get_participated_pets(player, battle_id)
xp_per_pet  = math.floor(total_xp / #active_pets)

for _, pet in ipairs(active_pets) do
    pet.XP = pet.XP + xp_per_pet
    while pet.XP >= xp_to_next_level(pet.Level) do
        pet.XP = pet.XP - xp_to_next_level(pet.Level)
        pet.Level = pet.Level + 1
        apply_growth(pet)  -- add growth stats
        check_level_milestones(pet)  -- element unlock at 50, etc.
    end
end
```

**XP to next level:** `math.floor(50 × level ^ 1.15)`

**Double XP Game Pass:** Multiply `total_xp` by 2 before distribution.  
**XP Boost Dev Product (1h):** Multiply `total_xp` by 3 for duration of boost.  
Both can be active simultaneously: multiply by 2 × 3 = 6× total.

### 16.2 XP Per Battle Source

| Source | XP Formula |
|---|---|
| Wild beast defeated | `beast_level × 30` |
| NPC trainer defeated | `npc_avg_pet_level × 50` |
| PvP win | `opponent_avg_pet_level × 75` |
| Dungeon monster kill | `monster_level × 20` |
| Dungeon boss kill | `boss_level × 150` |

### 16.3 Currency Distribution

Silver and Gold rewards are added directly to `PlayerData.Silver` and `PlayerData.Gold` after `BATTLE_END`. No splitting — full reward goes to the winning player.

For co-op dungeon: split Silver and Gold equally between both players. Each player gets their own independent loot roll (not shared).

**Hunter's VIP Game Pass:** +25% to Silver and Gold from all battle types. Apply as `math.floor(base_reward × 1.25)`.

### 16.4 Level-Up Growth Application

When a pet levels up, apply per-level growth stats:

```lua
function apply_growth(pet)
    local g = species_config[pet.SpeciesId].growth
    pet.BaseHP      = pet.BaseHP + g.HP
    pet.BaseStamina = pet.BaseStamina + g.Stamina
    pet.BaseATK     = pet.BaseATK + g.ATK
    pet.BaseDEF     = pet.BaseDEF + g.DEF
    pet.BaseSPD     = pet.BaseSPD + g.SPD
    -- Recalculate current effective stats (with evolution multiplier if evolved)
    recalculate_stats(pet)
end
```

Evolution stage multiplier is reapplied after each level-up: `effective_stat = base_stat × evo_multiplier` where Stage 1 = ×1.0, Stage 2 = ×1.3, Stage 3 = ×1.7.

### 16.5 Level Milestones

| Level | Unlock |
|---|---|
| 20 (Common) / 30 (Uncommon) / 50 (Rare) / 75 (Epic) / 100 (Legendary) | Stage 2 evolution available |
| 50 | Element imbuing available |
| 100 (Common) / 150 (Uncommon) / 200 (Rare) / 300 (Epic) / 500 (Legendary) | Stage 3 evolution available |
| 1,000 | Max level; XP continues to accumulate but triggers a cosmetic "Mastered" flag |

---

## 17. Special Mechanics Reference

### 17.1 Always-First Skill Rule Summary

See §4.2 for full details. When any pet uses an always-first skill:
- That pet's action goes first regardless of SPD
- Collision: raw SPD tiebreaker, then random
- This is distinct from Aerial Predator (passive priority on turn 1, see §4.2)

### 17.2 Turn-1-Only Mechanics

| Skill / Passive | Beast | Turn 1 Condition | After Turn 1 |
|---|---|---|---|
| Ambush Lunge | Crocodile | ×2.5 power | Drops to ×1.2 permanently |
| Aerial Slam | Hawk (Stage 2) | ×2.5 power | Drops to ×1.8 |
| Aerial Predator | Hawk | Turn 1 always-first | No effect after turn 1 |

Implementation: track `battle_turn_counter` per battle. Check `== 1` at cast time for the power switch. Track `ambush_lunge_used` as a per-battle-per-pet flag for Crocodile.

### 17.3 Self-Imposed Modifiers (Cannot Be Cleansed)

The following ATK/DEF reductions are self-imposed and are NOT stored in `ActiveEffects`. They cannot be removed by Purify or any debuff-clear skill:

| Source | Modifier | Duration |
|---|---|---|
| Fortress Mode (Armadillo) | ATK ×0.5 | 3T |
| Grand Levee (Beaver) | ATK ×0.75 + damage received ×0.80 | 3T |
| Reckless Strike (Wolverine) | DEF ×0.80 for 1T after use | 1T |

Store these as entries in a separate `self_modifiers` table on the pet. Apply alongside `ActiveEffects` modifiers but mark them as `cannot_cleanse = true`.

### 17.4 Buff / Debuff Cleanse

Skills labelled "Cleanse" (e.g. Shed Skin) remove entries from `target.ActiveEffects`:

```lua
function cleanse_debuffs(pet, count)
    -- Remove oldest count entries that are debuffs (not buffs)
    -- Sort ActiveEffects by application order; remove first 'count' debuffs found
end
```

Buff-clear skills (e.g. Celestial Pounce, Moon Fang) remove entries from `target.ActiveBuffs`:

```lua
function clear_buffs(pet, count)
    -- Remove oldest count entries that are buffs (ATK/DEF/SPD boost type)
end
```

Aura effects (`aura_spd_penalty` from Constrictor, passive bonuses) are never affected by cleanse or clear.

### 17.5 Stamina Management

At battle start, `pet.Stamina = pet.MaxStamina` (full). Stamina is spent by skill use. If a pet does not have enough Stamina for a chosen skill, the action falls back to basic Attack (server override — client should grey out unavailable skills to prevent this).

Stamina does not regenerate during battle (no per-turn regen mechanic). Regen skill heals HP, not Stamina. The Stamina Potion restores 50% MaxStamina and can be used between waves in a dungeon.

### 17.6 Swap Pet Rules

- Swapping costs a turn
- The incoming pet starts with its current HP and Stamina (not restored on swap)
- Buffs and debuffs on the swapped-out pet are preserved (not cleared on bench)
- The opponent does not lose their action on the turn a swap occurs — both sides act normally

### 17.7 Draw Condition

After 50 turns with no winner, battle ends as a draw:
- PvP: 0 rep change for both parties
- Wild Hunt: beast escapes; no rewards; energy already spent
- Dungeon: treat as wave cleared with partial loot (boss draw = 0 boss loot; wave loot from already-killed monsters kept)
- NPC: no reward; NPC cooldown does not reset (battle counts as having occurred)

---

## 18. Glossary

| Term | Definition |
|---|---|
| **ActiveEffects** | Per-pet array of active status effects, each with `{type, duration, magnitude}`. Decremented each turn. |
| **ATK** | Attack stat. Used as the base multiplier in damage formulas. |
| **Always-First** | Skill flag that forces the using pet's action to queue at position 0 this turn, before SPD ordering. |
| **Armor Break** | Status debuff: target DEF −30%, 2T. Stacks up to 3 independent entries. |
| **Aura Effect** | A passive area modifier stored outside `ActiveEffects`; cannot be cleansed. Example: Constrictor SPD drain. |
| **Base Rate** | Trap's raw capture probability before formula modifiers. Range: 0.30–0.90. |
| **battle_turn_counter** | Integer tracking the current turn number within a battle, starting at 1. |
| **Bind** | Control effect: target skips its next turn. Identical to Freeze in resolution. Applied by physical constriction skills. |
| **Blind** | Debuff: 50% chance target's offensive action misses (0 damage, no procs). 2T. |
| **Bleed** | DOT: variable % MaxHP per turn. Applied by physical slash skills. |
| **Boss** | Wave 8 dungeon monster. Immune to Bind. 50% SPD debuff resistance. |
| **Burn** | DOT: −5% MaxHP per turn. 3T. Fire element source. |
| **Capture** | In-battle action consuming a Trap to attempt ownership of a wild beast or capturable dungeon monster. |
| **Charge Token** | Hamster-specific resource; see BEAST.md 030 for full mechanic. |
| **Codex** | Player record of all species captured. Completion unlocks milestone rewards and titles. |
| **Constrictor** | Anaconda passive aura. Target SPD −5% per elapsed turn, cumulative, max −30%. Not a status effect; cannot be cleansed. |
| **DEF** | Defense stat. Subtracted from raw ATK before damage is dealt. |
| **DEF-Ignore** | Skill modifier that partially bypasses target DEF in the damage formula. |
| **DOT** | Damage Over Time. Tick fires at `TURN_START` before the affected pet acts. Includes Burn, Poison, Bleed. |
| **Draw** | Battle ends with no winner after 50 turns. No rewards; no rep change. |
| **Dungeon Key** | Developer Product. Grants +1 run to any dungeon today. |
| **Dungeon Run** | A full dungeon session: 8 waves ending with a boss. Costs 25 Hunt Energy. |
| **Dungeon Veteran** | Game Pass. +1 daily run per dungeon; auto-collects loot per wave. |
| **Elemental Multiplier** | Damage modifier based on attacker/defender element matchup: ×1.5 strong, ×0.5 weak, ×1.0 neutral. |
| **Evolution Crystal** | Required material for Stage 3 evolution. Rare dungeon boss drop. |
| **Evolution Shard** | Required material for Stage 2 evolution. Common dungeon boss drop. |
| **Flee** | In-battle action to escape. 70% base success. Not available in PvP or NPC battles. |
| **Freeze** | Control: target skips next turn. 1T. Ice element source. |
| **Fox Fire** | Kitsune passive. 20% chance per offensive skill to mark target; at 3 marks, auto-detonate ×1.5 Fire Elemental burst. |
| **Growth** | Per-level stat increase values defined in species config. Applied each time a pet levels up. |
| **HP Factor** | `1 - (current HP / MaxHP)`. Used in capture formula — higher when target is lower HP. |
| **Hunt Energy** | Player resource capped at 100. Wild encounters cost 10; dungeon runs cost 25. Regens 10/hr lazily. |
| **Iron Trap** | Mid-tier trap; base capture rate 0.50. |
| **Legend Trap** | Best trap; base capture rate 0.90. |
| **Lunar Rage** | Werewolf passive. Alternates ATK +25% (odd turns) and SPD +25% (even turns). |
| **MaxHP / MaxStamina** | The pet's HP/Stamina ceiling at its current level and evolution stage. Used for tick and heal calculations. |
| **Pack Leader** | Wolf passive. Killing blow grants +15% ATK stack (max 3 stacks, +45% total). |
| **Passive** | Species-specific always-on ability evaluated at defined trigger hooks. Not stored in ActiveEffects. |
| **Petrifying Gaze** | Basilisk battle-start passive. 20% chance opponent skips turn 1. Fires in INIT phase. |
| **Poison** | DOT: −3% MaxHP per turn. 5T. Nature/Dark source. |
| **Power Multiplier** | Skill stat: the multiplier applied to ATK in the skill damage formula. Range ×0.8–×3.5. |
| **Priority** | Action queue order flag. `0 = always-first`, `1 = normal`. Sorted ascending before SPD ordering. |
| **Rarity Modifier** | Divisor in capture formula: Common=1.0, Uncommon=1.5, Rare=2.5, Epic=5.0, Legendary=10.0. |
| **Regen** | Buff: +5% MaxHP/turn. 3T. Not cleansable as it is a buff (only debuff-clear applies to debuffs). |
| **Reputation (Rep)** | PvP ranking metric. Earns on win; loses on defeat. Never drops below 0 or below current Sub I floor. |
| **Self-Modifier** | ATK/DEF change applied by the pet to itself (not an opponent debuff). Cannot be cleansed. |
| **Shock** | Debuff: −25% SPD. 2T. Electric element source. |
| **Stamina (SP)** | Resource consumed by skill use. Starts full each battle. Not regenerated mid-battle. |
| **Storm Conductor** | Thunderbird passive. +10% ATK per Electric skill used (max 6 stacks = +60%). Resets on non-Electric/non-Wind use. |
| **Status Effect** | Temporary condition stored in ActiveEffects. Includes DOTs, control, debuffs, and buffs. |
| **Swap Pet** | Action: replace active pet with a benched roster pet. Costs a turn. |
| **Taunt** | Control buff: forces opponent to target the Taunted pet. 2T. Bypassed by King's Judgment and Stubborn Stance. |
| **Tick** | One application of a DOT or Regen effect at the start of an affected pet's turn. |
| **Turn 1** | `battle_turn_counter == 1`. Several mechanics trigger only on this turn (Aerial Predator, Ambush Lunge boost). |
| **Undying Grit** | Wolverine passive. Once per battle: survive at 1 HP instead of dying; then +30% ATK permanently. |
| **Wave** | One sub-battle within a dungeon run. 8 waves per run; wave 8 is the boss. |
| **Wild Hunt** | Battle type vs a roaming world beast. Flee allowed. Capture available below 50% HP. |
| **XP Split** | XP reward divided equally among all pets that participated (were active) in the battle. |
