# ELEMENT — Anjay Hunter Element Glossary

**Version:** 1.0
**Status:** In Progress
**Last Updated:** 2026-05-08

---

## Overview

Elements define a pet's elemental identity, unlock element-specific skills, grant an innate passive trait, and determine offensive and defensive matchup multipliers against other elements. A pet without an element deals and receives neutral (×1.0) damage from all sources.

- Element imbuing unlocks at **Level 50**
- A pet can hold **one element** at a time
- Changing element costs **1× Re-imbue Stone (200 Gold)**; this resets element-locked skills
- All damage types (physical Attack and skill-based) apply the elemental multiplier

---

## Imbuing System

| Property | Value |
|---|---|
| Unlock condition | Pet reaches Level 50 |
| How to imbue | Select pet → Imbue Element → choose from 10 elements → confirm |
| Cost to imbue (first time) | Free (no currency, no item) |
| Cost to change element | 1× Re-imbue Stone (200 Gold at Item Shop) |
| Skills affected | Element-locked skills in `EquippedSkills` are removed on change; element-neutral skills stay |
| Stat multiplier | None — element does not change base stats; only affects damage math and innate trait bonus |
| Level requirement to change | Pet must be Level 50+ to hold any element at all |

After imbuing, `PetData.Element` is set to the chosen element string. `SkillService` filters the Skill Shop to show only species-compatible and element-compatible skills.

---

## Damage Multiplier Rules

| Scenario | Multiplier |
|---|---|
| Attacker's element is **strong against** defender's element | **×1.5** |
| Attacker's element is **weak against** defender's element | **×0.5** |
| Neither strong nor weak (neutral) | **×1.0** |
| Attacker has no element | **×1.0** |
| Defender has no element | **×1.0** |
| Attacker and defender share the same element | **×1.0** |

Multiplier applies to **both physical Attack and skill damage**:
```lua
damage = math.floor(math.max(1, raw_damage) * elemental_multiplier)
```

Multiple multipliers do not stack — only one elemental relationship per hit (attacker element vs defender element).

---

## Status Effects Reference

All elemental status effects documented here. Effects stack independently unless noted.

| Status | Element Source | Type | Effect | Duration | Proc Chance | Stack |
|---|---|---|---|---|---|---|
| **Burn** | Fire | DoT | −5% MaxHP/turn | 3 turns | 30% | Independent stacks |
| **Soak** | Water | Vulnerability | Target takes ×1.5 from Electric skills | 2 turns | 20% | No stack; refreshes |
| **Poison** | Nature | DoT | −3% MaxHP/turn | 5 turns | 30% | Independent stacks |
| **Regen** | Nature / Light | HoT | +5% MaxHP/turn | 3 turns | Always (skill-granted) | Independent stacks |
| **Armor Break** | Earth / Metal | Debuff | −30% DEF | 2T (Metal: 3T) | 40% | Up to 3 independent stacks |
| **Shock** | Electric | Debuff | −25% SPD | 2 turns | 35% | No stack; refreshes |
| **Freeze** | Ice | Control | Skip turn | 1 turn | 25% | Refreshable; not stackable |
| **Bleed** | Metal | DoT | −2% MaxHP/turn | 3 turns | 25% | Up to 3 stacks (−6%/turn max) |
| **Blind** | Dark | Debuff | 50% miss chance on all attacks | 2 turns | 30% | No stack; refreshes |
| **Taunt** | Wind / War | Control | Opponent forced to target this pet | 2 turns | Always (skill-granted) | No stack; refreshes |
| **Bind** | Earth control skills / certain passives | Control | Skip turn | 1T (Petrify: 2T) | Varies by skill | No stack; refreshes |

**Immunity notes:**
- Undead/construct monsters (Skeleton, Ghost, Specter, Lich) immune to Poison and Bleed
- Slime-type monsters immune to Poison and Bleed
- Bind immune: Boss-tier monsters; SPD debuff resistance at 50% for bosses

**Cure items:**
| Status(es) Removed | Item |
|---|---|
| Poison + Burn | Antidote |
| Blind + Shock | Remedy |
| Freeze + Bind | Warming Herb |
| All debuffs | Full Cure |

---

## Full Matchup Matrix

**Legend:** S = ×1.5 (super effective) | W = ×0.5 (not very effective) | N = ×1.0 (neutral)
**Rows = Attacker | Columns = Defender**

| ATK ↓ / DEF → | Fire | Water | Nature | Earth | Electric | Ice | Metal | Dark | Light | Wind |
|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **Fire** | N | W | **S** | N | N | **S** | **S** | N | N | N |
| **Water** | **S** | N | W | **S** | W | N | N | N | N | W |
| **Nature** | W | **S** | N | **S** | N | N | N | W | N | N |
| **Earth** | N | W | W | N | **S** | N | **S** | N | N | W |
| **Electric** | N | **S** | N | W | N | **S** | N | W | N | N |
| **Ice** | W | N | **S** | N | N | N | W | N | N | **S** |
| **Metal** | W | N | N | W | N | **S** | N | N | W | **S** |
| **Dark** | N | N | **S** | N | **S** | N | N | N | **S** | N |
| **Light** | N | N | N | N | N | N | **S** | **S** | N | N |
| **Wind** | N | **S** | N | **S** | N | W | W | N | N | N |

**Notable relationships:**
- Dark ↔ Light: **mutual super effectiveness** (both deal ×1.5 to each other) — they are elemental opposites
- Fire has the broadest offensive coverage: ×1.5 vs Nature, Ice, Metal (3 matchups)
- Light has the narrowest offensive coverage: ×1.5 vs Metal and Dark only (2 matchups)
- Earth: good offence vs Electric and Metal; weak defensively to Water and Nature

