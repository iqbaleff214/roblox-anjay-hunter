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
| Status Cure | Consumable | Removes one or more active negative status effects from own pet |
| Stat Booster | Consumable | Grants a temporary ATK / DEF / SPD buff to own pet for 3 turns |
| Revival | Consumable | Restores HP to a fainted (0 HP) pet; in-battle use only |
| Overworld Utility | Consumable | Modifies wild encounter rate or spawn rarity in the overworld for 30 minutes |
| Event Currency | Collectible | Seasonal event spendable currency; no function outside active event window |
| Trophy | Collectible | Boss or field drops; no mechanical use; sell or display |

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
| **Wild beast battle (Stage 2+)** | Species Materials (8% per respective species), Shiny Scale (2%), Emerald Feather (2–3%) |
| **Wild beast battle (Abyss zone)** | Void Shard (3–5%), Anaconda Venom Gem (8%), Dragon Scale (10%) |
| **Seasonal Event chest** | Boost items, Lucky Charm, event-exclusive Species Materials |
| **Robux Developer Product** | XP Boost Crystal, Capture Booster, Dungeon Key, Lucky Charm |

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
| 029 | `dragon_scale` | Dragon Scale | Consumable | Species Material | Cannot buy | 400 Gold | 99 |
| 030 | `phoenix_ash` | Phoenix Ash | Consumable | Species Material | Cannot buy | 400 Gold | 99 |
| 031 | `shadow_fang` | Shadow Fang | Consumable | Species Material | Cannot buy | 150 Gold | 99 |
| 032 | `kings_mane_lock` | King's Mane Lock | Consumable | Species Material | Cannot buy | 150 Gold | 99 |
| 033 | `tempest_quill` | Tempest Quill | Consumable | Species Material | Cannot buy | 100 Gold | 99 |
| 034 | `void_slime_core` | Void Slime Core | Consumable | Species Material | Cannot buy | 30 Gold | 99 |
| 035 | `ancient_shell_plate` | Ancient Shell Plate | Consumable | Species Material | Cannot buy | 100 Gold | 99 |
| 036 | `fox_spirit_bead` | Fox Spirit Bead | Consumable | Species Material | Cannot buy | 50 Gold | 99 |
| 037 | `dire_pelt` | Dire Pelt | Consumable | Species Material | Cannot buy | 50 Gold | 99 |
| 038 | `anaconda_venom_gem` | Anaconda Venom Gem | Consumable | Species Material | Cannot buy | 200 Gold | 99 |
| 039 | `antidote` | Antidote | Consumable | Status Cure | 100 Silver | 10 Silver | 999 |
| 040 | `remedy` | Remedy | Consumable | Status Cure | 150 Silver | 15 Silver | 999 |
| 041 | `warming_herb` | Warming Herb | Consumable | Status Cure | 100 Silver | 10 Silver | 999 |
| 042 | `full_cure` | Full Cure | Consumable | Status Cure | 500 Silver / 5 Gold | 50 Silver | 999 |
| 043 | `power_herb` | Power Herb | Consumable | Stat Booster | 200 Silver | 20 Silver | 999 |
| 044 | `guard_stone` | Guard Stone | Consumable | Stat Booster | 200 Silver | 20 Silver | 999 |
| 045 | `swift_root` | Swift Root | Consumable | Stat Booster | 200 Silver | 20 Silver | 999 |
| 046 | `revive_seed` | Revive Seed | Consumable | Revival | 30 Gold | 5 Gold | 99 |
| 047 | `beast_lure` | Beast Lure | Consumable | Overworld Utility | 300 Silver | 30 Silver | 99 |
| 048 | `repellent` | Beast Repellent | Consumable | Overworld Utility | 200 Silver | 20 Silver | 99 |
| 049 | `festival_coin` | Festival Coin | Collectible | Event Currency | Cannot buy | Cannot sell | 9,999 |
| 050 | `lucky_charm` | Lucky Charm | Consumable | Boost | Robux (29 R$) / Battle Pass | Cannot sell | 99 |
| 051 | `shiny_scale` | Shiny Scale | Collectible | Trophy | Cannot buy | 200 Silver | 99 |
| 052 | `emerald_feather` | Emerald Feather | Collectible | Trophy | Cannot buy | 500 Silver | 99 |
| 053 | `void_shard` | Void Shard | Collectible | Trophy | Cannot buy | 3,000 Silver | 99 |

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

---

### Species Materials Continued (029–038)

---

### [029] Dragon Scale

| Field | Value |
|---|---|
| **Item ID** | `dragon_scale` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 400 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Dragon pet line Stage 3 evolution (Whelp → Drake → Elder Dragon) |
| **Acquisition** | Wild Dragon battle (Abyss zone) — 10% drop on victory; first-ever Dragon capture — 1× guaranteed |

