# ITEM — Anjay Hunter Item Glossary

**Version:** 1.0
**Status:** In Progress
**Last Updated:** 2026-05-08

---

## Overview

Items are stored in `PlayerData.Inventory` as a key–value map (`item_id → quantity`). Maximum **500 unique item types** across all categories. Items are obtained from shops, dungeon drops, quest rewards, achievements, expeditions, and seasonal events.

---

## Item Categories

| Category | Function | Max Stack | Sell Policy |
|---|---|---|---|
| **Consumable** | Active effect on use; consumed on use | 999 | Sell at Item Shop NPC for Silver or Gold |
| **Collectible** | No gameplay effect; display or sell | 99 | Sell at Item Shop NPC for Silver |
| **Cosmetic** | Worn by player or applied to pet | 1 per unique item | Non-sellable; transferred to cosmetic inventory if pet released |

### Sub-Categories

| Sub-Category | Parent Category | Description |
|---|---|---|
| Recovery | Consumable | Restore HP, Stamina, or Hunt Energy |
| Capture | Consumable | Expended during a capture attempt in battle |
| Evolution Material | Consumable | Required for Stage 2 or Stage 3 evolution |
| Species Material | Consumable (Evolution) | Species-specific ingredient for Stage 3 evolution only |
| Boost | Consumable | Temporary battle or economy buff; Robux-only acquisition |
| Trophy | Collectible | Rare boss drops; no mechanical use |

---

## Acquisition Overview

| Source | Notable Item Drops |
|---|---|
| **Item Shop (Hub)** | All Recovery items, Traps (001–011), Re-imbue Stone |
| **Wild beast drop** | HP Potion (Small), Basic Trap (10% drop) |
| **Dungeon monster kill** | Energy Drink (3%), HP Potion Small (8%), Stamina Potion (5%) |
| **Dungeon boss kill** | Evolution Shard 60%, Evolution Crystal 20%, Species Material 15%, Trophy Collectible 40%, Legend Trap 5% |
| **Daily Quest reward** | Iron Trap ×3, Evolution Shard ×1 |
| **Bounty reward** | Legend Trap ×1, Evolution Shard ×2 |
| **Achievement reward** | Basic Trap ×5 (`first_capture`), Evolution Shard ×1 (`pet_lv100`) |
| **Pet Expedition (Medium)** | 1 random common item (HP Potion Small/Large, Basic Trap) |
| **Pet Expedition (Long)** | 1 random uncommon–rare item (Iron Trap, Evolution Shard, Gold Trap chance) |
| **Seasonal Event chest** | Boost items, event-exclusive Species Materials |
| **Robux Developer Product** | XP Boost Crystal, Capture Booster, Dungeon Key |

---

## Item Index

| # | Item ID | Name | Category | Sub-Category | Buy Price | Sell Price | Stack |
|---|---|---|---|---|---|---|---|
| 001 | `hp_potion_small` | HP Potion (Small) | Consumable | Recovery | 30 Silver | 3 Silver | 999 |
| 002 | `hp_potion_large` | HP Potion (Large) | Consumable | Recovery | 150 Silver | 15 Silver | 999 |
| 003 | `stamina_potion` | Stamina Potion | Consumable | Recovery | 50 Silver | 5 Silver | 999 |
| 004 | `energy_drink` | Energy Drink | Consumable | Recovery | 500 Silver | 50 Silver | 999 |
| 005 | `basic_trap` | Basic Trap | Consumable | Capture | 50 Silver | 5 Silver | 999 |
| 006 | `iron_trap` | Iron Trap | Consumable | Capture | 200 Silver | 20 Silver | 999 |
| 007 | `gold_trap` | Gold Trap | Consumable | Capture | 50 Gold | 5 Gold | 999 |
| 008 | `legend_trap` | Legend Trap | Consumable | Capture | 300 Gold | 30 Gold | 999 |
| 009 | `evolution_shard` | Evolution Shard | Consumable | Evolution Material | 500 Silver / 10 Gold | 50 Silver | 999 |
| 010 | `evolution_crystal` | Evolution Crystal | Consumable | Evolution Material | 100 Gold | 10 Gold | 999 |
| 011 | `reimibue_stone` | Re-imbue Stone | Consumable | Evolution Material | 200 Gold | 20 Gold | 999 |
| 012 | `treant_heartwood` | Treant Heartwood | Consumable | Species Material | Cannot buy | 200 Gold | 99 |
| 013 | `goblin_war_crown` | Goblin War Crown | Consumable | Species Material | Cannot buy | 50 Gold | 99 |
| 014 | `lichs_phylactery` | Lich's Phylactery | Consumable | Species Material | Cannot buy | 75 Gold | 99 |
| 015 | `orc_warbrand_frag` | Orc Warbrand Fragment | Consumable | Species Material | Cannot buy | 150 Gold | 99 |
| 016 | `abyss_essence` | Abyss Essence | Consumable | Species Material | Cannot buy | 300 Gold | 99 |
| 017 | `petrified_eye` | Petrified Eye | Consumable | Species Material | Cannot buy | 300 Gold | 99 |
| 018 | `spirit_orb` | Spirit Orb | Consumable | Species Material | Cannot buy | 300 Gold | 99 |
| 019 | `blood_moon_stone` | Blood Moon Stone | Consumable | Species Material | Cannot buy | 300 Gold | 99 |
| 020 | `storm_feather` | Storm Feather | Consumable | Species Material | Cannot buy | 500 Gold | 99 |
| 021 | `xp_boost_crystal` | XP Boost Crystal | Consumable | Boost | Robux (49 R$) | Cannot sell | 99 |
| 022 | `capture_booster` | Capture Booster | Consumable | Boost | Robux (19 R$) | Cannot sell | 99 |
| 023 | `dungeon_key` | Dungeon Key | Consumable | Boost | Robux (39 R$) | Cannot sell | 99 |
| 024 | `goblin_chiefs_trophy` | Goblin Chief's Trophy | Collectible | Trophy | Cannot buy | 500 Silver | 99 |
| 025 | `ancient_bone_relic` | Ancient Bone Relic | Collectible | Trophy | Cannot buy | 1,500 Silver | 99 |
| 026 | `enchanted_bark_rune` | Enchanted Bark Rune | Collectible | Trophy | Cannot buy | 2,000 Silver | 99 |
| 027 | `volcanic_forge_shard` | Volcanic Forge Shard | Collectible | Trophy | Cannot buy | 5,000 Silver | 99 |
| 028 | `void_crystal` | Void Crystal | Collectible | Trophy | Cannot buy | 15,000 Silver | 99 |