---

## Element Synergies

Cross-element team combos that produce mechanical advantages.

| Synergy | Elements | How It Works |
|---|---|---|
| **Storm Surge** | Water + Electric | Water skills apply Soak (20%); Electric skills vs Soaked target deal ×1.5 and Shock chance doubles (35%→70%) |
| **Scorched Earth** | Fire + Earth | Fire skills strip HP via Burn DoT; Earth skills then penetrate the weakened DEF via Armor Break — high burst combo |
| **Dark Venom** | Dark + Nature | Poison stacks from Nature reduce HP gradually; Blind from Dark reduces opponent's ability to hit back during the attrition window |
| **Metal Storm** | Metal + Wind | Metal applies Bleed and Armor Break; Wind speed skills act first, stacking debuffs before opponent can respond |
| **Frost Nova** | Ice + Wind | Freeze stops the opponent; Wind immediately follows up before the freeze expires; Ice/Wind share good matchup vs Nature and Earth respectively |
| **Sacred Ground** | Light + Earth | Light's Sacred Guard Regen offsets sustained damage; Earth's Armor Break and heavy-hit skills deal massive damage while Light's HoT keeps the pet alive |
| **Shadow Plague** | Dark + Nature | Dark's Blind prevents retaliation; Nature's Poison stacks over 5T; combined DoT can reach −8% MaxHP/turn (Poison + Burn from a third element) |

---

## Innate Element Traits

Every imbued element grants a passive innate bonus in addition to matchup multipliers. Traits are always active while the element is imbued.

| Element | Trait Name | Effect |
|---|---|---|
| Fire | **Ignition** | ATK growth ×1.05 (effective 5% higher ATK at all levels) |
| Water | **Hydration** | HP growth ×1.05 (5% higher MaxHP at all levels) |
| Nature | **Verdant Pulse** | +1% MaxHP passive regen at TURN_START each turn (before DoT; stacks with Regen status) |
| Earth | **Fortitude** | DEF growth ×1.05 (5% higher DEF at all levels) |
| Electric | **Conductivity** | SPD growth ×1.05 (5% higher SPD at all levels); Soak on the target doubles Shock proc chance (35%→70%) |
| Ice | **Permafrost** | Freeze duration refreshes if applied to an already-Frozen target (duration reset to 1T, not extended to 2T) |
| Metal | **Sharpness** | Armor Break from Metal skills lasts 3T instead of 2T; Metal skills have +25% chance to apply Bleed |
| Dark | **Shadow** | 5% passive dodge on every incoming hit (independent of other dodge mechanics; cannot be suppressed by Blind) |
| Light | **Sacred Guard** | Battle starts with 1 free Regen stack (5% MaxHP/turn, 3T); Light skills have 20% chance to cleanse one negative status from own pet on use |
| Wind | **Updraft** | Wins all SPD tiebreakers in turn order; Wind-element skills never miss regardless of Blind or Miss status on the attacker |

---

## Detailed Element Entries

---

### [001] Fire

| Field | Value |
|---|---|
| **Element ID** | `Fire` |
| **Theme** | Aggression, destruction, offensive momentum |
| **Colour** | Red / Orange |
| **Archetype** | Offensive brawler — hits hard and fast, burns down targets before they can retaliate |
| **Innate Trait** | Ignition (ATK growth ×1.05) |
| **Primary Status** | Burn — 30% proc chance; −5% MaxHP/turn for 3 turns |
| **Recommended Stats** | ATK > SPD > HP |

**Matchup Summary:**

| Relationship | Elements |
|---|---|
| Strong vs (×1.5) | Nature, Ice, Metal |
| Weak vs (×0.5) | Water |
| Neutral | Fire, Earth, Electric, Dark, Light, Wind |

**Offensive Profile:** Broadest offensive coverage in the game — super effective against 3 different elements (Nature, Ice, Metal). Burn DoT applies pressure over time, reducing enemy HP before skills land. Strong into most mid-tier defensive builds.

**Defensive Profile:** One hard counter (Water ×0.5). Very few neutral threats. Fire's DEF and HP stats are average; the element wins by killing quickly before taking attrition.

**Skill Categories (Skill Shop — Fire):**
- Single-target damage skills with Burn proc
- Heavy AoE-range multi-target (stamina-expensive)
- Self-buff skills (+ATK for 2T)
- Stamina-neutral quick Burn applicators

**Innate Trait Detail:**
```lua
-- ATK calculation with Ignition
effective_ATK = math.floor(base_ATK * 1.05)
-- Applied at PetService:CalculateStats() when element = "Fire"
```

**Notable Wild Beasts:** Phoenix (Legendary, natural Fire), Kitsune (Epic, Fire element; Stage 2 Fox Fire mark mechanic), Manticore (Legendary, Fire)

**Synergies:** Pairs well with Earth on a team (Fire strips HP, Earth penetrates DEF). Fire's Burn counters high-HP Water-type tanks when targeting their weaknesses instead.

**Counter Strategy:** Bring a Water-type pet; Water's ×1.5 vs Fire and high HP (Hydration) absorbs the Burn DoT. Alternatively, high-SPD pets that kill Fire before Burn stacks accumulate.

**Lore:** *"The oldest element hunted with. Before traps, before strategy, hunters drove wild beasts toward fire. The beasts that survived the flames emerged stronger — or became something else entirely. Fire hunters say an element chooses you. Fire-type pets always seem to agree."*

---

### [002] Water