> *"The Elder Dragon sheds one scale per century. Finding one on the ground is considered either divine luck or a very bad omen, depending on which hunter's guild you ask."*

**Dev Notes:**
- `species_item_id = "dragon_scale"` in Dragon species config
- Dragon is Legendary rarity; wild spawns are rare in Abyss zone; 10% drop from defeating (not necessarily capturing) any Dragon-line wild beast
- First-capture guarantee: `CaptureService` checks `PlayerData.CodexEntries["dragon"] == nil`; on successful capture add `dragon_scale ×1` unconditionally
- 400 Gold sell value reflects Legendary tier + Abyss zone difficulty; second-highest sell value in Species Material category (tied with Phoenix Ash)

---

### [030] Phoenix Ash

| Field | Value |
|---|---|
| **Item ID** | `phoenix_ash` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 400 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Phoenix pet line Stage 3 evolution (Phoenix → Fire Phoenix → Eternal Phoenix) |
| **Acquisition** | Wild Phoenix battle (Volcano zone) — 10% drop on victory; first-ever Phoenix capture — 1× guaranteed; Orc Overlord boss (Volcano Pit) — 3% rare drop |

> *"Collected from the smouldering remains left behind when a Phoenix resurrects itself. The ash is cool to the touch and smells like ozone. No one has clarified how the taste was discovered."*

**Dev Notes:**
- `species_item_id = "phoenix_ash"` in Phoenix species config
- Phoenix Rebirth passive: when Phoenix is KO'd for the second time in a battle, 10% chance to drop `phoenix_ash ×1` as a field reward regardless of capture outcome
- Orc Overlord 3% drop provides an alternative path for players who haven't triggered a wild Phoenix spawn
- Phoenix is Legendary rarity; appears only in Volcano zone and Abyss zone (rare)

---

### [031] Shadow Fang

| Field | Value |
|---|---|
| **Item ID** | `shadow_fang` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 150 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Tiger pet line Stage 3 evolution (Tiger → White Tiger → Shadow Tiger) |
| **Acquisition** | Wild Tiger-line battle (Mountain zone) — 8% drop from Stage 2+ White Tiger only; Lich King boss (Mountain Ruins) — 5% rare drop |

> *"A jet-black claw from a White Tiger that completed a kill in total darkness. The claw is permanently stained with shadow. Shadow Tigers form when this fang's stored darkness merges with a White Tiger that refuses to be seen."*

**Dev Notes:**
- `species_item_id = "shadow_fang"` in Tiger species config
- Drop only from Stage 2+ wild; `BattleService` checks `wild_beast.EvolutionStage >= 2` before rolling; Stage 1 Tiger battle yields no drop
- Lich King 5% is a secondary path — Mountain Ruins runners get minor cross-benefit
- Tiger is Rare rarity (GDD §6.2); Stage 3 at level 200

---

### [032] King's Mane Lock

| Field | Value |
|---|---|
| **Item ID** | `kings_mane_lock` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 150 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Lion pet line Stage 3 evolution (Lion → Battle Lion → Pride Sovereign) |
| **Acquisition** | Wild Lion-line battle (Mountain zone) — 8% drop from Stage 2+ Battle Lion; Elder Treant boss (Dark Forest) — 5% rare drop |

> *"A knot of mane taken from the dominant male of a Battle Lion pride, braided with bone beads by rival members as a trophy of dominance. The Pride Sovereign transformation requires the Lion to internalise what the knot represents."*

**Dev Notes:**
- `species_item_id = "kings_mane_lock"` in Lion species config
- Lion is Rare rarity; Stage 2 at level 50, Stage 3 at level 200
- Elder Treant 5% gives Dark Forest runners secondary value — two different Rare-pet species materials from two separate dungeons

---

### [033] Tempest Quill

| Field | Value |
|---|---|
| **Item ID** | `tempest_quill` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 100 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Eagle pet line Stage 3 evolution (Eagle → War Eagle → Tempest Eagle) |
| **Acquisition** | Wild Eagle-line battle (Forest or Mountain zone) — 8% drop from Stage 2+ War Eagle; seasonal Sky event chest — 1× guaranteed |

> *"A primary flight feather from a War Eagle that survived a direct lightning strike. The shaft is fused with charged air and vibrates faintly in still weather. Tempest Eagles carry the storm's memory inside this feather."*

**Dev Notes:**
- `species_item_id = "tempest_quill"` in Eagle species config
- Eagle is Rare rarity (GDD §6.2); distinct from Thunderbird; Tempest Quill ≠ Storm Feather — different icons: Tempest Quill = amber/gold, Storm Feather = electric blue
- Tooltip must explicitly differentiate the two feather items to prevent confusion
- Seasonal Sky event chest grant is a catch-up mechanic for players who miss the normal drop window

---

### [034] Void Slime Core