---

## Detailed Entries

---

### Consumables — Recovery

---

### [001] HP Potion (Small)

| Field | Value |
|---|---|
| **Item ID** | `hp_potion_small` |
| **Category** | Consumable — Recovery |
| **Stack Limit** | 999 |
| **Buy Price** | 30 Silver |
| **Sell Price** | 3 Silver |
| **Use Context** | In battle or overworld |
| **Target** | Any own pet (alive) |
| **Effect** | Restore 30% of the target pet's Max HP |
| **Turn Cost (Battle)** | None in Wild/NPC battles; costs a turn in PvP (unless Battle Tactician pass owned) |
| **Acquisition** | Item Shop (Hub); wild beast drop 10%; dungeon monster drop 8%; expedition medium return |

> *"A basic green vial sold in every corner of the Hunter's Hub. Tastes like grass. Pets don't care."*

**Dev Notes:**
- Formula: `heal = math.floor(target.MaxHP * 0.30); target.HP = math.min(target.MaxHP, target.HP + heal)`
- Fire via `BattleAction { actionType = "UseItem", itemId = "hp_potion_small", targetPetId = <id> }` C→S
- Deduct 1 from `Inventory["hp_potion_small"]` server-side before applying; reject if quantity = 0

---

### [002] HP Potion (Large)

| Field | Value |
|---|---|
| **Item ID** | `hp_potion_large` |
| **Category** | Consumable — Recovery |
| **Stack Limit** | 999 |
| **Buy Price** | 150 Silver |
| **Sell Price** | 15 Silver |
| **Use Context** | In battle or overworld |
| **Target** | Any own pet (alive) |
| **Effect** | Restore 100% of the target pet's Max HP (full restore) |
| **Turn Cost (Battle)** | None in Wild/NPC battles; costs a turn in PvP |
| **Acquisition** | Item Shop (Hub); dungeon monster drop 3%; expedition long return |

> *"The premium option. Healers brew these from concentrated monster saliva. The label doesn't mention that part."*

**Dev Notes:**
- Formula: `target.HP = target.MaxHP`
- Same item action path as HP Potion (Small); `itemId = "hp_potion_large"`
- Not available during PvP if opponent has drafted an aggressive opening — remind players in tooltip that PvP use costs a turn

---

### [003] Stamina Potion

| Field | Value |
|---|---|
| **Item ID** | `stamina_potion` |
| **Category** | Consumable — Recovery |
| **Stack Limit** | 999 |
| **Buy Price** | 50 Silver |
| **Sell Price** | 5 Silver |
| **Use Context** | In battle or overworld |
| **Target** | Any own pet (alive) |
| **Effect** | Restore 50% of the target pet's Max Stamina |
| **Turn Cost (Battle)** | None in Wild/NPC battles; costs a turn in PvP |
| **Acquisition** | Item Shop (Hub); dungeon monster drop 5% |

> *"Skills burn through Stamina fast. This keeps a pet's heavy moves on the table for one more round."*

