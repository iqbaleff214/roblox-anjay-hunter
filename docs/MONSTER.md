# Monster Glossary — Anjay Hunter

**Version:** 1.0  
**Status:** In Progress  
**Cross-reference:** GDD.md §7 (Monster System), §8 (Battle System), docs/BATTLE.md

---

## Table of Contents

1. [Overview](#1-overview)
2. [Monster vs Beast](#2-monster-vs-beast)
3. [Stat Formula](#3-stat-formula)
4. [AI Behaviour System](#4-ai-behaviour-system)
5. [Boss Phase Mechanics](#5-boss-phase-mechanics)
6. [Monster Index](#6-monster-index)
7. [Entries](#7-entries)

---

## 1. Overview

Monsters are hostile entities found **exclusively inside Dungeons**. Unlike wild Beasts (which can always be captured), most monsters cannot be captured. They exist to challenge players in structured combat across 5 dungeon tiers. Each dungeon has a roster of common monsters across waves 1–7 and a unique Boss in wave 8.

---

## 2. Monster vs Beast

| Property | Monster | Beast |
|---|---|---|
| Location | Dungeon waves only | Open world (zone field) |
| Capturable | Most: No (exceptions: Slime, Goblin) | Always capturable below 50% HP |
| Level scaling | Dynamic per wave (see §3) | Random within zone range |
| Loot | Silver + species drops + boss table | Silver only |
| AI | Weighted random or scripted rotation | Weighted random |
| Can flee from | Yes (exits entire run) | Yes (70% chance per turn) |
| Counts toward Codex | No | Yes |

---

## 3. Stat Formula

Monster stats are **not fixed** — they scale with the monster's level, which is determined by the dungeon zone and wave number.

### 3.1 Monster Level Per Wave

```lua
zone_max_level = { forest=100, mountain=300, volcano=600, abyss=1000 }
level_step     = math.floor(zone_max_level[zone] * 0.08)
wave_level     = zone_entry_level + (wave_number - 1) * level_step
-- Boss (wave 8) level = zone_entry_level + 7 * level_step
-- Boss level capped at zone_max_level + level_step for Abyss tier
```

**Wave level reference by dungeon:**

| Dungeon | Zone Entry Lv | Level Step | Wave 1 | Wave 4 | Wave 7 | Boss (Wave 8) |
|---|---|---|---|---|---|---|
| Forest Cave | 21 | 8 | 21 | 45 | 69 | 77 |
| Mountain Ruins | 101 | 24 | 101 | 173 | 245 | 269 |
| Dark Forest | 101 | 24 | 101 | 173 | 245 | 269 |
| Volcano Pit | 301 | 48 | 301 | 445 | 589 | 637 |
| Abyss Rift | 601 | 80 | 601 | 841 | 1,081* | 1,161* |

*Capped at 1,000 if monster level exceeds max level cap for the Abyss zone.

### 3.2 Stat Calculation

```lua
stat_at_level = math.floor(level * stat_multiplier)
-- Minimum 1 for all stats
```

Each monster species has per-stat multipliers defined in the monster config. Refer to individual entries for their multipliers.

### 3.3 Boss HP Phase Tracking

Boss HP is an absolute value (not regenerated between dungeon runs). If the player flees and re-enters the same day, the boss resets to full HP. Boss HP is tracked per-instance, not per-server.

---

## 4. AI Behaviour System

### 4.1 Common Monster AI

Common and Rare dungeon monsters use a **weighted random action selector** evaluated at the start of each action:

```lua
action_weights = {
    basic_attack = 30,   -- always available
    skill_1      = 40,   -- skill with cooldown check
    skill_2      = 20,   -- skill with cooldown check
    passive      = --     -- evaluated inline, not a selected action
}
-- Normalise weights for available actions (remove skills on cooldown)
-- Roll weighted random; execute chosen action
```

Cooldowns are tracked per battle as a turn counter: `cooldown_remaining -= 1` each turn.

### 4.2 Boss AI

Bosses use a **scripted priority rotation** — they do not use weighted random. Each turn, the boss selects the highest-priority skill that is not on cooldown and whose condition is met:

```lua
-- Example boss priority check (evaluated top to bottom each turn)
if phase == 2 and ultimate_skill.cooldown == 0 then use(ultimate_skill)
elseif heavy_skill.cooldown == 0 then use(heavy_skill)
elseif debuff_skill.cooldown == 0 then use(debuff_skill)
else use(basic_attack)
end
```

This makes bosses feel deliberate and counterable rather than random.

### 4.3 Passive AI Evaluation

Monster passives are evaluated identically to pet passives (see BATTLE.md §9). They fire at the defined trigger hook and do not consume a turn.

---

## 5. Boss Phase Mechanics

All bosses have **2 phases** (standard) or **3 phases** (endgame bosses: Orc Overlord, Abyssal Demon Lord). Phase transitions are HP-threshold triggers:

- **Phase 2:** Triggered once when HP drops at or below a threshold (typically 50–60%)
- **Phase 3 (endgame only):** Triggered once when HP drops at or below a lower threshold (typically 30%)

Phase changes are **one-way** — a boss cannot revert to a previous phase. Phase change effects apply immediately and are permanent for the remainder of the battle.

**Phase change implementation:**
```lua
function check_phase_change(boss)
    local hp_pct = boss.HP / boss.MaxHP
    if not boss.phase2_triggered and hp_pct <= boss.phase2_threshold then
        boss.phase2_triggered = true
        apply_phase2_effects(boss)  -- permanent stat changes, new skill unlocks
    end
    if boss.has_phase3 and not boss.phase3_triggered and hp_pct <= boss.phase3_threshold then
        boss.phase3_triggered = true
        apply_phase3_effects(boss)
    end
end
-- Call after every damage application to boss
```

**Boss immunities (all bosses):**
- Immune to **Bind** (Bind effects fail silently — no status is applied)
- **50% resistance** to all SPD debuffs (Shock, Constrictor, etc.) — `spd_debuff × 0.5`

---

## 6. Monster Index

| ID | Name | Dungeon | Type | Rarity | Capturable | Boss? |
|---|---|---|---|---|---|---|
| 001 | Goblin | Forest Cave | Humanoid | Common | Yes (Iron Trap+) | No |
| 002 | Slime | Forest Cave | Elemental | Common | Yes (Iron Trap+) | No |
| 003 | Goblin Warchief | Forest Cave | Humanoid | Boss | No | Yes |
| 004 | Skeleton | Mountain Ruins | Undead | Common | No | No |
| 005 | Lich King | Mountain Ruins | Undead | Boss | No | Yes |
| 006 | Elf Archer | Dark Forest | Humanoid | Common | No | No |
| 007 | Elder Treant | Dark Forest | Nature | Boss | No | Yes |
| 008 | Orc | Volcano Pit | Humanoid | Common | No | No |
| 009 | Orc Overlord | Volcano Pit | Humanoid | Boss | No | Yes |
| 010 | Demon | Abyss Rift | Demon | Common | No | No |
| 011 | Abyssal Demon Lord | Abyss Rift | Demon | Boss | No | Yes |

---

## 7. Entries

---

## 001 · Goblin `Common`

**Dungeon:** Forest Cave (`dungeon_forest`)  
**Zone:** Forest (`zone_forest`)  
**Type:** Humanoid  
**Capturable:** Yes — requires **Iron Trap** or better; only during the wave Goblin appears (waves 1–7)  
**Wave Appearances:** Waves 1–7 (appears in most waves; see wave composition in BATTLE.md §11.2)  

> *"Individually worthless. In groups, a genuine problem. The Goblin Warchief did not unite the goblin tribes through strength or charisma. It simply promised them they could steal from anyone who wandered into the forest."*

**Behaviour:** Aggressive. Rushes the player immediately. Prioritises skills over basic attack when off cooldown. If another Goblin is alive in the same wave, ATK is passively boosted — AI does not change its priority targeting based on this, but damage increases noticeably. Uses Pickpocket when no skills are available (low roll).

**Stats (multiplier × level):**

| Stat | Multiplier | Example Lv 21 (Wave 1) | Example Lv 69 (Wave 7) |
|---|---|---|---|
| HP | `level × 15` | 315 | 1,035 |
| ATK | `level × 3` | 63 | 207 |
| DEF | `level × 1` | 21 | 69 |
| SPD | `level × 2` | 42 | 138 |

**Abilities:**

| | Name | Type | Trigger | Effect |
|---|---|---|---|---|
| ★ | Basic Attack | Physical | Default (every turn if no skill available) | Standard physical hit at 1.0× ATK |
| | Shiv | Physical | 40% chance per turn | 1.5× ATK; no status effect; quick stab |
| | Group Tactics | Passive | While ≥1 other Goblin is alive in same wave | Own ATK +15% (re-evaluated each turn) |
| | Pickpocket | Special | 10% chance per turn | Target loses 1 random consumable from inventory (if any); no damage; fails silently if no consumables |

**Drop Table:**

| Item | Rate | Quantity | Notes |
|---|---|---|---|
| Silver | 100% | `level × 5` | — |
| Gold | 2% | `math.floor(level × 0.1)`, min 1 | — |
| Goblin Dagger | 8% | 1 | Collectible; sell for Silver |
| Iron Trap | 4% | 1 | Useful for capturing later waves |
| Basic Trap | 5% | 1 | — |
| Goblin Coin | 3% | 1–3 | Collectible; common currency flavour item |

**Dev Notes:**
- Goblin capture uses standard capture formula (BATTLE.md §10); Goblin is Uncommon rarity in the formula (`rarity_modifier = 1.5`) despite being listed as a Common dungeon monster — this reflects its status as a pet species, not its dungeon spawn frequency
- `Pickpocket` selects a random index from `player.Inventory.Consumables`; if empty, the ability does nothing this turn (no fallback action); log a no-op
- `Group Tactics` passive: scan wave for living Goblins (not including self); if count ≥ 1, apply `atk_modifier = 1.15`; recompute each turn since Goblins may die mid-wave
- When captured as a pet: spawns as Goblin (species `goblin`, stage 1) at the level it was captured at

---

## 002 · Slime `Common`

**Dungeon:** Forest Cave (`dungeon_forest`)  
**Zone:** Forest (`zone_forest`)  
**Type:** Elemental  
**Capturable:** Yes — requires **Iron Trap** or better; only during waves Slime appears (waves 1–5)  
**Wave Appearances:** Waves 1–5 (replaced by Hobgoblin / Giant Bat in later waves)  

> *"The Slime predates the forest. Long before the Treant took root, before the Goblins built their warrens, the Slime simply sat there, absorbing whatever it touched. It has no ambitions. It has no enemies. It has no idea you are there — and yet here you are."*

**Behaviour:** Passive-aggressive. Does not rush; waits for its turn then attacks methodically. Attempts Absorb whenever HP drops below 70%. Activates Split Defense reactively — 30% chance each turn regardless of HP. Sticky Touch procs on every basic attack hit.

**Stats (multiplier × level):**

| Stat | Multiplier | Example Lv 21 (Wave 1) | Example Lv 61 (Wave 6) |
|---|---|---|---|
| HP | `level × 22` | 462 | 1,342 |
| ATK | `level × 2` | 42 | 122 |
| DEF | `level × 2` | 42 | 122 |
| SPD | `level × 1` | 21 | 61 |

**Abilities:**

| | Name | Type | Trigger | Effect |
|---|---|---|---|---|
| ★ | Slime Spit | Physical | Default | 1.0× ATK; on hit, 25% Shock (SPD −25%, 2T) |
| | Split Defense | Self-Buff | 30% chance per turn (no cooldown) | Own DEF +30%, 1T; reflects 10% incoming damage as Physical to attacker |
| | Absorb | Self-Heal | 20% chance per turn (no cooldown) | Heals self 10% MaxHP; no damage |
| | Ooze Coat | Passive | Constant | Immune to Poison and Bleed (body composition); takes +25% damage from Fire element |

**Drop Table:**

| Item | Rate | Quantity | Notes |
|---|---|---|---|
| Silver | 100% | `level × 5` | — |
| Gold | 2% | `math.floor(level × 0.1)`, min 1 | — |
| Slime Essence | 10% | 1 | Collectible; also accepted by Slime Stage 3 evolution chain |
| HP Potion (Small) | 6% | 1 | — |
| Basic Trap | 4% | 1 | — |

**Dev Notes:**
- Slime capture: uses `rarity_modifier = 1.0` (Common) in formula — Slime is genuinely easier to capture than Goblin
- `Ooze Coat` immunity: add `"Poison"` and `"Bleed"` to `monster.immune_effects`; when applying those effects via `apply_effect()`, check target's `immune_effects` first; if immune, suppress without proc message
- `Split Defense` and `Absorb` are both checked independently each turn — it is possible (though rare) for both to trigger in the same turn if the Slime rolls both 30% and 20% on the same turn; implement as two separate rolls
- Fire elemental bonus: stored as `elemental_vulnerability = { Fire = 1.25 }` on the monster config; multiply incoming Fire damage by 1.25 after standard elemental multiplier

---

## 003 · Goblin Warchief `Boss`

**Dungeon:** Forest Cave (`dungeon_forest`)  
**Zone:** Forest (`zone_forest`)  
**Type:** Humanoid  
**Capturable:** No  
**Wave:** 8 (Boss)  
**Boss Level:** 77 (zone entry 21 + 7 × step 8)  

> *"Three Goblin Warchief crowns have been found over the centuries. Each is slightly dented in the same spot. No one has ever asked why."*

**Behaviour:** Scripted priority rotation (see §4.2). In Phase 1, cycles through Warbrand Slash → Shield Bash → Battle Cry with basic attacks to fill gaps. In Phase 2, activates Goblin King's Rage immediately and begins using Crown Throw on every available cooldown. Prioritises surviving targets with lower HP if party mechanic is ever implemented.

**Phase Thresholds:**

| Phase | HP Threshold | Trigger Effect |
|---|---|---|
| Phase 1 | 100%–51% | Standard rotation |
| Phase 2 | ≤50% HP | **Goblin King's Rage:** Own ATK permanently +25%; Crown Throw becomes available; one-time trigger |

**Stats at Boss Level (Lv 77):**

| Stat | Multiplier | Value at Lv 77 |
|---|---|---|
| HP | `level × 50` | 3,850 |
| ATK | `level × 4` | 308 |
| DEF | `math.floor(level × 1.5)` | 115 |
| SPD | `level × 2` | 154 |

**Abilities:**

| | Name | Type | Phase | Cooldown | Effect |
|---|---|---|---|---|---|
| ★ | Warbrand Strike | Physical | 1–2 | 0 (default) | 1.0× ATK; basic attack fallback |
| | Warbrand Slash | Physical | 1–2 | 3T | 2.5× ATK; 35% Armor Break (DEF −30%, 2T) |
| | Shield Bash | Physical | 1–2 | 2T | 1.0× ATK; 40% Armor Break; off-hand bash |
| | Battle Cry | Self/Ally Buff | 1–2 | 4T | Own ATK +30% & DEF +20%, 3T; all surviving Goblins in same wave (if wave 7 lingers in extended-co-op variant) get ATK +20%, 2T |
| | Goblin King's Rage | Phase-Change | Phase 2 trigger | Once | Own ATK permanently +25%; unlocks Crown Throw |
| | Crown Throw | Physical | Phase 2 | 4T | 3.5× ATK; ignores 30% target DEF; "the crown itself as projectile" |

**Drop Table:**

| Item | Rate | Quantity | Notes |
|---|---|---|---|
| Silver | 100% (guaranteed) | `77 × 50 = 3,850` | — |
| Gold | 100% (guaranteed) | 10–20 (random range) | Forest Cave boss range |
| Evolution Shard | 60% | 1 | Primary farming target for early evolution |
| Rare Collectible | 40% | 1 | Random rare collectible item |
| Evolution Crystal | 20% | 1 | — |
| Goblin Warchief Crown | 15% | 1 | Species-specific evo item; used for Goblin Warchief Stage 3 evolution |
| Legend Trap | 5% | 1 | — |
| HP Potion (Large) | 10% | 1 | — |
| Stamina Potion | 10% | 2 | — |

**Dev Notes:**
- Phase 2 ATK bonus is a permanent `battle_passive_modifier_atk += 0.25` applied at phase transition; it stacks additively with any other ATK modifiers active at that moment
- `Crown Throw` is unavailable in Phase 1 — remove it from the skill pool entirely until `phase2_triggered == true`; do not just increase cooldown
- `Battle Cry` buff on surviving wave Goblins: scan `current_wave.alive_monsters` for species `"goblin"`; apply ATK buff to each; if none are alive, the self-buff portion (Warchief's own ATK/DEF) still applies — the skill does not fail
- The Warchief is a 2-phase boss (no Phase 3); the simplest boss in the game — intentional as tutorial introduction to boss phase mechanics

---

## 004 · Skeleton `Common`

**Dungeon:** Mountain Ruins (`dungeon_mountain`)  
**Zone:** Mountain (`zone_mountain`)  
**Type:** Undead  
**Capturable:** No  
**Wave Appearances:** Waves 1–7 (primary common enemy of Mountain Ruins)  

> *"It remembers nothing of its former self. The Lich King did not restore its memories when he raised it — only its capacity to follow orders. There is a mercy in that. The Skeleton does not know what it lost."*

**Behaviour:** Aggressive. Opens every battle with Bone Throw (always-first, once per battle). Follows up with Shatter on cooldown, then basic melee. Never retreats; attacks relentlessly until destroyed. Brittle Form passive makes it resistant to many status effects but extremely vulnerable to Fire and Light skills.

**Stats (multiplier × level):**

| Stat | Multiplier | Example Lv 101 (Wave 1) | Example Lv 245 (Wave 7) |
|---|---|---|---|
| HP | `level × 10` | 1,010 | 2,450 |
| ATK | `level × 5` | 505 | 1,225 |
| DEF | `math.floor(level × 0.5)` | 50 | 122 |
| SPD | `math.floor(level × 2.5)` | 252 | 612 |

**Abilities:**

| | Name | Type | Trigger | Effect |
|---|---|---|---|---|
| ★ | Bone Strike | Physical | Default | 1.0× ATK; melee hit |
| | Bone Throw | Physical | Always-first; once per battle | 1.5× ATK; ranged; fires at battle start before melee range — always goes first on turn 1 regardless of SPD (same rule as BATTLE.md §4.2 always-first family) |
| | Shatter | Physical | Cooldown 3T | 1.0× ATK; 40% Armor Break (DEF −30%, 2T) |
| | Brittle Form | Passive | Constant | Immune to Poison and Bleed; takes +50% bonus damage from Fire and Light element attacks |

**Drop Table:**

| Item | Rate | Quantity | Notes |
|---|---|---|---|
| Silver | 100% | `level × 5` | — |
| Gold | 2% | `math.floor(level × 0.1)`, min 1 | — |
| Bone Shard | 8% | 1–2 | Collectible; crafting/selling |
| Lich Bone Shard | 2% | 1 | Rare collectible; also used for Mountain-zone Stage 3 evolutions; higher drop from Lich King boss |
| HP Potion (Small) | 4% | 1 | — |

**Dev Notes:**
- `Brittle Form` Fire/Light vulnerability: store as `elemental_vulnerability = { Fire = 1.50, Light = 1.50 }` in monster config; multiply incoming damage of those types by 1.50 after the standard elemental multiplier is applied
- `Bone Throw` always-first: implement using the same `priority = 0` queue flag as the always-first pet skill family; only valid on turn 1 (`battle_turn_counter == 1`); subsequent turns it loses always-first priority and uses normal cooldown (set cooldown to 0 after turn 1 use so it cannot be used again — it's a one-per-battle once-per-battle mechanic)
- Skeleton is a glass-cannon archetype — very high ATK and SPD, very low HP and DEF; players with DEF-stacking pets or ATK debuffs (Armor Break, Primal Roar) shut this enemy down quickly

---

## 005 · Lich King `Boss`

**Dungeon:** Mountain Ruins (`dungeon_mountain`)  
**Zone:** Mountain (`zone_mountain`)  
**Type:** Undead  
**Capturable:** No  
**Wave:** 8 (Boss)  
**Boss Level:** 269 (zone entry 101 + 7 × step 24)  

> *"It was a court wizard once. It studied mortality for forty years, wrote twelve books on the subject, and concluded that the best solution was to simply opt out."*

**Behaviour:** Scripted priority rotation. Uses Soul Drain whenever available to sustain HP in Phase 1. Cycles Frost Bolt and Necrotic Curse in rotation — this means players fighting the Lich King face a steady stream of Freeze, Poison, and Armor Break simultaneously if unlucky. In Phase 2, unlocks Bone Army and Eternal Frost; prioritises Eternal Frost above all else in Phase 2.

**Phase Thresholds:**

| Phase | HP Threshold | Trigger Effect |
|---|---|---|
| Phase 1 | 100%–51% | Standard rotation |
| Phase 2 | ≤50% HP | **Lich's Defiance:** Own ATK permanently +20% & DEF permanently +20%; Eternal Frost and Bone Army become available; one-time trigger |

**Stats at Boss Level (Lv 269):**

| Stat | Multiplier | Value at Lv 269 |
|---|---|---|
| HP | `level × 55` | 14,795 |
| ATK | `level × 4` | 1,076 |
| DEF | `level × 2` | 538 |
| SPD | `math.floor(level × 1.5)` | 403 |

**Abilities:**

| | Name | Type | Phase | Cooldown | Effect |
|---|---|---|---|---|---|
| ★ | Staff Strike | Physical | 1–2 | 0 (default) | 1.0× ATK; default melee |
| | Frost Bolt | Ice Elemental | 1–2 | 2T | 1.8× ATK; 25% Freeze (skip 1T) |
| | Soul Drain | Dark Elemental | 1–2 | 3T | 1.2× ATK; heals Lich King for 100% of damage dealt |
| | Necrotic Curse | Dark | 1–2 | 4T | No damage; applies Poison (5T) + Armor Break (2T) simultaneously |
| | Lich's Defiance | Phase-Change | Phase 2 trigger | Once | Own ATK +20% & DEF +20% permanently; unlocks Eternal Frost and Bone Army |
| | Bone Army | Summon | Phase 2 | Once per battle | Summons 1 Skeleton spectre (`HP = boss_level × 5 = 1,345`; ATK and DEF scaled at half normal Skeleton values); spectral Skeleton acts once before fading — deals one Bone Strike hit then is removed |
| | Eternal Frost | Ice Elemental | Phase 2 | 5T | 3.5× ATK; 60% Freeze; Phase 2 priority skill |

**Drop Table:**

| Item | Rate | Quantity | Notes |
|---|---|---|---|
| Silver | 100% (guaranteed) | `269 × 50 = 13,450` | — |
| Gold | 100% (guaranteed) | 25–50 (random) | Mountain Ruins boss range |
| Evolution Shard | 60% | 1 | — |
| Rare Collectible | 40% | 1 | — |
| Evolution Crystal | 20% | 1 | — |
| Lich Bone Shard | 15% | 1 | Species evo item; used for Mountain-zone Stage 3 evolutions |
| Legend Trap | 5% | 1 | — |
| HP Potion (Large) | 10% | 1 | — |
| Stamina Potion | 10% | 2 | — |

**Dev Notes:**
- `Soul Drain` heal: after damage is applied to target, compute `heal = math.floor(damage_dealt × 1.0)` and add to `boss.HP`, capped at `boss.MaxHP`; the heal uses the actual damage dealt (after elemental multiplier, DEF subtraction, and Blind miss check) — a missed Soul Drain due to Blind heals nothing
- `Bone Army` summon: the spectral Skeleton is a one-action temporary actor — insert it into the action queue for the current turn after the Lich King's action resolves; it attacks once with Bone Strike, then is removed from the queue permanently; it has no drops and cannot be targeted by the player (acting on its own turn only)
- `Eternal Frost` 60% Freeze: standard proc roll at `ACTION_RESOLVE`; Freeze is suppressed by boss Bind immunity note — Freeze is NOT Bind (Freeze is Ice-based control, Bind is physical constriction); Freeze CAN apply to the player's pet; the boss's own Bind immunity is irrelevant here
- Lich King is immune to Poison and Bleed (Undead type — same as Skeleton); add to `immune_effects`

---

## 006 · Elf Archer `Common`

**Dungeon:** Dark Forest (`dungeon_darkforest`)  
**Zone:** Mountain (`zone_mountain`)  
**Type:** Humanoid  
**Capturable:** No  
**Wave Appearances:** Waves 1–7 (primary common enemy of Dark Forest)  

> *"The elves did not turn hostile. They were always this way about their forest. Centuries of human hunters wandering in and calling it a dungeon simply confirmed their original assessment of the situation."*

**Behaviour:** Aggressive ranged fighter. Stays at distance (cosmetic flavour); always opens with an arrow skill on first available turn. Prioritises Piercing Arrow on cooldown; falls back to Arrow Shot. Uses Evasive Roll reactively — it fires on the Elf Archer's own turn as a defensive buff, not in response to being attacked. Nature's Arrow used when both damage skills are on cooldown.

**Stats (multiplier × level):**

| Stat | Multiplier | Example Lv 101 (Wave 1) | Example Lv 245 (Wave 7) |
|---|---|---|---|
| HP | `level × 12` | 1,212 | 2,940 |
| ATK | `level × 4` | 404 | 980 |
| DEF | `level × 1` | 101 | 245 |
| SPD | `level × 3` | 303 | 735 |

**Abilities:**

| | Name | Type | Trigger | Effect |
|---|---|---|---|---|
| ★ | Arrow Shot | Physical | Default | 1.0× ATK; ranged; ignores 10% DEF (arrows bypass armour at range) |
| | Piercing Arrow | Physical | Cooldown 3T | 1.5× ATK; ignores 20% DEF |
| | Nature's Arrow | Nature Elemental | Cooldown 3T | 1.2× ATK; 30% Poison (DOT: ×0.8/turn, 3T) |
| | Evasive Roll | Self-Buff | Cooldown 3T | 35% dodge chance for 1T; chosen on own turn as a defensive action (costs the Elf Archer its attack that turn — used when both damage skills are on cooldown and the Archer is low HP) |

**Drop Table:**

| Item | Rate | Quantity | Notes |
|---|---|---|---|
| Silver | 100% | `level × 5` | — |
| Gold | 2% | `math.floor(level × 0.1)`, min 1 | — |
| Elven Arrow | 8% | 1–3 | Collectible; bundle sell value |
| Elven Cloth | 5% | 1 | Collectible; rare textile |
| Iron Trap | 3% | 1 | — |
| HP Potion (Small) | 4% | 1 | — |

**Dev Notes:**
- Arrow Shot's 10% DEF ignore and Piercing Arrow's 20% DEF ignore: computed as `effective_def = target.DEF × (1 - ignore_pct)` before the damage formula — same as skill DEF-ignore in BATTLE.md §6.3
- `Evasive Roll` conditions: Elf Archer only uses Evasive Roll if BOTH `piercing_arrow.cooldown > 0` AND `natures_arrow.cooldown > 0` AND `self.HP / self.MaxHP < 0.50`; this prevents wasting the turn early in battle; implement as an explicit AI priority check before weighted random
- Elf Archer has the second-highest base SPD of any common monster in the game (after Demon); expect it to consistently go first in turn order against lower-level pets

---

## 007 · Elder Treant `Boss`

**Dungeon:** Dark Forest (`dungeon_darkforest`)  
**Zone:** Mountain (`zone_mountain`)  
**Type:** Nature  
**Capturable:** No  
**Wave:** 8 (Boss)  
**Boss Level:** 269 (zone entry 101 + 7 × step 24)  

> *"The Dark Forest grew around the Elder Treant, not the other way around. Every tree in the dungeon is technically one of its roots. You are fighting the forest itself. The forest would like you to know it is not particularly worried about the outcome."*

**Behaviour:** Slow, methodical, extremely high HP. Cycles Ancient Smash and Nature's Wrath in alternation; uses Vine Wrap between skill cooldowns to delay players. Bark Armor is used reactively when HP crosses below 70% for the first time, then used on cooldown. Phase 2 introduces Root Entanglement — a passive auto-bind that fires independent of its action each turn. Heartwood Pulse (once) fires automatically at the 50% HP threshold.

**Phase Thresholds:**

| Phase | HP Threshold | Trigger Effect |
|---|---|---|
| Phase 1 | 100%–51% | Standard rotation |
| Phase 2 | ≤50% HP | **Root Entanglement activates:** At the start of each turn, 30% chance to automatically apply Bind (1T) to the player's pet before the pet acts (free interrupt action — does not replace boss's normal turn action) |

**Stats at Boss Level (Lv 269):**

| Stat | Multiplier | Value at Lv 269 |
|---|---|---|
| HP | `level × 60` | 16,140 |
| ATK | `math.floor(level × 3.5)` | 941 |
| DEF | `math.floor(level × 2.5)` | 672 |
| SPD | `level × 1` | 269 |

**Abilities:**

| | Name | Type | Phase | Cooldown | Effect |
|---|---|---|---|---|---|
| ★ | Branch Slam | Physical | 1–2 | 0 (default) | 1.0× ATK; default melee |
| | Ancient Smash | Earth Elemental | 1–2 | 3T | 2.0× ATK; 35% Armor Break (DEF −30%, 2T) |
| | Vine Wrap | Physical Control | 1–2 | 3T | No damage; 60% Bind (skip 1T); hold |
| | Nature's Wrath | Nature Elemental | 1–2 | 3T | 1.8× ATK; Poison (DOT: 3% MaxHP/turn, 4T) |
| | Bark Armor | Self-Buff | 1–2 | 4T | Own DEF +40% & Regen (+5% MaxHP/turn, 3T); first use triggered reactively at HP <70% |
| | Heartwood Pulse | Self-Heal | Phase 2 entry | Once | Automatically heals 15% MaxHP at the moment HP crosses 50% threshold; fires before Root Entanglement activates |
| | Root Entanglement | Passive (Phase 2) | Phase 2 | — | At start of each turn: 30% chance to auto-Bind player pet (1T); free interrupt, not a selected action |

**Drop Table:**

| Item | Rate | Quantity | Notes |
|---|---|---|---|
| Silver | 100% (guaranteed) | `269 × 50 = 13,450` | — |
| Gold | 100% (guaranteed) | 60–120 (random) | Dark Forest boss range |
| Evolution Shard | 60% | 1 | — |
| Rare Collectible | 40% | 1 | — |
| Evolution Crystal | 20% | 1 | — |
| Treant Heartwood | 15% | 1 | Species evo item; used for Forest-zone Stage 3 evolutions (many beasts use this; see BEAST.md individual entries) |
| Legend Trap | 5% | 1 | — |
| HP Potion (Large) | 10% | 1 | — |
| Stamina Potion | 10% | 2 | — |

**Dev Notes:**
- `Heartwood Pulse` fires as an interrupt at phase transition — call `boss.HP += math.floor(boss.MaxHP × 0.15)` capped at `boss.MaxHP` immediately when `check_phase_change` detects the threshold crossing; this happens before `phase2_triggered` is set and before Root Entanglement is activated; order: Pulse → set phase2 flag → activate Root Entanglement
- `Root Entanglement` implementation: at `TURN_START`, after standard effect ticks but before the boss's action selection, roll 30%; if hit, call `apply_effect(player_pet, "Bind", 1, nil)`; this does NOT consume the boss's turn — the boss still selects and executes its normal action that turn; store the bind application as a pre-action interrupt in the turn sequence
- Elder Treant has the highest base DEF of any boss in the game (Lv 269 DEF = 672); players without DEF-ignore skills will struggle significantly; the design intent is that Armor Break (from skills like Ancient Smash ironically reflecting back via Gorilla Knuckle Guard, or player pet skills) is essential to defeating this boss comfortably
- Treant Heartwood shares a name pattern with Boss drops — it is the universal Forest-zone evo item meaning multiple beast species pull the same item from the same boss; 15% drop rate shared across all uses (it is not per-beast — one item type, multiple consumers)

---

## 008 · Orc `Common`

**Dungeon:** Volcano Pit (`dungeon_volcano`)  
**Zone:** Volcano (`zone_volcano`)  
**Type:** Humanoid  
**Capturable:** No  
**Wave Appearances:** Waves 1–7 (primary common enemy of Volcano Pit)  

> *"Orcs measure strength in scars. An Orc with no scars is new. An Orc that keeps getting new scars is either very brave or very bad at fighting. The Volcano Pit Orcs have never fully agreed on which is admirable."*

**Behaviour:** Slow and brutal. Opens with Crushing Blow on first available cooldown; uses Warcry when both damage skills are cooling down to maintain ATK pressure. Thick Hide passive is always active — its DEF already reflects this bonus. Does not flee or flinch at low HP.

**Stats (multiplier × level):**

| Stat | Multiplier | Example Lv 301 (Wave 1) | Example Lv 589 (Wave 7) |
|---|---|---|---|
| HP | `level × 20` | 6,020 | 11,780 |
| ATK | `math.floor(level × 3.5)` | 1,053 | 2,061 |
| DEF | `level × 2` | 602 | 1,178 |
| SPD | `math.floor(level × 1.5)` | 451 | 883 |

**Abilities:**

| | Name | Type | Trigger | Effect |
|---|---|---|---|---|
| ★ | Club Smash | Physical | Default | 1.0× ATK; heavy melee |
| | Warcry | Self-Buff | Cooldown 4T | Own ATK +25%, 2T |
| | Crushing Blow | Physical | Cooldown 3T | 1.8× ATK; 30% Armor Break (DEF −30%, 2T) |
| | Thick Hide | Passive | Constant | Own DEF +10% (already factored into stat multiplier; this is a display-only passive to communicate the archetype to players) |

**Drop Table:**

| Item | Rate | Quantity | Notes |
|---|---|---|---|
| Silver | 100% | `level × 5` | — |
| Gold | 2% | `math.floor(level × 0.1)`, min 1 | — |
| Orc Fang | 8% | 1 | Collectible |
| Iron Club Fragment | 5% | 1 | Collectible; used in crafting (if crafting system exists) or selling |
| Stamina Potion | 4% | 1 | — |
| Iron Trap | 2% | 1 | — |

**Dev Notes:**
- `Thick Hide` passive DEF +10% is **already baked into** the `DEF × 2.0` multiplier (effectively it would be `× 1.818` without the passive, but we just use `× 2.0` to represent the final value); do not apply an additional 10% modifier in runtime — it is a flavour passive, not a runtime calculation
- Orc is the highest base HP of any non-boss common monster (`× 20`); combined with high DEF, it is the tankiest common enemy in the game; players should bring ATK-stacking or DEF-ignore skills for Volcano Pit dungeon
- Orc appears in waves 1–7 of Volcano Pit alongside Troll and Lava Slime; the AI for each is independent; multiple Orcs in a wave do not share a Group Tactics equivalent — they are independently weak in groups (contrast with Goblin)

---

## 009 · Orc Overlord `Boss`

**Dungeon:** Volcano Pit (`dungeon_volcano`)  
**Zone:** Volcano (`zone_volcano`)  
**Type:** Humanoid  
**Capturable:** No  
**Wave:** 8 (Boss)  
**Boss Level:** 637 (zone entry 301 + 7 × step 48)  

> *"It has never actually been defeated. Previous adventurers who entered the Volcano Pit either fled, died, or became Orcs. The Overlord considers all three outcomes acceptable."*

**Behaviour:** Aggressive 3-phase boss. Most offensively demanding boss in the mid-tier bracket. Phase 1: alternates Warbrand Cleave and Volcanic Roar with basic attacks. Phase 2: immediately gains Warlord's Rage and starts using Rally Cry aggressively to mitigate status effects from the player. Phase 3: gains Feral Instinct (SPD spike) and uses Berserker Mode on cooldown — the combination of Phase 2 ATK bonus and Phase 3 double-hit can be lethal to underprepared players.

**Phase Thresholds:**

| Phase | HP Threshold | Trigger Effect |
|---|---|---|
| Phase 1 | 100%–61% | Standard rotation |
| Phase 2 | ≤60% HP | **Warlord's Rage:** Own ATK permanently +25%; Rally Cry and Siege Slam become available |
| Phase 3 | ≤30% HP | **Feral Instinct:** Own SPD permanently +25%; Berserker Mode becomes available |

**Stats at Boss Level (Lv 637):**

| Stat | Multiplier | Value at Lv 637 |
|---|---|---|
| HP | `level × 55` | 35,035 |
| ATK | `level × 5` | 3,185 |
| DEF | `level × 2` | 1,274 |
| SPD | `level × 2` | 1,274 |

**Abilities:**

| | Name | Type | Phase | Cooldown | Effect |
|---|---|---|---|---|---|
| ★ | Warbrand Strike | Physical | 1–3 | 0 (default) | 1.0× ATK |
| | Warbrand Cleave | Physical | 1–3 | 3T | 2.5× ATK; 35% Armor Break |
| | Volcanic Roar | Fire Elemental | 1–3 | 3T | 1.8× ATK; 40% Burn (DOT: 5% MaxHP/turn, 3T) |
| | Warlord's Rage | Phase-Change | Phase 2 trigger | Once | Own ATK permanently +25%; unlocks Rally Cry and Siege Slam |
| | Rally Cry | Self-Buff | Phase 2 | 4T | Own DEF +20% & immune to all status effects for 2T; powerful anti-debuff tool |
| | Siege Slam | Physical | Phase 2 | 5T | 3.5× ATK; ignores 25% target DEF; Phase 2 priority ultimate |
| | Feral Instinct | Phase-Change | Phase 3 trigger | Once | Own SPD permanently +25%; unlocks Berserker Mode |
| | Berserker Mode | Physical | Phase 3 | 4T | For the next 2T after use, deals 2 hits of 1.2× ATK per turn (replaces normal attack on those turns) |

**Drop Table:**

| Item | Rate | Quantity | Notes |
|---|---|---|---|
| Silver | 100% (guaranteed) | `637 × 50 = 31,850` | — |
| Gold | 100% (guaranteed) | 150–300 (random) | Volcano Pit boss range |
| Evolution Shard | 60% | 1 | — |
| Rare Collectible | 40% | 1 | — |
| Evolution Crystal | 20% | 1 | — |
| Orc Warbrand Fragment | 15% | 1 | Species evo item; used for Volcano-zone Stage 3 evolutions |
| Legend Trap | 5% | 1 | — |
| HP Potion (Large) | 10% | 1 | — |
| Stamina Potion | 10% | 2 | — |

**Dev Notes:**
- `Warlord's Rage` and `Feral Instinct` are permanent `battle_passive_modifier_atk` and `battle_passive_modifier_spd` respectively — applied identically to how Wolf Pack Leader stacks are stored; they stack with any existing modifiers additively
- `Rally Cry` status immunity: store as `immune_effects_temp` flag for 2T on the boss (similar to how boss immunity works but time-limited); during those 2T, calls to `apply_effect(boss, ...)` check the flag and return without applying; flag decrements with duration
- `Berserker Mode` double-hit: for the 2T duration after use, the boss's normal attack action is replaced with `for i = 1, 2 do deal_attack(1.2x) end`; the Phase 2 ATK bonus and Phase 3 SPD bonus both apply to these hits
- Three-phase boss design intent: players who reach Phase 3 with low HP resources (after long multi-wave dungeon) face a dramatically accelerated Overlord; intended as the hardest non-Abyss encounter

---

## 010 · Demon `Common`

**Dungeon:** Abyss Rift (`dungeon_abyss`)  
**Zone:** Abyss (`zone_abyss`)  
**Type:** Demon  
**Capturable:** No  
**Wave Appearances:** Waves 1–7 (primary common enemy of Abyss Rift alongside Wraith and Specter)  

> *"The Abyss does not create Demons. It collects them. Every spirit of cruelty, malice, and broken promise that has ever existed eventually sinks down here. The Demon you are fighting may have once been a merchant who cheated his customers. Or it may have always been exactly this."*

**Behaviour:** Highly mobile aggressive attacker. Fastest common monster in the game. Opens with Dark Pulse; cycles Soul Rend for sustained HP drain. Void Step fires passively at the start of its turn — 25% chance to dodge all incoming damage that turn. Demon engages without hesitation; no warning behaviour.

**Stats (multiplier × level):**

| Stat | Multiplier | Example Lv 601 (Wave 1) | Example Lv 1000 (Wave 7, capped) |
|---|---|---|---|
| HP | `level × 14` | 8,414 | 14,000 |
| ATK | `level × 5` | 3,005 | 5,000 |
| DEF | `level × 1` | 601 | 1,000 |
| SPD | `level × 4` | 2,404 | 4,000 |

**Abilities:**

| | Name | Type | Trigger | Effect |
|---|---|---|---|---|
| ★ | Shadow Claw | Dark Elemental | Default | 1.0× ATK; Dark-typed basic attack |
| | Dark Pulse | Dark Elemental | Cooldown 2T | 1.5× ATK; 25% Blind (accuracy −50%, 2T) |
| | Soul Rend | Dark Elemental | Cooldown 3T | 1.2× ATK; heals self 10% MaxHP |
| | Void Step | Passive | Constant (start of each turn) | 25% chance to dodge all incoming damage this turn; evaluated at start of Demon's turn before opponent acts — if dodge activates, a `dodging = true` flag is set for that turn |

**Drop Table:**

| Item | Rate | Quantity | Notes |
|---|---|---|---|
| Silver | 100% | `level × 5` | — |
| Gold | 2% | `math.floor(level × 0.1)`, min 1 | — |
| Demon Shard | 8% | 1 | Collectible |
| Void Crystal | 3% | 1 | Rare collectible; high sell value |
| Abyss Essence | 1% | 1 | Very rare from common Demon; guaranteed from boss |
| HP Potion (Large) | 4% | 1 | — |
| Legend Trap | 1% | 1 | Rare field drop; only common-monster source |

**Dev Notes:**
- `Void Step` dodge flag: at `TURN_START`, roll 25%; if hit, set `demon.dodging = true`; at `ACTION_RESOLVE` when the player's action targets the Demon, check `demon.dodging`; if true, all damage and status effects are completely nullified for that action; reset `demon.dodging = false` at end of the turn
- `Shadow Claw` is Dark Elemental typed — uncommon for a basic attack; this means it applies the elemental multiplier against the player's pet element for the basic attack too; useful if the player brings a Nature or Electric pet (Demon resists those with ×1.5 Dark advantage)
- Demon is the fastest common monster in the game (SPD ×4); at level 601 entry, a Demon SPD of 2,404 will consistently out-speed nearly any player pet that isn't specially SPD-built or using always-first skills; design intent is that Abyss enemies go first almost always

---

## 011 · Abyssal Demon Lord `Boss`

**Dungeon:** Abyss Rift (`dungeon_abyss`)  
**Zone:** Abyss (`zone_abyss`)  
**Type:** Demon  
**Capturable:** No  
**Wave:** 8 (Boss)  
**Boss Level:** 1,000 (capped; formula: 601 + 7 × 80 = 1,161; capped at zone max 1,000)  

> *"It does not rule the Abyss by defeating its rivals. It rules by being the only thing in the Abyss that the other Demons are afraid of. That is a much more stable form of authority."*

**Behaviour:** The most complex boss in the game. Three-phase escalation with a unique mechanic in each phase. Phase 1: cycles Abyssal Slash, Void Rupture, and Dark Assimilation — consistently strips buffs and applies multi-debuffs. Phase 2: Chaos Form changes all attacks to Dark Elemental and gains ATK permanently; Infernal Throne fires once as a defensive cooldown. Phase 3: Soul Absorption auto-heals passively each turn, significantly extending the fight; Eternal Darkness becomes priority skill.

**Phase Thresholds:**

| Phase | HP Threshold | Trigger Effect |
|---|---|---|
| Phase 1 | 100%–61% | Standard rotation |
| Phase 2 | ≤60% HP | **Chaos Form:** All attacks gain Dark Elemental typing; own ATK permanently +20%; Infernal Throne becomes available |
| Phase 3 | ≤30% HP | **Soul Absorption:** Own Regen activates — heals +5% MaxHP automatically at start of each turn (passive, cannot be suppressed); Eternal Darkness becomes available |

**Stats at Boss Level (Lv 1,000):**

| Stat | Multiplier | Value at Lv 1,000 |
|---|---|---|
| HP | `level × 65` | 65,000 |
| ATK | `level × 6` | 6,000 |
| DEF | `level × 2` | 2,000 |
| SPD | `math.floor(level × 2.5)` | 2,500 |

**Abilities:**

| | Name | Type | Phase | Cooldown | Effect |
|---|---|---|---|---|---|
| ★ | Abyssal Strike | Dark Elemental | 1–3 | 0 (default) | 1.0× ATK; Dark-typed default |
| | Abyssal Slash | Dark Elemental | 1–3 | 3T | 2.5× ATK; 40% Armor Break (DEF −30%, 2T) |
| | Void Rupture | Dark Elemental | 1–3 | 3T | 1.8× ATK; Blind (2T) + Shock (2T) applied simultaneously |
| | Dark Assimilation | Special | 1–3 | 3T | No damage; removes 1 active buff from player's pet; heals self 5% MaxHP |
| | Chaos Form | Phase-Change | Phase 2 trigger | Once | All skills gain Dark Elemental tag; own ATK permanently +20%; Infernal Throne available |
| | Infernal Throne | Self-Buff | Phase 2 | Once per battle | Own DEF +40% & immune to all status effects, 2T; sole defensive cooldown |
| | Soul Absorption | Phase-Change Passive | Phase 3 trigger | Permanent | Regen +5% MaxHP at start of each turn for the rest of battle; cannot be cleansed |
| | Eternal Darkness | Dark Elemental | Phase 3 | 5T | 3.5× ATK; applies Burn (3T) + Poison (5T) + Blind (2T) simultaneously; Phase 3 priority ultimate |

**Drop Table:**

| Item | Rate | Quantity | Notes |
|---|---|---|---|
| Silver | 100% (guaranteed) | `1,000 × 50 = 50,000` | Capped level used |
| Gold | 100% (guaranteed) | 400–800 (random) | Abyss Rift boss range |
| Evolution Shard | 60% | 1 | — |
| Rare Collectible | 40% | 1 | — |
| Evolution Crystal | 20% | 1 | — |
| Abyss Essence | 15% | 1 | Species evo item; used for Abyss-zone Stage 3 evolutions (Kitsune, Werewolf, and others) |
| Legend Trap | 5% | 1 | — |
| HP Potion (Large) | 10% | 1 | — |
| Stamina Potion | 10% | 2 | — |

**Dev Notes:**
- `Chaos Form` elemental conversion: set `boss.force_element = "Dark"` at Phase 2 transition; in the elemental multiplier lookup, if `force_element` is set, use that as the attacker element regardless of the skill's native type; basic attacks also gain Dark typing
- `Soul Absorption` Regen is a passive heal, not a status effect in `ActiveEffects` — it cannot be removed by debuff-clear or buff-strip skills; implement as a Phase 3 flag checked at `TURN_START`: `if boss.phase3_triggered then boss.HP = math.min(boss.MaxHP, boss.HP + math.floor(boss.MaxHP × 0.05)) end`
- `Dark Assimilation` buff removal: select a random entry from `player_pet.ActiveBuffs`; remove it; then heal boss; if no buffs are active, Assimilation still applies the self-heal (5% MaxHP) — buff removal is a bonus, not a condition
- `Eternal Darkness` applies Burn + Poison + Blind simultaneously before damage (same pattern as Manticore Chaos Manifestation): apply all three effects first, then calculate damage — Armor Break is not one of the three so DEF is not reduced by this skill itself; damage is dealt at full DEF
- `Infernal Throne` status immunity uses the same `immune_effects_temp` (2T) pattern as Orc Overlord's Rally Cry
- Abyssal Demon Lord is the hardest boss in the base game; players at this level (Abyss zone, pets level 600–1,000) should have Stage 3 Legendary-tier pets or fully evolved Epic-tier pets to compete; expected clear time with appropriate gear: 15–25 turns in Phase 1, 10–20 in Phases 2–3 combined