| Field | Value |
|---|---|
| **Item ID** | `void_slime_core` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 30 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Slime pet line Stage 3 evolution (Slime → Slime King → Slime Titan) |
| **Acquisition** | Forest Cave dungeon Slime monster kill — 3% field drop; Goblin Warchief boss first clear — 1× guaranteed bonus |

> *"The compressed nucleus of a Slime that absorbed too much ambient dungeon energy and imploded. Gooey, weightless, faintly transparent. Slime Kings absorb it on contact and refuse to release it."*

**Dev Notes:**
- `species_item_id = "void_slime_core"` in Slime species config
- Slime is Common rarity; 30 Gold sell value is the lowest in Species Materials — reflects accessible early-dungeon source
- 3% per Slime kill in Forest Cave: ~14 Slimes per full run → ~0.42 expected cores/run → ~7 runs (2–3 days) for one core
- First-clear bonus: `DungeonService` checks `PlayerData.DungeonFirstClear["dungeon_forest"] == nil`; grants `void_slime_core ×1` once on first Goblin Warchief kill, separate from the 15% species material roll

---

### [035] Ancient Shell Plate

| Field | Value |
|---|---|
| **Item ID** | `ancient_shell_plate` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 100 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Turtle pet line Stage 3 evolution (Turtle → Armored Turtle → Titan Turtle) |
| **Acquisition** | Wild Turtle-line battle (Mountain zone) — 8% drop from Stage 2+ Armored Turtle; Mountain Ruins dungeon monster kill — 2% rare drop from Skeleton encounters |

> *"A carapace plate shed naturally by an Armored Turtle at critical age. Weighs more than expected. Titan Turtles grow their final shell from this plate as a seed — the old shell becomes the new foundation."*

**Dev Notes:**
- `species_item_id = "ancient_shell_plate"` in Turtle species config
- Turtle is Common rarity; Stage 2 at level 100; Stage 3 at level 100 (Common threshold)... correction: per GDD §6.6 Common Stage 2 = Level 20, Stage 3 = Level 100
- Skeleton 2% drop path is low but provides any Mountain Ruins runner a passive chance
- Shell Plate's 100 Gold sell value is mid-tier — Turtle is Common but Mountain zone access required for Stage 2 drops

---

### [036] Fox Spirit Bead

| Field | Value |
|---|---|
| **Item ID** | `fox_spirit_bead` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 50 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Fox pet line Stage 3 evolution (Fox → Trickster Fox → Spirit Fox) |
| **Acquisition** | Wild Fox-line battle (Forest zone) — 8% drop from Stage 2+ Trickster Fox; Dark Forest dungeon Hostile Fairy kill — 2% rare drop |

> *"An amber bead formed inside a Trickster Fox's tail after years of cultivating illusion magic. No two beads are the same colour under light. Spirit Foxes manifest their third tail from the energy sealed inside."*

**Dev Notes:**
- `species_item_id = "fox_spirit_bead"` in Fox species config
- Fox and Kitsune are distinct species with distinct Stage 3 materials: Fox Spirit Bead (amber icon) vs Spirit Orb (jade icon); tooltip must display item ID to avoid confusion
- Hostile Fairy 2% drop is lore-consistent: fairies and foxes share illusion-magic affinity in the game world

---

### [037] Dire Pelt

| Field | Value |
|---|---|
| **Item ID** | `dire_pelt` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 50 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Dog pet line Stage 3 evolution (Dog → Wolf → Dire Wolf) |
| **Acquisition** | Wild Wolf battle (Forest or Mountain zone) — 8% drop from Stage 2+ Wolf; Forest Cave dungeon Goblin kill — 2% rare drop (Goblins hunt wolves for pelts) |

> *"A hide stripped from a Stage 2 Wolf after a fierce battle, marked with claw scars from ten seasons of fighting. The Dog lineage that absorbs this pelt does not become tame again. It becomes something older."*

**Dev Notes:**
- `species_item_id = "dire_pelt"` in Dog species config
- Dog (`species_id = "dog"`) Stage 3 = Dire Wolf; distinct from standalone Wolf beast (`species_id = "wolf"`, BEAST.md 044) whose own Stage 3 material is not yet defined
- 8% drop from Stage 2+ wild Wolf; Stage 1 Wolf battle yields no Dire Pelt drop
- Goblin 2% lore-drop is a flavour mechanism — low rate, not intended as a farming path

---

### [038] Anaconda Venom Gem

| Field | Value |
|---|---|
| **Item ID** | `anaconda_venom_gem` |
| **Category** | Consumable — Species Material |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 200 Gold |
| **Use Context** | Out of battle (Stage 3 evolution only) |
| **Used For** | Anaconda pet line Stage 3 evolution (Anaconda → King Anaconda → Leviathan Serpent) |
| **Acquisition** | Wild Anaconda-line battle (Abyss zone) — 8% drop from Stage 2+ King Anaconda; Abyss Rift dungeon Demon monster kill — 3% rare drop |