| Field | Value |
|---|---|
| **Element ID** | `Water` |
| **Theme** | Endurance, pressure, adaptive flow |
| **Colour** | Blue |
| **Archetype** | Sustained tank/bruiser — outlasts opponents through high HP and defensive pressure |
| **Innate Trait** | Hydration (HP growth ×1.05) |
| **Primary Status** | Soak — 20% proc chance; target takes ×1.5 from Electric damage for 2 turns |
| **Recommended Stats** | HP > DEF > ATK |

**Matchup Summary:**

| Relationship | Elements |
|---|---|
| Strong vs (×1.5) | Fire, Earth |
| Weak vs (×0.5) | Electric, Nature, Wind |
| Neutral | Water, Ice, Metal, Dark, Light |

**Offensive Profile:** Reliable counter to Fire (most common offensive element) and Earth (defensive tank archetype). Three weaknesses (Electric, Nature, Wind) make offensive Water builds risky without team support.

**Defensive Profile:** High HP via Hydration makes Water pets survive longer; natural counter to Fire means they stand firm against the most common offensive type. Wind's ×1.5 vs Water is the key threat.

**Skill Categories (Skill Shop — Water):**
- High base-power single-target skills with Soak proc
- Defensive/self-heal utility skills
- Stamina recovery skills (partially restore Stamina on use)
- Multi-hit low-power skills for Soak stacking

**Soak Interaction with Electric:**
```lua
-- Soak check in BattleService:CalculateDamage()
if defender:HasStatus("Soak") and skill.Element == "Electric" then
    elemental_multiplier = elemental_multiplier * 1.5
    shock_proc_chance = shock_proc_chance * 2.0  -- 35% → 70%
end
```

**Notable Wild Beasts:** Koi (Uncommon, Water Balanced; Fortune Scales passive), Frog (Common, Water; Rain Dance + Acid Skin combo), Beaver (Common, Water/Earth Defensive; Grand Levee self-modifier), Anaconda (Rare, Water/Dark; Constrictor uncleansable aura)

**Synergies:** Storm Surge combo with Electric — Water applies Soak, Electric partner follows with doubled Shock chance. Effective against Fire-dominant enemy teams.

**Counter Strategy:** Electric types destroy Water (×1.5 + doubled Shock chance vs Soaked). Bring Nature for sustained Poison pressure over Water's high HP. Wind's ×1.5 is also effective against Water tanks.

**Lore:** *"Water does not fight. It waits, absorbs, surrounds. A Water-type pet in battle doesn't try to end the fight — it tries to still be standing when everything else has stopped moving. Hunters who partner with Water-types learn patience they didn't know they needed."*

---

### [003] Nature

| Field | Value |
|---|---|
| **Element ID** | `Nature` |
| **Theme** | Growth, decay, attrition over time |
| **Colour** | Green |
| **Archetype** | DoT controller — wins through accumulated Poison damage and Regen sustain |
| **Innate Trait** | Verdant Pulse (+1% MaxHP passive regen at TURN_START, before DoT ticks) |
| **Primary Status (offensive)** | Poison — 30% proc; −3% MaxHP/turn for 5 turns |
| **Primary Status (supportive)** | Regen — always on certain skills; +5% MaxHP/turn for 3 turns |
| **Recommended Stats** | HP > ATK > SPD |

**Matchup Summary:**

| Relationship | Elements |
|---|---|
| Strong vs (×1.5) | Water, Earth |
| Weak vs (×0.5) | Fire, Dark |
| Neutral | Nature, Electric, Ice, Metal, Light, Wind |

**Offensive Profile:** Effective against Water (counters the dominant tank archetype) and Earth. Poison stacks provide sustained pressure even if the opponent uses HP Potions in battle (DoT ticks before the healed HP can be spent).

**Defensive Profile:** Verdant Pulse is the most unique innate — passive +1% HP regen every turn means Nature pets effectively have ~20 extra turns of effective HP in a long fight. Hard countered by Fire and Dark.

**Skill Categories (Skill Shop — Nature):**
- Poison applicator skills
- Regen buff skills (self and ally)
- Heal-over-time stacking skills (high STA cost)
- Hybrid ATK+Poison skills (lower power mult, higher proc rate)

**Verdant Pulse Interaction:**
```lua
-- In BattleService:ProcessTurnStart()
if active_pet.Element == "Nature" then
    local regen = math.floor(active_pet.MaxHP * 0.01)
    active_pet.HP = math.min(active_pet.MaxHP, active_pet.HP + regen)
end
-- Then process DoT ticks (Burn, Poison)
-- So Nature pets offset some Burn/Poison DoT via this 1% regen
```

**Notable Wild Beasts:** Wolverine (Uncommon, Nature Offensive; Undying Grit — survive at 1HP once per battle), various Forest-zone beasts (natural Nature affinity), Frog (after Rain Dance skill activates the Nature combo)

**Synergies:** Shadow Plague — pair with Dark; Poison stacks while Dark's Blind prevents retaliation. Also effective with Light for a Poison+Regen endurance build (Dark Venom Combo reversed to defensive attrition).

**Counter Strategy:** Fire deletes Nature quickly (×1.5 + Burn DoT races ahead of Verdant Pulse). High-SPD Fire pets act first and apply Burn before Nature can stack Poison. Ice also takes ×1.5 from Nature, so keep Ice pets away.

**Lore:** *"Nature hunters are patient by necessity. Poison takes time. Regen takes time. Wins don't come in one hit — they come in the fourth, fifth, sixth turn when the opponent's pet is half-dead from invisible damage and the Nature-type is still standing. The forest doesn't rush. Neither do its pets."*

---

### [004] Earth