**Dev Notes:**
- Formula: `restore = math.floor(target.MaxStamina * 0.50); target.Stamina = math.min(target.MaxStamina, target.Stamina + restore)`
- Stamina stat: base 50 (Common) to 150 (Legendary); see GDD §6.3 for growth values
- No full-restore stamina item exists at launch; full restore only via pet swap + out-of-battle recovery

---

### [004] Energy Drink

| Field | Value |
|---|---|
| **Item ID** | `energy_drink` |
| **Category** | Consumable — Recovery |
| **Stack Limit** | 999 |
| **Buy Price** | 500 Silver |
| **Sell Price** | 50 Silver |
| **Use Context** | Overworld only (cannot use in active battle) |
| **Target** | Player (self) |
| **Effect** | Instantly restore Hunt Energy to 100 (fills from any amount) |
| **Turn Cost (Battle)** | N/A |
| **Acquisition** | Item Shop (Hub); dungeon monster drop 3%; Roblox Premium daily grant (auto-applied on login) |

> *"Bright orange can. Six different flavours. None of them good. Hunters drink it anyway — a full tank means more beasts, more Silver."*

**Dev Notes:**
- Formula: `PlayerData.HuntEnergy = 100; PlayerData.LastEnergyTime = os.time()`
- Must update `LastEnergyTime` on use to prevent lazy regen from double-counting elapsed hours
- Roblox Premium daily grant: checked via `Players:GetPlayerByUserId():MembershipType` on login; grant `energy_drink ×1` only if `PlayerData.PremiumEnergyToday ~= today_date_string`

---

### Consumables — Capture

---

### [005] Basic Trap

| Field | Value |
|---|---|
| **Item ID** | `basic_trap` |
| **Category** | Consumable — Capture |
| **Stack Limit** | 999 |
| **Buy Price** | 50 Silver |
| **Sell Price** | 5 Silver |
| **Use Context** | In battle; target must be below 50% HP |
| **Target** | Enemy (wild beast or capturable dungeon monster) |
| **Base Capture Rate** | 0.30 (30%) |
| **Capture Formula** | `0.30 × (1 - cur_hp / max_hp) × (1 / rarity_modifier)` |
| **Effective Rate (25% HP)** | Common 22.5% / Uncommon 15% / Rare 9% / Epic 4.5% / Legendary 2.25% |
| **Acquisition** | Item Shop (Hub); achievement `first_capture` (×5 grant); wild beast drop 10%; expedition short return |

> *"Woven bark and binding thread. Doesn't look like much, but it's held more than a few scurrying Pigs and Cats."*

**Dev Notes:**
- `CaptureService` validates: beast HP < 50%, trap owned, target is capturable species
- Consumable deducted before roll; no refund on failure
- For dungeon monsters: only Slime (`species_id = "slime"`) and Goblin (`species_id = "goblin"`) are capturable; minimum Iron Trap required (Basic Trap rejected with "Too weak for dungeon prey" message)

---

### [006] Iron Trap

| Field | Value |
|---|---|
| **Item ID** | `iron_trap` |
| **Category** | Consumable — Capture |
| **Stack Limit** | 999 |
| **Buy Price** | 200 Silver |
| **Sell Price** | 20 Silver |
| **Use Context** | In battle; target must be below 50% HP |
| **Target** | Enemy (wild beast or capturable dungeon monster) |
| **Base Capture Rate** | 0.50 (50%) |
| **Effective Rate (25% HP)** | Common 37.5% / Uncommon 25% / Rare 15% / Epic 7.5% / Legendary 3.75% |
| **Acquisition** | Item Shop (Hub); daily quest reward (×3 from "Capture 1 wild beast"); expedition medium return |

> *"Forged iron bands that spring shut in under a second. Dungeon-rated. Standard issue for any hunter planning to bring back a Goblin."*

**Dev Notes:**
- Minimum required trap for dungeon captures (Slime, Goblin in Forest Cave)
- Lowest tier that can function in dungeon capture attempts; `CaptureService` checks `trap_tier >= "iron"` for dungeon targets
- Quest reward delivery: `QuestService` grants via `PlayerService:AddItem(player, "iron_trap", 3)` server-side

---

### [007] Gold Trap

| Field | Value |
|---|---|
| **Item ID** | `gold_trap` |
| **Category** | Consumable — Capture |
| **Stack Limit** | 999 |
| **Buy Price** | 50 Gold |
| **Sell Price** | 5 Gold |
| **Use Context** | In battle; target must be below 50% HP |
| **Target** | Enemy (wild beast or capturable dungeon monster) |
| **Base Capture Rate** | 0.70 (70%) |
| **Effective Rate (25% HP)** | Common 52.5% / Uncommon 35% / Rare 21% / Epic 10.5% / Legendary 5.25% |
| **Acquisition** | Item Shop (Hub); expedition long return (rare); event shop |

> *"Gold-threaded mesh reinforced with enchanted wire. Rare beasts flee from lesser traps — this one keeps up."*