> *"A crystallised venom gland from a King Anaconda. The venom inside has not degraded in centuries. Leviathan Serpents don't produce venom — the gem's energy becomes the constriction aura that makes them unstoppable."*

**Dev Notes:**
- `species_item_id = "anaconda_venom_gem"` in Anaconda species config
- Anaconda is Rare rarity (BEAST.md 046); Abyss zone placement means Leviathan Serpent is an endgame Stage 3 target
- 200 Gold sell value — Abyss zone + Rare tier, but below the Legendary-tier materials (Dragon Scale, Phoenix Ash at 400 Gold)

---

### Consumables — Status Cure

---

### [039] Antidote

| Field | Value |
|---|---|
| **Item ID** | `antidote` |
| **Category** | Consumable — Status Cure |
| **Stack Limit** | 999 |
| **Buy Price** | 100 Silver |
| **Sell Price** | 10 Silver |
| **Use Context** | In battle or overworld |
| **Target** | Any own pet (alive) |
| **Effect** | Removes all active **Poison** and **Burn** stacks from the target pet immediately; all remaining DoT ticks cancelled |
| **Turn Cost (Battle)** | None in Wild/NPC; costs a turn in PvP |
| **Acquisition** | Item Shop (Hub); wild beast drop 5% (Nature/Fire-type beasts); dungeon monster drop 4% |

> *"A bitter green liquid that neutralises Poison and Burn simultaneously. Smells like medicinal moss. Pets usually spit it out the first time. By the third time, they've accepted their fate."*

**Dev Notes:**
- `for i, effect in ipairs(pet.ActiveEffects) do if effect.name == "Poison" or effect.name == "Burn" then table.remove(pet.ActiveEffects, i) end end`
- Antidote does NOT cure Armor Break, Blind, Shock, Freeze, or Bind
- Poison: 5T, −3% MaxHP/turn; Burn: 3T, −5% MaxHP/turn — all remaining ticks cancelled on apply
- Most common status cure; cheap at 100 Silver for early-zone Poison-heavy encounters (Nature beasts, Forest Cave monsters)

---

### [040] Remedy

| Field | Value |
|---|---|
| **Item ID** | `remedy` |
| **Category** | Consumable — Status Cure |
| **Stack Limit** | 999 |
| **Buy Price** | 150 Silver |
| **Sell Price** | 15 Silver |
| **Use Context** | In battle or overworld |
| **Target** | Any own pet (alive) |
| **Effect** | Removes all active **Blind** and **Shock** stacks from the target pet immediately |
| **Turn Cost (Battle)** | None in Wild/NPC; costs a turn in PvP |
| **Acquisition** | Item Shop (Hub); dungeon monster drop 3% from Dark/Electric-type enemies |

> *"A vial of luminescent white fluid pressed from moonflower roots. Cures the dimness of Blind and the stuttering of Shock. If you can see the vial, you probably need it."*

**Dev Notes:**
- Remove all `effect.name == "Blind"` or `effect.name == "Shock"` entries from `pet.ActiveEffects`
- Blind: 2T, 50% miss chance; Shock: 2T, −25% SPD
- Slightly more expensive than Antidote (150 vs 100 Silver) — Shock's SPD debuff is strategically more impactful in PvP; price reflects utility
- Primarily useful in Mountain/Abyss zones where Skeleton Shock and Specter Blind are common

---

### [041] Warming Herb

| Field | Value |
|---|---|
| **Item ID** | `warming_herb` |
| **Category** | Consumable — Status Cure |
| **Stack Limit** | 999 |
| **Buy Price** | 100 Silver |
| **Sell Price** | 10 Silver |
| **Use Context** | In battle only (overworld use has no effect) |
| **Target** | Any own pet (alive or Frozen) |
| **Effect** | Removes **Freeze** from the target pet; pet may act normally on their next turn; also removes **Bind** (Petrify/Bound) |
| **Turn Cost (Battle)** | None in Wild/NPC; costs a turn in PvP |
| **Acquisition** | Item Shop (Hub); wild beast drop 5% from Ice-type beasts; dungeon drop 3% from Mountain Ruins |

> *"Dried spice bundle from the Volcano foothills. Burn it near a Frozen pet and watch the ice crack in seconds. Volcano hunters carry three. Mountain hunters carry ten."*

**Dev Notes:**
- Freeze: 1-turn skip at `ACTION_SELECT`; item is used by the trainer (not the pet), so a Frozen pet can still be targeted
- Remove `effect.name == "Freeze"` and `effect.name == "Bind"` from `pet.ActiveEffects`; restore `pet.CanAct = true` for next turn
- Bind (Petrify, Gorgon Gaze): 2T full immobilisation; Warming Herb is the only single-purpose cure for both Freeze and Bind
- Does NOT cure Shock (a different SPD debuff entirely — use Remedy)