| Field | Value |
|---|---|
| **Element ID** | `Earth` |
| **Theme** | Resilience, weight, armour penetration |
| **Colour** | Brown / Tan |
| **Archetype** | Tank-buster — high DEF, Armor Break skills that strip opponent DEF, slow but devastating hits |
| **Innate Trait** | Fortitude (DEF growth ×1.05) |
| **Primary Status** | Armor Break — 40% proc; −30% DEF for 2 turns (up to 3 independent stacks) |
| **Recommended Stats** | DEF > HP > ATK |

**Matchup Summary:**

| Relationship | Elements |
|---|---|
| Strong vs (×1.5) | Electric, Metal |
| Weak vs (×0.5) | Water, Nature, Wind |
| Neutral | Fire, Earth, Ice, Dark, Light |

**Offensive Profile:** Armor Break at 40% proc rate is the highest-reliability debuff in the game. Three stacks of Armor Break reduce DEF by 90% — essentially turning the target into a glass cannon for the subsequent hit. Earth then deals heavy damage while the target is exposed.

**Defensive Profile:** Fortitude + naturally high DEF growth makes Earth the most defensive offensive element. Three weaknesses (Water, Nature, Wind) create exploitable gaps — Earth is punished by mobile or DoT-heavy builds.

**Skill Categories (Skill Shop — Earth):**
- Heavy-damage slow skills (×2.5–×3.5 power mult) with Armor Break proc
- Binding control skills (Bind proc — see Bind in status table)
- DEF-ignore skills (penetrate percentage of defender DEF)
- Fortify skills (self DEF buff for 2T)

**Armor Break Stack Formula:**
```lua
-- Each stack reduces DEF independently
-- Three stacks present: effective_DEF = base_DEF * (1 - 0.30)^3 = base_DEF * 0.343
-- i.e., 65.7% DEF reduction total at 3 stacks
-- NOTE: stacks are individual entries with separate durations
```

**Notable Wild Beasts:** Gorilla (Rare, Earth Tank/Offensive; Knuckle Guard 25% counter, Silverback Charge always-first), Hedgehog (Common, Earth Defensive; Iron Quill Strike uses DEF as ATK supplement), Goat (Common, Earth Tank; Stubborn Stance immune to Taunt, Titan Slam ignores 25% DEF), Turtle (Common, Earth; high DEF base), Armadillo (Rolling Charge — always-first family)

**Synergies:** Sacred Ground — pair Earth (offensive) with Light (supportive) for a durable dual offensive build. Earth strips DEF, Light heals between turns. Also synergises with Fire: Fire applies Burn DoT while Earth Armor Breaks for the big hit.

**Counter Strategy:** Nature (×1.5 and Poison through DEF) and Water (×1.5 and sustained HP) both beat Earth. High-SPD Wind types act before Earth's slow heavy skills and hit for ×1.5. Earth struggles heavily against mobile teams.

**Lore:** *"Every dungeon has an Earth-element trap room. Heavy stone, falling blocks, walls that move closer. The beasts that live there develop thick hides and slower movement. Earth hunters love the weight of things. Their pets hit once, hit hard, and wait for the dust to settle."*

---

### [005] Electric

| Field | Value |
|---|---|
| **Element ID** | `Electric` |
| **Theme** | Speed, chain reactions, burst damage |
| **Colour** | Yellow / White |
| **Archetype** | Speed striker — acts first, chains status effects, combos with Water for devastating Shock rates |
| **Innate Trait** | Conductivity (SPD growth ×1.05; Shock chance doubles vs Soaked targets) |
| **Primary Status** | Shock — 35% proc; −25% SPD for 2 turns (doubled to 70% vs Soaked targets) |
| **Recommended Stats** | SPD > ATK > HP |

**Matchup Summary:**

| Relationship | Elements |
|---|---|
| Strong vs (×1.5) | Water, Ice |
| Weak vs (×0.5) | Earth, Dark |
| Neutral | Fire, Nature, Electric, Metal, Light, Wind |

**Offensive Profile:** Shock at 35% base (70% vs Soaked) makes Electric the best SPD-debuff element. Combined with Conductivity's SPD growth boost, Electric pets act earlier AND punish the opponent's SPD simultaneously. Good offensive coverage vs Water and Ice.

**Defensive Profile:** Hard countered by Earth (×1.5 vs Electric) and Dark (×1.5 vs Electric). Both are common mid-game archetypes — Electric players need to identify and avoid or swap out against Earth/Dark defenders.

**Skill Categories (Skill Shop — Electric):**
- Fast low-stamina shock applicators
- Chain lightning skills (hits base target + 50% damage splash to an adjacent turn-order pet — PvP / multi-wave context)
- High-SPD priority skills (lower power mult, guaranteed first action)
- Shock-combo finisher skills (bonus damage multiplier vs Shocked targets)

**Conductivity Shock Doubling:**
```lua
-- In SkillService:ApplyStatusEffect()
if status_name == "Shock" and defender:HasStatus("Soak") then
    proc_chance = proc_chance * 2.0  -- 0.35 → 0.70
end
```

**Notable Wild Beasts:** Thunderbird (Legendary, Wind/Electric; Storm Conductor passive — stacks +10% ATK per Electric skill used), various electric-type wild encounters in mountain and abyss zones

**Synergies:** Storm Surge with Water is the defining Electric combo (Water Soak → doubled Shock chance). Electric also pairs well with Wind (both SPD-focused; Wind acts first to set up, Electric follows with Shock chain).