**Dev Notes:**
- Primary recommended trap for Rare rarity wild beasts; at 25% HP gives 21% chance vs Rare
- Gold cost gates access to serious Rare/Epic hunting
- Expedition long return: 5% chance to include Gold Trap in item pool alongside Evolution Shard

---

### [008] Legend Trap

| Field | Value |
|---|---|
| **Item ID** | `legend_trap` |
| **Category** | Consumable — Capture |
| **Stack Limit** | 999 |
| **Buy Price** | 300 Gold |
| **Sell Price** | 30 Gold |
| **Use Context** | In battle; target must be below 50% HP |
| **Target** | Enemy (wild beast or capturable dungeon monster) |
| **Base Capture Rate** | 0.90 (90%) |
| **Effective Rate (25% HP)** | Common 67.5% / Uncommon 45% / Rare 27% / Epic 13.5% / Legendary 6.75% |
| **Acquisition** | Item Shop (Hub); dungeon boss kill 5%; bounty "Defeat the Lich King" (×1); Abyss dungeon boss guaranteed 1× at first clear |

> *"Crafted from the bones of dragons and threaded with moonstone filament. Hunters spend months saving for one. Worth every Silver."*

**Dev Notes:**
- Only viable option for Legendary capture (6.75% at 25% HP); player must reduce to near-minimum HP for best odds
- Capture Booster Developer Product (+20%) applied additionally: `base_rate = 0.90 + 0.20 = 1.10` — clamped to 1.0 (guaranteed capture for Common/Uncommon); Legendary at 25% HP = `1.0 × 0.75 × 0.1 = 7.5%`
- Drop from bosses: `DungeonService` rolls 5% drop at `BATTLE_END` state on boss defeat

---

### Consumables — Evolution Materials

---

### [009] Evolution Shard

| Field | Value |
|---|---|
| **Item ID** | `evolution_shard` |
| **Category** | Consumable — Evolution Material |
| **Stack Limit** | 999 |
| **Buy Price** | 500 Silver **or** 10 Gold (dual pricing) |
| **Sell Price** | 50 Silver |
| **Use Context** | Out of battle only (Evolution menu or NPC) |
| **Target** | Own pet meeting Stage 2 evolution level threshold |
| **Effect** | Consumed (×1) during Base → Stage 2 evolution; also requires 500 Silver payment |
| **Acquisition** | Item Shop (Hub); dungeon boss kill 60%; daily quest "Use a skill 10 times in battle" (×1); bounty "Defeat 30 Goblins" (×2); achievement `pet_lv100` (×1) |

> *"A crystallised sliver of wild energy. Something inside it hums when held near a pet ready to change. Hunters call it 'the spark.'"*

**Dev Notes:**
- Dual buy price: check Silver first (`PlayerData.Silver >= 500`), prompt Gold option if Silver insufficient; player cannot mix currencies for one item
- `PetService:EvolveStage2(petId)` checks: pet level ≥ threshold, `Inventory["evolution_shard"] >= 1`, `PlayerData.Silver >= 500` (or Gold path)
- Most commonly obtained item in mid-game; designed as the primary Silver sink alongside HP potions

---

### [010] Evolution Crystal

| Field | Value |
|---|---|
| **Item ID** | `evolution_crystal` |
| **Category** | Consumable — Evolution Material |
| **Stack Limit** | 999 |
| **Buy Price** | 100 Gold |
| **Sell Price** | 10 Gold |
| **Use Context** | Out of battle only (Evolution menu or NPC) |
| **Target** | Own pet meeting Stage 3 evolution level threshold |
| **Effect** | Consumed (×1) together with the species-specific item during Stage 2 → Stage 3 evolution; also requires 300 Gold payment |
| **Acquisition** | Item Shop (Hub); dungeon boss kill 20% |

> *"Deeper and heavier than a Shard. The crystal's core is black, but it catches light like a prism. Stage 3 evolution requires something ancient — this is part of that something."*

**Dev Notes:**
- `PetService:EvolveStage3(petId)` checks: level threshold, `Inventory["evolution_crystal"] >= 1`, `Inventory[species_item_id] >= 1`, `PlayerData.Gold >= 300`
- Evolution Crystal and species-specific item consumed simultaneously in one atomic operation
- At 20% boss drop rate, one Abyss Rift dungeon run (3 per day) yields expected 0.6 Crystals/run — player needs multiple days of farming for Stage 3

---

### [011] Re-imbue Stone

| Field | Value |
|---|---|
| **Item ID** | `reimibue_stone` |
| **Category** | Consumable — Evolution Material |
| **Stack Limit** | 999 |
| **Buy Price** | 200 Gold |
| **Sell Price** | 20 Gold |
| **Use Context** | Out of battle only (Pet menu → Change Element) |
| **Target** | Own pet at level 50 or higher with an existing element |
| **Effect** | Removes the pet's current element; allows selecting a new element from the 10-element list |
| **Acquisition** | Item Shop (Hub) only; not dropped anywhere |