---

### [042] Full Cure

| Field | Value |
|---|---|
| **Item ID** | `full_cure` |
| **Category** | Consumable — Status Cure |
| **Stack Limit** | 999 |
| **Buy Price** | 500 Silver **or** 5 Gold (dual pricing) |
| **Sell Price** | 50 Silver |
| **Use Context** | In battle or overworld |
| **Target** | Any own pet (alive) |
| **Effect** | Removes **all** active negative status effects from the target pet: Poison, Burn, Freeze, Bind, Blind, Shock, Armor Break, Taunt |
| **Turn Cost (Battle)** | None in Wild/NPC; costs a turn in PvP |
| **Acquisition** | Item Shop (Hub); dungeon boss kill 10% bonus drop; rare bounty reward |

> *"A multi-spectrum cure brewed by senior alchemists in the Hub. One dose handles everything. Worth it the moment a Basilisk Petrifies your best pet on turn one."*

**Dev Notes:**
- Iterates `pet.ActiveEffects` and removes all entries where `effect.debuff == true`; preserves positive effects (Regen, ATK buffs from items/skills)
- Does NOT cleanse passives stored outside `ActiveEffects`: Constrictor aura (`anaconda`), Beaver Grand Levee, or any mechanic explicitly documented as uncleansable
- Dual buy price: check Silver first; if `Silver < 500`, prompt Gold option
- Premium status cure; three focused cures (Antidote/Remedy/Warming Herb) are cheaper alternatives for predictable encounters; Full Cure for emergencies or multi-status situations

---

### Consumables — Stat Boosters

---

### [043] Power Herb

| Field | Value |
|---|---|
| **Item ID** | `power_herb` |
| **Category** | Consumable — Stat Booster |
| **Stack Limit** | 999 |
| **Buy Price** | 200 Silver |
| **Sell Price** | 20 Silver |
| **Use Context** | In battle only |
| **Target** | Any own pet (alive) |
| **Effect** | Grants **+25% ATK** for **3 turns** (stored as a `buff` in `ActiveEffects`); stacks additively with multiple uses |
| **Turn Cost (Battle)** | None in Wild/NPC; costs a turn in PvP |
| **Acquisition** | Item Shop (Hub); dungeon monster drop 3%; expedition medium return (uncommon chance) |

> *"A fistful of compressed red root extract. Pets that eat it get visibly agitated, then hit harder. The effect fades after three exchanges. The agitation fades after four."*

**Dev Notes:**
- `ActiveEffects:add({ name = "ATK_buff", magnitude = 0.25, turns_remaining = 3, debuff = false, source = "item" })`
- Effective ATK: `effective_ATK = base_ATK * (1 + sum_of_ATK_buff_magnitudes)`
- Two herbs: `+50%` ATK; internal ATK multiplier cap = `×3.0` total to prevent degenerate stacking
- `source = "item"` flag means Full Cure can cleanse it; passive ATK gains (e.g., Pack Leader, Undying Grit) cannot be cleansed

---

### [044] Guard Stone

| Field | Value |
|---|---|
| **Item ID** | `guard_stone` |
| **Category** | Consumable — Stat Booster |
| **Stack Limit** | 999 |
| **Buy Price** | 200 Silver |
| **Sell Price** | 20 Silver |
| **Use Context** | In battle only |
| **Target** | Any own pet (alive) |
| **Effect** | Grants **+25% DEF** for **3 turns**; stacks additively with multiple uses |
| **Turn Cost (Battle)** | None in Wild/NPC; costs a turn in PvP |
| **Acquisition** | Item Shop (Hub); dungeon monster drop 3%; expedition medium return (uncommon chance) |

> *"A palm-sized mineral lump with a faint blue sheen. Pets that absorb it briefly display a crystalline layer on their voxel model. The layer does nothing graphically useful but looks impressive."*

**Dev Notes:**
- `ActiveEffects:add({ name = "DEF_buff", magnitude = 0.25, turns_remaining = 3, debuff = false, source = "item" })`
- Formula interaction with Armor Break: `effective_DEF = (base_DEF * DEF_buff_mult) * (1 - armor_break_reduction)` — Guard Stone buff applies before Armor Break reduction
- Guard Stone and Armor Break are not counters; a 3-stack Armor Break (−90% DEF) still significantly reduces effective DEF even with a Guard Stone active
- Caps at ×3.0 total DEF multiplier

---

### [045] Swift Root