**Counter Strategy:** Earth absolutely counters Electric (×1.5 + Armor Break strips ATK; Electric's weakness in DEF makes it fragile). Dark also threatens Electric significantly. Ice resists Electric's ×1.5 if Electric can't close the gap — but rarely matched as Ice is Electric's coverage target.

**Lore:** *"Lightning doesn't negotiate. Electric hunters call their style 'the first strike and the last.' Their pets move before the opponent has registered the battle started. The Shock debuff isn't cruelty — it's arithmetic. Slow the opponent, hit harder, win faster."*

---

### [006] Ice

| Field | Value |
|---|---|
| **Element ID** | `Ice` |
| **Theme** | Control, stasis, battlefield manipulation |
| **Colour** | Light Blue / White |
| **Archetype** | Control specialist — Freeze stops opponents cold, buying turns to build advantage |
| **Innate Trait** | Permafrost (Freeze applied to already-Frozen target refreshes duration instead of being wasted) |
| **Primary Status** | Freeze — 25% proc; skip next turn for 1 turn |
| **Recommended Stats** | ATK > DEF > SPD |

**Matchup Summary:**

| Relationship | Elements |
|---|---|
| Strong vs (×1.5) | Nature, Wind |
| Weak vs (×0.5) | Fire, Metal |
| Neutral | Water, Earth, Electric, Ice, Dark, Light |

**Offensive Profile:** Freeze is the most decisive single-turn status in the game — a free turn for the Ice user if it procs. Combined with Permafrost (duration refresh instead of wasted application), a consecutive Freeze proc maintains lock-down. ×1.5 vs Nature and Wind covers common encounter types.

**Defensive Profile:** Fire (most common offensive element) hard-counters Ice. Metal's ×1.5 and Armor Break combo is also dangerous. Ice pets need strong HP or DEF investment to survive the turns before Freeze lands.

**Skill Categories (Skill Shop — Ice):**
- Freeze proc skills (various proc rates and power mults)
- Multi-hit Freeze skills (lower individual proc but multiple rolls)
- Ice wall defensive skills (reduce incoming damage for 1T)
- Heavy Freeze finisher (high power mult, 40%+ Freeze chance, high STA cost)

**Permafrost Mechanics:**
```lua
-- Freeze application logic
if target:HasStatus("Freeze") then
    -- Without Permafrost: new Freeze is wasted (cannot stack control)
    -- With Permafrost (attacker.Element == "Ice"):
    existing_freeze.turns_remaining = 1  -- refresh to full
else
    target.ActiveEffects:add({ name = "Freeze", turns_remaining = 1 })
end
```

**Notable Wild Beasts:** Ice-type wild beasts in Mountain and Abyss zones; Bat (uses Echolocation to suppress dodge — good anti-Wind counter even with Ice element), various cold-habitat species

**Synergies:** Frost Nova — pair Ice with Wind; Freeze stops an opponent, Wind (which Ice doesn't threaten) follows up with ×1.5 vs Earth/Water targets. Ice + Metal also strong: Metal's Bleed and Armor Break deal more damage while Ice Freeze prevents retaliation.

**Counter Strategy:** Fire is the primary Ice counter. Always have a Fire-type in reserve when expecting Ice teams. Fire's Burn (3T DoT) ticks through Freeze turns. Metal ×1.5 vs Ice is secondary — use Armor Break to remove Ice's DEF before the finishing blow.

**Lore:** *"Ice-type trainers have a reputation for cruelty — stopping a pet mid-action, freezing movement down to zero. Ice hunters say it isn't cruelty. It's the cleanest possible outcome. The freeze breaks. The battle resumes. Nobody has to take unnecessary damage. They say this and believe it."*

---

### [007] Metal

| Field | Value |
|---|---|
| **Element ID** | `Metal` |
| **Theme** | Precision, armour penetration, sustained bleed |
| **Colour** | Silver / Grey |
| **Archetype** | Armour-stripping attrition dealer — stacks Armor Break and Bleed for cascading sustained damage |
| **Innate Trait** | Sharpness (Armor Break lasts 3T instead of 2T; Metal skills have +25% Bleed proc) |
| **Primary Status 1** | Armor Break — 40% proc; −30% DEF per stack for 3T (Metal: +1T vs standard 2T) |
| **Primary Status 2** | Bleed — 25% proc; −2% MaxHP/turn for 3T; stacks up to 3× (−6% MaxHP/turn max) |
| **Recommended Stats** | ATK > DEF > HP |

**Matchup Summary:**

| Relationship | Elements |
|---|---|
| Strong vs (×1.5) | Ice, Wind |
| Weak vs (×0.5) | Fire, Earth, Light |
| Neutral | Water, Nature, Electric, Metal, Dark |

**Offensive Profile:** Dual-status application (Armor Break + Bleed) makes Metal the highest sustained damage element over a long fight. Three stacks of Armor Break reduce effective DEF by ~66%; three Bleed stacks deal −6% MaxHP/turn — combined with ×1.5 base damage once DEF is stripped, Metal outputs the highest raw DPS against high-DEF targets. Effective vs Ice and Wind.

**Defensive Profile:** Three weaknesses (Fire, Earth, Light) including all three dealing ×1.5. Fire's Burn + Metal's own weakness to Fire makes Metal fragile against the most common offensive element. Earth also ×1.5 — a dangerous matchup since Earth has Armor Break of its own and high DEF.

**Skill Categories (Skill Shop — Metal):**
- Armor Break proc skills (medium power mult; 35–50% proc)
- Bleed proc skills (multi-hit; each hit has individual Bleed proc roll)
- DEF-pierce skills (ignore 20–40% of defender DEF regardless of Armor Break)
- Heavy single-target finisher (high power mult; bonus damage if target Bleeding)

**Sharpness Interaction:**
```lua
-- Armor Break duration extension (Metal only)
if attacker.Element == "Metal" then
    armor_break_entry.turns_remaining = 3  -- instead of 2
end

-- Bleed proc on Metal skill use
if attacker.Element == "Metal" and skill.Element == "Metal" then
    bleed_proc_chance = skill.base_bleed_chance + 0.25
    -- e.g., skill base 0% bleed + 0.25 = 25% chance
end
```

**Notable Wild Beasts:** Metal-type wild encounters in Mountain and Volcano zones; armoured beast species (Armadillo-line, heavy-bodied beasts); crafted/forged-lore beasts in volcanic regions

**Synergies:** Metal Storm — pair Metal with Wind; Wind acts first via Updraft, applies Taunt to control targeting, then Metal strips DEF and stacks Bleed. Frost Nova variant: Ice Freezes while Metal pre-stacks Bleed; when Freeze ends, the DoT per turn is devastating.

**Counter Strategy:** Fire is the clearest counter — ×1.5 and Burn races against Metal's Bleed. Earth also ×1.5 with its own Armor Break (countering Metal's core mechanic). Light deals ×1.5 and Sacred Guard's cleanse passive (20% chance) can strip Bleed stacks.

**Lore:** *"Metal hunters forge their pets the same way a blade is forged: patience, repetition, pressure. A Metal-type fight looks slow at first. Two turns of Armor Break. A Bleed stack. Another Armor Break. Then the opponent notices the HP bar is gone and they don't remember when it started."*

---

### [008] Dark

| Field | Value |
|---|---|
| **Element ID** | `Dark` |
| **Theme** | Assassination, suppression, psychological warfare |
| **Colour** | Black / Deep Purple |
| **Archetype** | Offensive assassin — high ATK, Blind forces opponents to miss, Shadow dodge adds survivability |
| **Innate Trait** | Shadow (5% passive dodge on every incoming hit, independent of other dodge) |
| **Primary Status** | Blind — 30% proc; 50% miss chance on all attacks for 2 turns |
| **Recommended Stats** | ATK > SPD > DEF |

**Matchup Summary:**

| Relationship | Elements |
|---|---|
| Strong vs (×1.5) | Electric, Nature, Light |
| Weak vs (×0.5) | Light |
| Neutral | Fire, Water, Earth, Ice, Metal, Dark, Wind |

**Special Relationship:** Dark ↔ Light are mutual ×1.5 counters. Dark attacks Light = ×1.5; Light attacks Dark = ×1.5.

**Offensive Profile:** Three offensive ×1.5 targets (Electric, Nature, Light) with no other weaknesses beyond Light. Blind at 30% proc is not guaranteed but when it lands, the opponent wastes a turn with 50% miss chance — effectively a partial free turn. Shadow's 5% dodge is additional passive survivability.

**Defensive Profile:** Only Light threatens Dark offensively at ×1.5. The mutual Light relationship means Dark players must be careful: a Light pet on the opponent's team that isn't handled becomes a ×1.5 threat. Dark's innate dodge helps absorb random hits.

**Skill Categories (Skill Shop — Dark):**
- Blind proc skills (various proc rates)
- HP drain skills (deal damage and heal user by 20–40% of damage dealt)
- Shadow strike skills (bonus damage vs Blinded targets)
- Dark aura skills (self-buff: +15% ATK + 5% dodge for 2T)

**Shadow Dodge:**
```lua
-- Passive dodge check in BattleService before damage application
if defender.Element == "Dark" then
    if math.random() < 0.05 then
        -- Dodge; no damage applied
        return { hit = false, reason = "shadow_dodge" }
    end
end
-- Note: Shadow dodge fires AFTER Blind miss check — both can trigger independently
```

**Notable Wild Beasts:** Wolf (Uncommon, Dark Offensive; Pack Leader — kill blow grants +15% ATK stack), Werewolf (Epic, Dark Offensive; Lunar Rage — odd-turn ATK +25%), Basilisk (Rare, Dark Offensive; Petrifying Gaze — 20% skip chance turn 1), Anaconda (Rare, Water/Dark; Constrictor aura), Kitsune Stage 3 Celestial Kitsune (shifts from Fire to Dark)

**Synergies:** Shadow Plague (Dark + Nature) — Blind reduces retaliation while Poison stacks kill over time. Dark Venom combo using Wolf Pack Leader stacks + Wolverine Undying Grit on the Nature partner for maximum sustained pressure.

**Counter Strategy:** Light counters Dark at ×1.5 AND has Sacred Guard Regen to offset Shadow drain skills. Bring a well-levelled Light-type as the primary Dark counter. Electric also has neutral matchup but is threatened by Dark's ×1.5 — avoid pairing Electric vs Dark directly.

**Lore:** *"Dark hunters operate at the edge of what other hunters call fair. Blind your opponent. Hit from shadows. Drain their strength and give it to yours. The guild masters record wins and losses. They don't ask how. Dark-type hunters like it that way."*

---

### [009] Light

| Field | Value |
|---|---|
| **Element ID** | `Light` |
| **Theme** | Purification, support, endurance through radiance |
| **Colour** | White / Gold |
| **Archetype** | Support sustainer — Sacred Guard Regen opens every battle; cleanse passive strips debuffs; counter to both Dark and Metal |
| **Innate Trait** | Sacred Guard (Battle starts with 1 free Regen stack: +5% MaxHP/turn for 3T; Light skills have 20% chance to cleanse one negative status from own pet on use) |
| **Primary Status** | Regen — always on relevant skills; +5% MaxHP/turn for 3T |
| **Recommended Stats** | HP > DEF > STA |

**Matchup Summary:**

| Relationship | Elements |
|---|---|
| Strong vs (×1.5) | Dark, Metal |
| Weak vs (×0.5) | Dark |
| Neutral | Fire, Water, Nature, Earth, Electric, Ice, Light, Wind |

**Special Relationship:** Light ↔ Dark mutual ×1.5. Light attacking Dark and Dark attacking Light both apply ×1.5.

**Offensive Profile:** Narrowest offensive coverage (only Dark and Metal at ×1.5). Light is not an aggressive element — it is a counter pick and support role. Against Dark and Metal, ×1.5 plus Sacred Guard's cleanse (stripping Bleed/Armor Break from Metal, stripping Blind from Dark's own skills reflecting back) makes Light the premier counter to both.