> *"Hot to the touch. It smells like ozone and burnt feathers. Once you crack it over a pet's head, their element dissolves like smoke. The pet does not seem to enjoy this."*

**Dev Notes:**
- Requires pet is ≥ level 50 AND already has an element assigned (`PetData.Element ~= nil`); cannot be used to imbue from scratch (use level 50 unlock flow instead)
- `PetService:ReimbuElement(petId, newElement)` resets `PetData.Element`, clears element-locked skills from `PetData.EquippedSkills`, refunds those skill slot purchases to inventory (not Gold)
- Only sold in shop; designed as a recurring Gold sink for players who change their build

---

### Consumables — Species-Specific Materials

---

### [012] Treant Heartwood

| Field | Value |
|---|---|
| **Item ID** | `treant_heartwood` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 200 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Treant pet line Stage 3 evolution (Treant → Treant King → Ancient Treant) |
| **Acquisition** | Elder Treant boss (Dark Forest dungeon) — 15% drop; Treant dungeon monster field drop — 2% per kill |

> *"A dense knot of dark heartwood torn from the Elder Treant during its death throes. It still smells of rain and deep forest. Something lives inside it — or used to."*

**Dev Notes:**
- Also required by Treant-line pet Stage 3: `species_item_id = "treant_heartwood"` in Treant species config
- Two drop sources intentional: gives mid-game players in Dark Forest a 2% chance per monster kill as an alternative grind path vs 15% boss
- Sell price high enough (200 Gold) that some players will sell rather than evolve — that's an intended friction/choice

---

### [013] Goblin War Crown

| Field | Value |
|---|---|
| **Item ID** | `goblin_war_crown` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 50 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Goblin pet line Stage 3 evolution (Goblin → Hobgoblin → Goblin Warchief) |
| **Acquisition** | Goblin Warchief boss (Forest Cave dungeon) — 15% drop |

> *"A lopsided crown hammered from scrap metal. Dented, scratched, and missing two points. It sat on the head of something that commanded hundreds. Goblins instinctively bow when they see it."*

**Dev Notes:**
- Low sell value (50 Gold) reflects early-game dungeon origin — Forest Cave boss is first dungeon boss
- Goblin Warchief is also a monster with Stage 3 form if captured as a pet; the crown unlocks that final evolution
- `species_item_id = "goblin_war_crown"` in Goblin species config

---

### [014] Lich's Phylactery

| Field | Value |
|---|---|
| **Item ID** | `lichs_phylactery` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 75 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Skeleton pet line Stage 3 evolution (Skeleton → Bone Knight → Lich) |
| **Acquisition** | Lich King boss (Mountain Ruins dungeon) — 15% drop |

> *"A small obsidian box with a faint glow at the seams. The Lich King bound his own life force inside it. Breaking the seal releases that energy into a pet ready to transcend life and death."*

**Dev Notes:**
- Skeleton pet is not capturable in dungeon (Skeleton is a dungeon-only monster); Skeleton as a wild beast exists in zone_mountain as a separate wild encounter species
- `species_item_id = "lichs_phylactery"` in Skeleton species config
- 75 Gold sell value aligns with Mountain Ruins being mid-game dungeon

---

### [015] Orc Warbrand Fragment

| Field | Value |
|---|---|
| **Item ID** | `orc_warbrand_frag` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 150 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Orc pet line Stage 3 evolution (Orc → War Orc → Orc Overlord) |
| **Acquisition** | Orc Overlord boss (Volcano Pit dungeon) — 15% drop |

> *"Half of a legendary blade shattered by the Overlord himself to prove he needed no weapon. The remaining energy locked inside still radiates heat. Orcs who sense it enter a battle frenzy."*

**Dev Notes:**
- `species_item_id = "orc_warbrand_frag"` in Orc species config
- 150 Gold sell value reflects Volcano Pit difficulty tier (zone_volcano, level 301–600)
- "Fragment" naming is intentional — the full Warbrand is lore-only, never seen in-game

---

### [016] Abyss Essence

| Field | Value |
|---|---|
| **Item ID** | `abyss_essence` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 300 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Demon pet line Stage 3 evolution (Demon → Greater Demon → Abyssal Demon) |
| **Acquisition** | Abyssal Demon Lord boss (Abyss Rift dungeon) — 15% drop |

> *"A sealed vial of swirling black-violet energy drawn from the Demon Lord's core at the moment of defeat. Touch the vial and feel nothing. Open it and feel everything at once."*

**Dev Notes:**
- `species_item_id = "abyss_essence"` in Demon species config
- Abyssal Demon Lord is the hardest boss; 15% drop rate means ~6–7 runs expected to obtain (at 3 runs/day = 2–3 days minimum farming)
- Shares boss source with Petrified Eye, Spirit Orb, Blood Moon Stone — 4 species materials from one boss; each has independent 15% roll

---

### [017] Petrified Eye