| Field | Value |
|---|---|
| **Item ID** | `swift_root` |
| **Category** | Consumable — Stat Booster |
| **Stack Limit** | 999 |
| **Buy Price** | 200 Silver |
| **Sell Price** | 20 Silver |
| **Use Context** | In battle only |
| **Target** | Any own pet (alive) |
| **Effect** | Grants **+25% SPD** for **3 turns**; may affect turn order at next `TURN_START` sort |
| **Turn Cost (Battle)** | None in Wild/NPC; costs a turn in PvP |
| **Acquisition** | Item Shop (Hub); dungeon monster drop 3%; expedition medium return (uncommon chance) |

> *"Thin green root chewed by hunters before long runs. Pets that eat it fidget, then act first. The SPD gain is real. The fidgeting is also real and mildly annoying."*

**Dev Notes:**
- `ActiveEffects:add({ name = "SPD_buff", magnitude = 0.25, turns_remaining = 3, debuff = false, source = "item" })`
- Turn order: SPD changes mid-battle do NOT retroactively reorder the current turn; applied at next `TURN_START` sort
- Swift Root (+25% SPD) and Shock debuff (−25% SPD) cancel at equal magnitude; net SPD = base SPD
- Most impactful in PvP for speed-class pets (Wind/Fire) trying to guarantee turn priority
- Caps at ×3.0 SPD multiplier

---

### Consumable — Revival

---

### [046] Revive Seed

| Field | Value |
|---|---|
| **Item ID** | `revive_seed` |
| **Category** | Consumable — Revival |
| **Stack Limit** | 99 |
| **Buy Price** | 30 Gold |
| **Sell Price** | 5 Gold |
| **Use Context** | In battle only; target must be fainted (0 HP) |
| **Target** | Any own pet at 0 HP |
| **Effect** | Revives the target pet at **50% Max HP**; pet re-enters turn order at the next `TURN_START` sort |
| **Turn Cost (Battle)** | Costs a turn (Wild/NPC/PvP equally) |
| **Acquisition** | Item Shop (Hub); dungeon boss kill 8% drop; expedition long return (rare) |

> *"A smooth golden seed found only in deep dungeon caverns. Hunters debate whether it grows something or simply stores vitality. Nobody has planted one to check. The results on fainted pets are conclusive enough."*

**Dev Notes:**
- Use condition: `target.HP == 0 AND target.OwnerId == player.UserId` — cannot revive opponent's pet or a pet not in the current roster
- `target.HP = math.floor(target.MaxHP * 0.50)`; `target.Fainted = false`; pet joins turn order at next `TURN_START`
- Gold pricing (30 Gold) makes this scarce by design — Revive Seeds are emergency tools, not routine cycling
- Out-of-battle KO recovery: pets return to 1 HP automatically on battle end; Revive Seed is exclusively a mid-battle mechanic
- Does NOT restore Stamina; a revived pet may still have 0 Stamina and be unable to use skills

---

### Consumables — Overworld Utility

---

### [047] Beast Lure

| Field | Value |
|---|---|
| **Item ID** | `beast_lure` |
| **Category** | Consumable — Overworld Utility |
| **Stack Limit** | 99 |
| **Buy Price** | 300 Silver |
| **Sell Price** | 30 Silver |
| **Use Context** | Overworld only; activates immediately on use |
| **Target** | Player (self) |
| **Effect** | For **30 real-time minutes**: Uncommon encounter weight ×1.5, Rare weight ×2.0, Epic weight ×1.5; Common weight reduced proportionally |
| **Duration** | 30 minutes (`PlayerData.LureExpiry = os.time() + 1800`) |
| **Acquisition** | Item Shop (Hub); expedition long return (rare); seasonal event shop |

| Zone | Normal Rarity Weights | With Lure Active |
|---|---|---|
| Forest | Common 60%, Uncommon 35%, Rare 5% | Common ~40%, Uncommon ~47%, Rare ~13% |
| Mountain | Common 30%, Uncommon 50%, Rare 20% | Common ~18%, Uncommon ~67%, Rare ~15% (Rare already boosted by zone) |
| Abyss | Common 0%, Uncommon 20%, Rare 40%, Epic 35%, Legendary 5% | Uncommon ~22%, Rare ~57%, Epic ~38%, Legendary ~7% |

> *"A small emit-pod releasing a scent trail detectable by wild beasts. Rare ones approach instead of flee. Hunters use it when they're sick of encountering only Rabbits."*

**Dev Notes:**
- `BeastSpawnService`: check `os.time() < PlayerData.LureExpiry` at each spawn roll; apply boosted weight table if active
- Multiple Beast Lures do NOT stack duration; second use resets timer to 30 min from current moment
- Beast Lure and Beast Repellent (048) are mutually exclusive: applying one while the other is active cancels the prior effect and resets timer
- Timer counts real time, not in-game time; continues during logout

---

### [048] Beast Repellent