**Defensive Profile:** Only weakness is Dark (×1.5 — mutual). Light's Sacred Guard Regen gives it effective extra HP at battle start, and the 20% cleanse-on-hit protects against Bleed, Poison, Armor Break stacks. Light is the most self-sustaining defensive element in the game.

**Skill Categories (Skill Shop — Light):**
- Regen-application skills (self and ally)
- Cleanse skills (remove all debuffs — similar to Full Cure but as a skill)
- Heavy damage skills with Light element (effective only vs Dark/Metal; neutral elsewhere)
- Support skills (heal + remove one debuff from ally)

**Sacred Guard Implementation:**
```lua
-- In BattleService:INIT() phase
if active_pet.Element == "Light" then
    active_pet.ActiveEffects:add({
        name = "Regen",
        magnitude = 0.05,
        turns_remaining = 3,
        source = "sacred_guard"
    })
end

-- On Light skill use: 20% cleanse check
if attacker.Element == "Light" and math.random() < 0.20 then
    local debuffs = attacker:GetDebuffs()
    if #debuffs > 0 then
        table.remove(debuffs, 1)  -- remove oldest debuff
    end
end
```

**Notable Wild Beasts:** Tiger-line (Tiger → White Tiger: Light element confirmed in NPC 003 entry), Lion (Rare; Light-aligned in lore — Pride Sovereign as Stage 3), Bear (Rare; Mountain zone, Earth/Light hybrid), Horse-line (Common, Light Balanced)