| Field | Value |
|---|---|
| **Item ID** | `petrified_eye` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 300 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Basilisk pet line Stage 3 evolution (Basilisk → Stone Basilisk → Gorgon) |
| **Acquisition** | Abyssal Demon Lord boss (Abyss Rift dungeon) — 15% drop |

> *"The calcified eye of an ancient Basilisk, preserved in stone for centuries. The pupil still tracks movement. Some hunters refuse to hold it face-forward."*

**Dev Notes:**
- `species_item_id = "petrified_eye"` in Basilisk species config
- Same boss source as Abyss Essence — Basilisk is an Abyss-zone wild beast, thematically linked to the endgame dungeon
- Each species material roll is independent at 15%; a single boss kill can drop multiple different species materials in the same run

---

### [018] Spirit Orb

| Field | Value |
|---|---|
| **Item ID** | `spirit_orb` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 300 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Kitsune pet line Stage 3 evolution (Kitsune → Nine-Tail Kitsune → Celestial Kitsune) |
| **Acquisition** | Abyssal Demon Lord boss (Abyss Rift dungeon) — 15% drop |

> *"A perfectly round bead of compressed fox-fire sealed inside luminescent jade. Kitsune are drawn to it immediately. A Kitsune that absorbs a Spirit Orb undergoes a transformation no trainer has ever fully described — they simply say 'it changes.'"*

**Dev Notes:**
- `species_item_id = "spirit_orb"` in Kitsune species config
- Kitsune is Epic rarity; Stage 3 at level 300; Spirit Orb + Evolution Crystal + 300 Gold is a significant endgame investment
- Orb lore ties into Kitsune passive Fox Fire (mark explosion mechanic) — Stage 3 Celestial Kitsune increases mark detonation multiplier to ×2.0

---

### [019] Blood Moon Stone

| Field | Value |
|---|---|
| **Item ID** | `blood_moon_stone` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 300 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Werewolf pet line Stage 3 evolution (Werewolf → Alpha Werewolf → Lycan Lord) |
| **Acquisition** | Abyssal Demon Lord boss (Abyss Rift dungeon) — 15% drop |

> *"A deep crimson gem that pulses when the in-game day/night cycle reaches midnight. Werewolves howl when it enters their field of view. Its full name is the Blood Moon Convergence Stone — most hunters just call it 'the red thing.'"*

**Dev Notes:**
- `species_item_id = "blood_moon_stone"` in Werewolf species config
- Lore ties to Werewolf passive Lunar Rage (odd-turn ATK boost); Stage 3 Lycan Lord gains enhanced version valid every turn
- Day/night cycle cosmetic pulse is client-side visual only; no gameplay effect from pulse

---

### [020] Storm Feather

| Field | Value |
|---|---|
| **Item ID** | `storm_feather` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 500 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Thunderbird pet line Stage 3 evolution (Thunderbird → Storm Thunderbird → Sky Sovereign) |
| **Acquisition** | Sky Sovereign world boss mirror match (Stage 3 Thunderbird vs Stage 3 Thunderbird) — 5% drop; seasonal event chest — 3% |

> *"A single primary feather from the Sky Sovereign. Each shaft is wrapped in frozen lightning that crackles when touched. There is no humming. Just silence before a storm."*

**Dev Notes:**
- Rarest species material in the game; no dungeon boss source — requires finding/defeating a Sky Sovereign world event
- Sky Sovereign spawns as a world encounter during Storm Weather events (random world event, periodic); player must own a Stage 2+ Thunderbird to trigger the mirror match
- 5% drop from a conditional event fight is the hardest single item to obtain; intended as a prestige item for dedicated Thunderbird players
- Seasonal event chest 3% provides an alternative for players who missed or cannot trigger the world event

---

### Consumables — Boosts

---

### [021] XP Boost Crystal

| Field | Value |
|---|---|
| **Item ID** | `xp_boost_crystal` |
| **Category** | Consumable — Boost |
| **Stack Limit** | 99 |
| **Buy Price** | 49 R$ (Robux Developer Product only) |
| **Sell Price** | Cannot sell |
| **Use Context** | Overworld (from inventory menu); activates immediately |
| **Target** | Player (self) |
| **Effect** | All pets earn 3× XP from all battle sources for **1 real-time hour** |
| **Acquisition** | Purchase "XP Boost (1h)" Developer Product via `MarketplaceService:PromptProductPurchase` |

> *"A compact crystal of condensed training energy. Once activated, everything your pets do counts triple. The glow lasts exactly one hour. The gains last forever."*

**Dev Notes:**
- On product purchase: `ProcessReceipt` adds `xp_boost_crystal ×1` to inventory server-side (idempotent via receipt ID check)
- On use: `PlayerData.XPBoostExpiry = os.time() + 3600`
- XP multiplier check in `BattleService:DistributeXP`: `if os.time() < PlayerData.XPBoostExpiry then xp = xp * 3 end`
- Timer runs even if player logs off; does not pause for offline time
- Cannot be granted by any in-game mechanic — Robux purchase only; no pay-to-win concern (XP does not affect PvP balance directly, only progression speed)