| Field | Value |
|---|---|
| **Item ID** | `repellent` |
| **Category** | Consumable — Overworld Utility |
| **Stack Limit** | 99 |
| **Buy Price** | 200 Silver |
| **Sell Price** | 20 Silver |
| **Use Context** | Overworld only; activates immediately on use |
| **Target** | Player (self) |
| **Effect** | For **30 real-time minutes**: wild beast encounter probability reduced by **50%** per movement step; Hunt Energy cost still applies when an encounter triggers |
| **Duration** | 30 minutes (`PlayerData.RepellentExpiry = os.time() + 1800`) |
| **Acquisition** | Item Shop (Hub) |

> *"A bitter spray that wild beasts find revolting. They avoid the wearer for about half an hour. Used by hunters crossing dangerous zones toward a dungeon entrance without burning through all their potions on the way."*

**Dev Notes:**
- `BeastSpawnService`: if `os.time() < PlayerData.RepellentExpiry`, multiply encounter roll probability by 0.50 before comparison
- Does NOT prevent triggered encounters (dungeon waves, quest-required fights, scripted NPC battles)
- Mutually exclusive with Beast Lure — applying Repellent cancels active Lure timer and vice versa
- Primarily a traversal tool; no impact on dungeon interiors

---

### Consumables / Collectibles — Event & Special

---

### [049] Festival Coin

| Field | Value |
|---|---|
| **Item ID** | `festival_coin` (varies per event: `winter_coin`, `harvest_coin`, etc.) |
| **Category** | Collectible — Event Currency |
| **Stack Limit** | 9,999 |
| **Buy Price** | Cannot buy |
| **Sell Price** | Cannot sell |
| **Use Context** | Event Shop NPC only; active during seasonal event window |
| **Target** | N/A |
| **Effect** | Spent at the event shop for event-exclusive pets, cosmetics, and items; no function outside active event window |
| **Acquisition** | All battle types during active event; event daily quests; seasonal Battle Pass tiers |

| Battle Source | Festival Coin Yield |
|---|---|
| Wild beast victory | 2–5 per battle |
| NPC trainer victory | 5–15 per battle |
| Dungeon monster kill | 1–3 per monster |
| Dungeon boss kill | 25–50 |
| PvP win | 10–20 |
| Daily quest completion | 30–80 per quest |

> *"A copper disc stamped with this season's symbol. Useless after the festival ends. Worth everything during it."*

**Dev Notes:**
- Stored in `PlayerData.EventCurrency = { [event_coin_id] = quantity }` — separate sub-table from main `Inventory` to avoid consuming item slots
- Event Shop NPC validates `os.time() < EventData.end_time` before allowing any purchase
- Coins zeroed on event end via `EventService:EndEvent()` — players cannot carry coins to the next event
- Item ID rotates per event for analytics segmentation; icon and display name change; underlying spend logic is identical
- Battle Pass paid track typically grants 200–500 Festival Coins across its 50 tiers

---

### [050] Lucky Charm

| Field | Value |
|---|---|
| **Item ID** | `lucky_charm` |
| **Category** | Consumable — Boost |
| **Stack Limit** | 99 |
| **Buy Price** | 29 R$ (Robux Developer Product); seasonal Battle Pass Paid Tier 20 — 1× grant |
| **Sell Price** | Cannot sell |
| **Use Context** | Overworld or pre-battle setup; activates immediately on use |
| **Target** | Player (self) |
| **Effect** | For **1 real-time hour**: all drop rates (dungeon loot, field drops, boss species materials) increased by **+10%** multiplicatively |
| **Duration** | 1 hour (`PlayerData.LuckyCharmExpiry = os.time() + 3600`) |
| **Acquisition** | Robux Developer Product (29 R$); seasonal Battle Pass Paid Tier 20 |

> *"A four-leaf clover pressed between two panes of enchanted glass. The luck inside isn't superstition — it's measurable. Hunters who run dungeons with one active collect noticeably more than those who don't."*

**Dev Notes:**
- Drop rate application: `drop_chance = base_drop_chance * 1.10` — independent multiplier applied after all other modifiers
- Stacks with Hunter's VIP (+25% Silver/Gold), Capture Booster (capture rate only), and Dungeon Veteran (auto-collect) — each modifier is independent; Lucky Charm affects drop RNG, not Silver/Gold yield
- `ProcessReceipt` adds `lucky_charm ×1` to inventory on Robux purchase
- `DungeonService`, `BattleService`, and `CaptureService` all check `PlayerData.LuckyCharmExpiry` at reward calculation time

---

### Collectibles — World Drops

---

### [051] Shiny Scale

| Field | Value |
|---|---|
| **Item ID** | `shiny_scale` |
| **Category** | Collectible — Trophy |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 200 Silver |
| **Gameplay Effect** | None |
| **Acquisition** | Wild defeat of any scaled beast species (Snake, Turtle, Dragon, Koi, Anaconda) — 2% drop on battle victory; not from capture attempts |