**Synergies:** Sacred Ground (Light + Earth) — Earth strips DEF via Armor Break; Light heals back damage taken. Extremely durable duo in co-op dungeon runs. Light also counters Dark directly, making it the mandatory pick against Werewolf/Basilisk/Wolf teams in PvP.

**Counter Strategy:** Dark ×1.5 remains Light's only real counter. However, even the mutual ×1.5 is manageable because Sacred Guard's Regen runs ahead of Dark's damage output in most matchups. True counter is a high-SPD Dark pet that kills before Regen ticks accumulate.

**Lore:** *"Light hunters are the healers of the hunter world — and the most underestimated. An opponent that ignores a Light-type pet because it isn't hitting hard enough finds out three turns later that the Light pet has more HP than when the fight started. Sacred Guard isn't just a trait. It's a philosophy."*

---

### [010] Wind

| Field | Value |
|---|---|
| **Element ID** | `Wind` |
| **Theme** | Speed, first strike, field control |
| **Colour** | Cyan / Light Green |
| **Archetype** | Speed controller — acts before everyone else, controls targeting via Taunt, and hits ×1.5 vs Earth/Water |
| **Innate Trait** | Updraft (wins all SPD tiebreakers in turn order; Wind-element skills never miss regardless of Blind on the attacker) |
| **Primary Status** | Taunt — always on relevant Taunt skills; forces opponent to target this pet for 2 turns |
| **Recommended Stats** | SPD > ATK > HP |

**Matchup Summary:**

| Relationship | Elements |
|---|---|
| Strong vs (×1.5) | Earth, Water |
| Weak vs (×0.5) | Ice, Metal |
| Neutral | Fire, Nature, Electric, Dark, Light, Wind |

**Offensive Profile:** ×1.5 vs Earth (the defensive archetype) and Water (the sustain tank) makes Wind a natural anti-tank element. Updraft guarantees first action in tiebreakers; combined with high SPD growth builds, Wind acts before almost everything. Taunt disrupts opponent targeting strategies.

**Defensive Profile:** Ice and Metal both ×1.5 vs Wind. Ice Freeze + Ice's ×1.5 damage is the most dangerous combo against Wind — Freeze prevents Wind from using its Updraft advantage. Metal's Bleed + ×1.5 punishes Wind's typically lower HP.

**Skill Categories (Skill Shop — Wind):**
- Always-first priority skills (join the always-first family; `priority = 0` flag)
- Taunt skills (always proc; 2T duration)
- Wind-element hit-all skills (lower power mult, multi-target, good for wave clearing)
- SPD-boost self-buff skills
- Evasion skills (additional dodge chance for 2T)

**Updraft Implementation:**
```lua
-- In BattleService:SortTurnOrder() SPD tiebreaker
-- Sort descending by effective_SPD
-- If two pets share the same SPD after all buffs/debuffs:
if petA.SPD == petB.SPD then
    if petA.Element == "Wind" and petB.Element ~= "Wind" then
        -- petA acts first
    elseif petB.Element == "Wind" and petA.Element ~= "Wind" then
        -- petB acts first
    else
        -- Both Wind or neither Wind: random tiebreak
        math.random(1, 2)
    end
end

-- Wind skill miss immunity
if attacker.Element == "Wind" and skill.Element == "Wind" then
    ignore_blind = true  -- Blind miss check skipped
end
```

**Notable Wild Beasts:** Sparrow (Common, Wind Speed; Feather Veil reflects Blind back), Hawk (Uncommon, Wind Speed/Offensive; Aerial Predator — turn 1 priority override), Eagle-line (Rare; Tempest Eagle Stage 3), Thunderbird (Legendary, Wind/Electric; Storm Conductor stacks ATK per Electric skill; Gale Wing joins always-first family), Parrot (Common, Wind)