---

### [022] Capture Booster

| Field | Value |
|---|---|
| **Item ID** | `capture_booster` |
| **Category** | Consumable — Boost |
| **Stack Limit** | 99 |
| **Buy Price** | 19 R$ (Robux Developer Product only) |
| **Sell Price** | Cannot sell |
| **Use Context** | Passive; charges depleted per capture attempt in battle |
| **Target** | Player (self) |
| **Effect** | Adds +20% to the base capture rate for the **next 5 capture attempts**; applies additively to `base_rate` before rarity and HP modifiers |
| **Acquisition** | Purchase "Capture Boost" Developer Product via `MarketplaceService:PromptProductPurchase` |

> *"A flask of shimmering reagent. Splash it on your trap before throwing and the odds tip ever-so-slightly in your favour. Five doses per flask."*

**Dev Notes:**
- On product purchase: adds `capture_booster ×1` to inventory
- On first capture attempt: `PlayerData.CaptureBoostCharges = 5`; consume `capture_booster ×1` from inventory
- Per attempt: if `CaptureBoostCharges > 0`, `base_rate += 0.20`, then `CaptureBoostCharges -= 1`
- Effective capture formula with Legend Trap: `(0.90 + 0.20) × (1 - hp/max_hp) × (1/rarity_mod)` — base_rate clamped to 1.0 before rarity modifier is applied
- Charges persist across sessions in `PlayerData.CaptureBoostCharges`; carried until depleted

---

### [023] Dungeon Key

| Field | Value |
|---|---|
| **Item ID** | `dungeon_key` |
| **Category** | Consumable — Boost |
| **Stack Limit** | 99 |
| **Buy Price** | 39 R$ (Robux Developer Product only) |
| **Sell Price** | Cannot sell |
| **Use Context** | Consumed at dungeon entry |
| **Target** | Player (self); applies to one dungeon run of the player's choice |
| **Effect** | Grants **+1 dungeon run** today for any single dungeon; bypasses the 3-run daily cap for one entry |
| **Acquisition** | Purchase "Dungeon Key" Developer Product via `MarketplaceService:PromptProductPurchase` |

> *"A rusted iron key with no visible lock. Dungeon Wardens will accept it as a substitute for the daily entry limit. Nobody questions why it works. Nobody asks twice."*

**Dev Notes:**
- On product purchase: adds `dungeon_key ×1` to inventory
- On dungeon entry attempt when `DungeonRunsToday[dungeonId] >= 3`: check `Inventory["dungeon_key"] >= 1`; if so, allow entry and deduct key before teleport
- Key consumed regardless of run outcome (flee or complete)
- Does not stack with Dungeon Veteran game pass logic; game pass grants +1 daily cap permanently; key grants a one-time extra on top of current cap

---

### Collectibles — Boss Trophies

---

### [024] Goblin Chief's Trophy

| Field | Value |
|---|---|
| **Item ID** | `goblin_chiefs_trophy` |
| **Category** | Collectible — Trophy |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 500 Silver |
| **Gameplay Effect** | None |
| **Acquisition** | Goblin Warchief boss (Forest Cave dungeon) — 40% drop on kill |
| **Dungeon Source** | `dungeon_forest` |

> *"A crude war banner made from Goblin-clan pelts, stitched with names of defeated tribes. They add names until there's no space left. Then they add more pelts. The Chief who carried this had no more space."*

**Dev Notes:**
- Dropped by `DungeonService` on boss kill with independent 40% roll; separate from the 15% species material roll
- Players who hoard trophies before selling: tooltip shows "Goblin Chief's Trophy — Sell for 500 Silver" in inventory
- Future feature: trophy display rack in player's home (post-launch)

---

### [025] Ancient Bone Relic

| Field | Value |
|---|---|
| **Item ID** | `ancient_bone_relic` |
| **Category** | Collectible — Trophy |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 1,500 Silver |
| **Gameplay Effect** | None |
| **Acquisition** | Lich King boss (Mountain Ruins dungeon) — 40% drop on kill |
| **Dungeon Source** | `dungeon_mountain` |

> *"A finger bone from the original Lich, carved with runes pre-dating the written language of the Mountain Ruins. Scholars offer serious money for one. Item Shop pays 1,500 Silver. Scholars are not in the Item Shop."*

**Dev Notes:**
- 3× the Silver value of Forest Cave trophy reflects Mountain Ruins being the second dungeon (mid-game)
- No unique display property at launch; future plan for trophy glass case in player HQ

---

### [026] Enchanted Bark Rune