> *"A single perfect scale from a wild beast, iridescent in any light. No two are identical. Collectors offer good money — not as good as the Item Shop, which is why most hunters don't bother haggling."*

**Dev Notes:**
- Drop check: `if beast.species_has_tag("scaled") and math.random() < 0.02 then grant("shiny_scale", 1) end`
- Tag `"scaled"` defined in species config for: Snake, Turtle, Dragon, Koi, Anaconda, and any future reptile/fish species
- Drop happens on battle victory regardless of capture outcome; even a failed capture that ends the battle can yield a Shiny Scale
- Not a boss-exclusive drop — designed as a common field collectible with modest Silver value

---

### [052] Emerald Feather

| Field | Value |
|---|---|
| **Item ID** | `emerald_feather` |
| **Category** | Collectible — Trophy |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 500 Silver |
| **Gameplay Effect** | None |
| **Acquisition** | Wild defeat of Wind or Nature element beast — 2% drop; wild defeat of any avian species (Hawk, Eagle, Parrot, Sparrow, Duck, Thunderbird) regardless of element — 3% drop |

> *"A vivid green feather retaining a charge of elemental wind energy after the beast's defeat. It hums very faintly in still air. Nature hunters collect them. Everyone else just sells them."*

**Dev Notes:**
- Two independent trigger conditions (OR): `(beast.Element == "Wind" OR beast.Element == "Nature") → 2%`; `beast.species_has_tag("avian") → 3%`
- If both conditions are true (e.g., Wind element Hawk): use the higher rate (3%), not additive
- Tag `"avian"` applies to: Hawk, Eagle, Parrot, Sparrow, Duck, Thunderbird — defined in species config
- 500 Silver sell value (2.5× Shiny Scale) reflects Wind/Nature beasts being slightly rarer and avian species requiring specific zone access

---

### [053] Void Shard

| Field | Value |
|---|---|
| **Item ID** | `void_shard` |
| **Category** | Collectible — Trophy |
| **Stack Limit** | 99 |
| **Buy Price** | Cannot buy |
| **Sell Price** | 3,000 Silver |
| **Gameplay Effect** | None |
| **Acquisition** | Wild defeat of any beast in Abyss zone (`zone_abyss`) — 3% drop; wild defeat of Dark element beast in Abyss zone specifically — 5% drop |

> *"A jagged shard of solidified void energy that forms in the Abyss. Hunters new to the zone pick them up as curiosities. Veterans pick them up and immediately sell them for 3,000 Silver each."*

**Dev Notes:**
- Drop logic: `base = 0; if beast.zone == "zone_abyss" then base = 0.03 end; if beast.zone == "zone_abyss" and beast.Element == "Dark" then base = 0.05 end`
- Higher rate (0.05) used when both conditions met — not additive
- 3,000 Silver sell value is highest field-drop collectible; rewards Abyss zone exploration beyond boss farming
- EV calculation: ~10 wild encounters/session × 3% = ~0.30 expected shards → ~900 Silver EV from trophy drops/session
- Lucky Charm (+10% drop rate) raises rates to 3.3% / 5.5% — relevant for active Abyss farmers

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
| Dragon Scale | `dragon_scale` | Dragon | Elder Dragon | Wild Dragon (Abyss) 10%; first capture 1× |
| Phoenix Ash | `phoenix_ash` | Phoenix | Eternal Phoenix | Wild Phoenix (Volcano) 10%; first capture 1× |
| Shadow Fang | `shadow_fang` | Tiger | Shadow Tiger | Wild White Tiger (Mountain) 8%; Lich King boss 5% |
| King's Mane Lock | `kings_mane_lock` | Lion | Pride Sovereign | Wild Battle Lion (Mountain) 8%; Elder Treant boss 5% |
| Tempest Quill | `tempest_quill` | Eagle | Tempest Eagle | Wild War Eagle (Forest/Mountain) 8%; Sky event chest |
| Void Slime Core | `void_slime_core` | Slime | Slime Titan | Forest Cave Slime kill 3%; first Warchief clear 1× |
| Ancient Shell Plate | `ancient_shell_plate` | Turtle | Titan Turtle | Wild Armored Turtle (Mountain) 8%; Skeleton kill 2% |
| Fox Spirit Bead | `fox_spirit_bead` | Fox | Spirit Fox | Wild Trickster Fox (Forest) 8%; Hostile Fairy kill 2% |
| Dire Pelt | `dire_pelt` | Dog | Dire Wolf | Wild Stage 2+ Wolf (Forest/Mountain) 8%; Goblin kill 2% |
| Anaconda Venom Gem | `anaconda_venom_gem` | Anaconda | Leviathan Serpent | Wild King Anaconda (Abyss) 8%; Demon kill 3% |

> Species materials not listed here are yet to be defined. All other pet families use a species material with `item_id = "<species>_<unique_token>"` to be documented as additional beasts are added.

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