**Synergies:** Metal Storm (Wind + Metal) — Wind acts first, applies Taunt forcing opponent to target Wind; Metal follows up with Armor Break and Bleed stacks while the opponent is Taunted into a corner. Frost Nova variant (Ice + Wind): Ice Freezes, Wind follows up for ×1.5 vs Earth targets.

**Counter Strategy:** Ice is Wind's primary hard counter — Freeze removes the SPD advantage entirely, then ×1.5 Ice damage punishes. Metal is secondary (×1.5 Bleed stacks drain Wind's lower HP pool quickly). Carry a Fire-type to handle Ice threats before they can Freeze Wind.

**Lore:** *"Wind hunters are difficult to respect and impossible to ignore. Their pets act before yours, decide the terms of the fight, and walk away before you've worked out what went wrong. Updraft means they win ties. They say there are no ties, only slower opponents. The Wind types at the top of the PvP board agree."*

---

## Elemental Tier at a Glance

Contextual performance summary — not absolute rankings; matchup-dependent.

| Element | Offensive Strength | Defensive Strength | Best Role | Primary Threat |
|---|---|---|---|---|
| Fire | High (3 ×1.5) | Medium | Aggressive sweeper | Water |
| Water | Medium (2 ×1.5) | High | Sustain tank | Electric, Nature |
| Nature | Medium (2 ×1.5) | Medium | DoT attritionist | Fire, Dark |
| Earth | Medium (2 ×1.5) | High | Tank-buster | Water, Nature |
| Electric | Medium (2 ×1.5) | Medium | Speed striker | Earth, Dark |
| Ice | Medium (2 ×1.5) | Medium | Control specialist | Fire, Metal |
| Metal | Medium (2 ×1.5) | Low | Attrition/bleed | Fire, Earth, Light |
| Dark | High (3 ×1.5) | Medium | Assassin | Light |
| Light | Low (2 ×1.5) | High | Support counter | Dark |
| Wind | Medium (2 ×1.5) | Low | Speed controller | Ice, Metal |

---

## Dev Notes

### Element System Implementation

```lua
-- Element check at damage calculation (BattleService)
local function GetElementalMultiplier(attacker_element, defender_element)
    if attacker_element == nil or defender_element == nil then
        return 1.0
    end
    if attacker_element == defender_element then
        return 1.0
    end

    local STRONG_AGAINST = {
        Fire    = { Nature=true, Ice=true, Metal=true },
        Water   = { Fire=true, Earth=true },
        Nature  = { Water=true, Earth=true },
        Earth   = { Electric=true, Metal=true },
        Electric= { Water=true, Ice=true },
        Ice     = { Nature=true, Wind=true },
        Metal   = { Ice=true, Wind=true },
        Dark    = { Electric=true, Nature=true, Light=true },
        Light   = { Dark=true, Metal=true },
        Wind    = { Earth=true, Water=true },
    }

    if STRONG_AGAINST[attacker_element][defender_element] then
        return 1.5
    end

    if STRONG_AGAINST[defender_element] and STRONG_AGAINST[defender_element][attacker_element] then
        return 0.5
    end

    return 1.0
end
```

### Innate Trait Application

Innate stat growth bonuses (Fire ATK ×1.05, Water HP ×1.05, etc.) are applied in `PetService:CalculateStats()`:

```lua
local function CalculateStats(pet_data)
    local base = SpeciesConfig[pet_data.SpeciesId].BaseStats
    local growth = SpeciesConfig[pet_data.SpeciesId].Growth
    local level = pet_data.Level
    local element = pet_data.Element

    local stats = {}
    for stat, base_val in pairs(base) do
        stats[stat] = base_val + (level - 1) * growth[stat]
    end

    -- Apply evolution multiplier
    local stage_mult = { [1]=1.0, [2]=1.3, [3]=1.7 }
    for stat, val in pairs(stats) do
        stats[stat] = math.floor(val * stage_mult[pet_data.EvolutionStage])
    end

    -- Apply innate element trait (stat growth bonus)
    if element == "Fire" then
        stats.ATK = math.floor(stats.ATK * 1.05)
    elseif element == "Water" then
        stats.HP = math.floor(stats.HP * 1.05)
    elseif element == "Earth" then
        stats.DEF = math.floor(stats.DEF * 1.05)
    elseif element == "Electric" then
        stats.SPD = math.floor(stats.SPD * 1.05)
    end
    -- Nature (Verdant Pulse), Ice (Permafrost), Metal (Sharpness), Dark (Shadow),
    -- Light (Sacred Guard), Wind (Updraft) are applied in BattleService, not stat calc

    return stats
end
```

### Soak Status (New — Update BATTLE.md)

`Soak` is a new status introduced by the Water element. Add to BATTLE.md's status effect table:

| Field | Value |
|---|---|
| Status ID | `Soak` |
| Source | Water-element skills (20% proc chance) |
| Effect | Target takes ×1.5 from Electric skills; Electric Shock proc chance ×2.0 |
| Duration | 2 turns |
| Stack | No; refreshes on re-application |
| Cleanse | Full Cure; immune to other status cures |

### Bleed Status (New — Update BATTLE.md)

`Bleed` is confirmed by monster immunity entries (Slime, Ghost, Skeleton immunities in MONSTER.md). Add to BATTLE.md:

| Field | Value |
|---|---|
| Status ID | `Bleed` |
| Source | Metal-element skills (25% proc with Sharpness; base skill bleed chance varies) |
| Effect | −2% MaxHP/turn DoT |
| Duration | 3 turns |
| Stack | Up to 3 stacks (−6% MaxHP/turn maximum) |
| Immune | Undead types (Skeleton, Ghost, Lich, Specter), Slime types |
| Cleanse | Full Cure; Antidote does NOT cure Bleed (Antidote = Poison/Burn only) |