| Field | Value |
|---|---|
| **Item ID** | `enchanted_bark_rune` |
| **Category** | Collectible — Trophy |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 2,000 Silver |
| **Gameplay Effect** | None |
| **Acquisition** | Elder Treant boss (Dark Forest dungeon) — 40% drop on kill |
| **Dungeon Source** | `dungeon_darkforest` |

> *"A bark disc the size of a palm, carved with a druidic seal that radiates faint warmth. The Elder Treant carved one of these every century and wore them as armour. This was the outermost one."*

**Dev Notes:**
- Dark Forest boss is level 269, same tier as Mountain Ruins; 2,000 Silver slightly higher than Ancient Bone Relic to differentiate the two parallel mid-game dungeons
- Item tooltip notes dungeon of origin for collector tracking purposes

---

### [027] Volcanic Forge Shard

| Field | Value |
|---|---|
| **Item ID** | `volcanic_forge_shard` |
| **Category** | Collectible — Trophy |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 5,000 Silver |
| **Gameplay Effect** | None |
| **Acquisition** | Orc Overlord boss (Volcano Pit dungeon) — 40% drop on kill |
| **Dungeon Source** | `dungeon_volcano` |

> *"A chunk of magma-forged metal broken from the Overlord's personal anvil during the battle. The surface never fully cools. Handling it requires a thick grip and a short attention span."*

**Dev Notes:**
- 5,000 Silver sell price: significant passive income for Volcano farmers; intended to reward players clearing the third-hardest dungeon
- Accounts for the Gold+Silver income gap players face transitioning from mid to late game

---

### [028] Void Crystal

| Field | Value |
|---|---|
| **Item ID** | `void_crystal` |
| **Category** | Collectible — Trophy |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 15,000 Silver |
| **Gameplay Effect** | None |
| **Acquisition** | Abyssal Demon Lord boss (Abyss Rift dungeon) — 40% drop on kill |
| **Dungeon Source** | `dungeon_abyss` |

> *"A pitch-black crystal fragment torn from the Demon Lord's throne at the moment of defeat. It absorbs all light around it within three inches. No one has looked directly into it and agreed on what they saw."*

**Dev Notes:**
- At 15,000 Silver sell price, each Abyss run expected yield from trophy alone: `15,000 × 0.40 = 6,000 Silver EV` — this is intentional top-end Silver income for endgame players
- 3 daily runs × 40% = 1.2 trophies/day expected → 18,000 Silver/day from trophy sell alone
- Pairs with `boss_level × 50` Silver baseline drop (Demon Lord Lv1000 → 50,000 Silver guaranteed per run) to make Abyss the richest farming location

---

## Evolution Material Usage Reference

Quick-reference table for which species material is required per pet family Stage 3 evolution. All Stage 3 evolutions also require ×1 Evolution Crystal and 300 Gold.

| Species Material | Item ID | Pet Line | Stage 3 Form | Primary Source |
|---|---|---|---|---|
| Treant Heartwood | `treant_heartwood` | Treant | Ancient Treant | Elder Treant boss 15% |
| Goblin War Crown | `goblin_war_crown` | Goblin | Goblin Warchief | Goblin Warchief boss 15% |
| Lich's Phylactery | `lichs_phylactery` | Skeleton | Lich | Lich King boss 15% |
| Orc Warbrand Fragment | `orc_warbrand_frag` | Orc | Orc Overlord | Orc Overlord boss 15% |
| Abyss Essence | `abyss_essence` | Demon | Abyssal Demon | Abyssal Demon Lord boss 15% |
| Petrified Eye | `petrified_eye` | Basilisk | Gorgon | Abyssal Demon Lord boss 15% |
| Spirit Orb | `spirit_orb` | Kitsune | Celestial Kitsune | Abyssal Demon Lord boss 15% |
| Blood Moon Stone | `blood_moon_stone` | Werewolf | Lycan Lord | Abyssal Demon Lord boss 15% |
| Storm Feather | `storm_feather` | Thunderbird | Sky Sovereign | World event mirror match 5% |

> Species materials not listed here have not yet been defined. All other pet families use a species material with `item_id = "<species>_<unique_token>"` to be documented as additional beasts are added.

---

## Capture Rate Reference

Effective capture chance at **25% HP remaining** (0.75 HP consumed factor) for each trap × rarity combination.

| Trap | Base Rate | Common | Uncommon | Rare | Epic | Legendary |
|---|---|---|---|---|---|---|
| Basic Trap | 0.30 | 22.5% | 15.0% | 9.0% | 4.5% | 2.25% |
| Iron Trap | 0.50 | 37.5% | 25.0% | 15.0% | 7.5% | 3.75% |
| Gold Trap | 0.70 | 52.5% | 35.0% | 21.0% | 10.5% | 5.25% |
| Legend Trap | 0.90 | 67.5% | 45.0% | 27.0% | 13.5% | 6.75% |

*Capture Booster (+0.20 additive to base rate) improves these values further; base rate clamped to 1.0 before rarity modifier.*
