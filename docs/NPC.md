# NPC Glossary — Anjay Hunter

**Version:** 1.0  
**Status:** In Progress  
**Cross-reference:** GDD.md §4 (Zones), §8 (Battle System), §11 (Shop System), docs/BATTLE.md §13

---

## Table of Contents

1. [Overview](#1-overview)
2. [NPC Types](#2-npc-types)
3. [Trainer Battle Rules](#3-trainer-battle-rules)
4. [NPC Index](#4-npc-index)
5. [Entries](#5-entries)

---

## 1. Overview

NPCs are scripted characters distributed across all zones and the central Hub. They serve as:

- **Combat challenges** (Trainer NPCs) — scripted pet battles awarding Silver, Gold, and XP
- **Economy interfaces** (Shopkeepers) — buy/sell items, pets, skills, and cosmetics
- **Progression services** (Quest Giver, Service NPCs) — bounties, arena coordination, evolution guidance
- **Tutorial guides** — onboarding mechanics for new players

All NPC interaction is server-validated. Currency transactions, reward distribution, and battle results are authoritative server-side only. Clients send interaction requests; server responds with validated state changes.

---

## 2. NPC Types

| Type | Found In | Player Interaction | Battle? |
|---|---|---|---|
| **Tutorial** | Starter Plains | Dialogue + guided first battle | Yes (scripted, cannot lose permanently) |
| **Trainer** | All zones | Dialogue + turn-based battle | Yes |
| **Shopkeeper** | Hub (`zone_hub`) | Shop UI (buy/sell) | No |
| **Quest Giver** | Hub (`zone_hub`) | Bounty Board UI | No |
| **Service** | Hub (`zone_hub`) | Utility UI (arena, evolution, guild) | No |

---

## 3. Trainer Battle Rules

All Trainer NPCs follow these shared rules:

| Rule | Value |
|---|---|
| Flee allowed | No |
| Item use costs a turn | No (same as wild/dungeon: items are free actions) |
| Action timeout | None (server-controlled AI acts immediately) |
| Cooldown per NPC per player | 24 hours (resets midnight UTC) |
| Defeat outcome | Nothing lost; player can retry after cooldown |
| Win outcome | Silver + XP + occasional Gold |
| Hunter's VIP bonus | +25% Silver and Gold from all NPC battles |

**Silver reward formula:**  
`math.random(zone_min_silver, zone_max_silver)` — ranges defined per zone, not per NPC. All trainers in the same zone share the same reward range.

**XP reward formula:**  
`npc_avg_pet_level × 50` — split equally across all player pets that participated.

**Zone reward reference:**

| Zone | Silver Range | Gold Range |
|---|---|---|
| Starter Plains | 50–150 | — |
| Forest | 200–500 | — |
| Mountain | 500–1,500 | — |
| Volcano | 2,000–5,000 | 1–5 Gold |
| Abyss | 8,000–20,000 | 5–15 Gold |

**NPC AI:** Trainers use the same weighted random action selector as dungeon common monsters (see BATTLE.md §4.1). They prioritise skills over basic attack when off cooldown.

**Cooldown storage:** `PlayerData.NpcCooldowns = { [npc_id] = last_beaten_timestamp }`. Check at battle start: `if os.time() - cooldown < 86400 then refuse_challenge end`.

---

## 4. NPC Index

| ID | Name | Type | Zone | Role |
|---|---|---|---|---|
| 001 | Elder Maris | Tutorial / Trainer | Starter Plains | Tutorial guide; first battle |
| 002 | Forest Warden Tobias | Trainer | Forest | Mid-zone challenge |
| 003 | Knight Commander Vessa | Trainer | Mountain | Elite trainer; 3-pet team |
| 004 | Flamecaller Grimtusk | Trainer | Volcano | High-tier challenge; Epic pets |
| 005 | Void Seeker Nyx | Trainer | Abyss | Endgame trainer; Legendary pets |
| 006 | Merchant Kaine | Shopkeeper | Hub | Item Shop |
| 007 | Beastmaster Yuna | Shopkeeper | Hub | Pet Shop + Skill Shop counter |
| 008 | Bounty Master Rex | Quest Giver | Hub | Bounty Board |
| 009 | Arena Master Blake | Service | Hub | PvP Arena |
| 010 | Cosmetic Stylist Faye | Shopkeeper | Hub | Cosmetic Shop |

---

## 5. Entries

---

## 001 · Elder Maris `Tutorial / Trainer`

**Zone:** Starter Plains (`zone_starter`)  
**Location:** Central clearing of Starter Plains; first NPC the player encounters after the spawn point  
**Type:** Tutorial / Trainer  
**Cooldown:** None — always available; no cooldown cap (tutorial NPC)  

> *"I have been standing in this clearing for longer than you have been alive, young one. Every hunter who has ever become something remarkable started right here, right where you are standing. Shall we begin?"*

**Appearance:** Elderly woman in practical travel robes, weathered voxel face with kind eyes, a wooden staff, and a small animal perched on her shoulder (a Sparrow, cosmetic only). Warm amber-gold colour palette.

**Behaviour:** The first NPC the player ever speaks to. Elder Maris walks the player through the core loop: how to battle, how to capture, and how to access the Hub. Her battle is deliberately easy — designed to be winnable with the starter pet even if the player makes suboptimal choices.

**Dialogue:**

| Trigger | Line |
|---|---|
| First encounter | *"Ah, a new face. Good — the world always needs more hunters. Let me show you how this works. Don't worry. My pets have agreed to go easy on you."* |
| Battle start | *"Pay attention. Watch how your pet moves. Watch how mine does. The gap between a good hunter and a great one is nothing more than attention."* |
| Win (player wins) | *"Well done! You have the instinct. Now go — the forest is waiting, and it is far less patient than I am."* |
| Lose (player loses) | *"No shame in losing. Shame only in refusing to try again. Come back whenever you're ready."* |
| Repeat visit | *"Back again? Good. I find that students who return have usually learned something worth showing me."* |

**Pet Team:**

| Slot | Species | Level | Stage | Element | Key Skills |
|---|---|---|---|---|---|
| 1 | Dog | 8 | Stage 1 | None | Basic Attack, Growl (self ATK +20%) |
| 2 | Cat | 10 | Stage 1 | None | Shadow Step (evasion), Scratch |

**Battle Reward:**

| Win | XP (total, split) |
|---|---|
| `math.random(50, 150)` Silver | `9 × 50 = 450` (avg team Lv 9) |

**Battle Notes:**
- Elder Maris's pets use only basic attacks and simple buffs; no debuffs, no status effects — tutorial-safe
- If the player's starter pet is defeated, Maris pauses the battle and prompts the player to swap — this is a tutorial prompt, not standard game behaviour; implement as a one-time scripted interrupt on first Maris battle only
- On first victory: trigger `achievement_first_npc_win`; give the player 5× Basic Trap as a tutorial bonus (one-time gift, not repeatable)

**Dev Notes:**
- `npc_id = "elder_maris"`
- No cooldown check for this NPC — skip the `NpcCooldowns` validation entirely; she is always battlable
- Store a `PlayerData.tutorial_maris_defeated` flag; on first defeat, trigger the tutorial dialogue sequence for capturing, the Hub location marker, and the Daily Quest reminder
- Maris's pets should never be evolved or imbued with elements; she functions as a living tutorial object, not a difficulty benchmark

---

## 002 · Forest Warden Tobias `Trainer`

**Zone:** Forest (`zone_forest`)  
**Location:** Wooden watchtower at the edge of the Forest Cave dungeon entrance — 30 studs from the dungeon gate  
**Type:** Trainer  
**Cooldown:** 24 hours (resets midnight UTC)  

> *"I have patrolled this forest for twenty years. I have seen things in these trees that would make lesser hunters turn around and go home. You want to be a real hunter? Beat my team first. Then we'll talk about the forest."*

**Appearance:** Lean male ranger in dark-green voxel armour, short brown hair, a longbow strapped across his back (cosmetic), mud-stained boots. Forest-green and brown palette with amber eyes.

**Behaviour:** Speaks concisely; respects players who challenge him and means it. His pets reflect his ranger archetype — fast and evasive. He opens his Fox on turn 1 and switches to Eagle if the Fox is taken down, saving his Wolf for last as an anchor.

**Dialogue:**

| Trigger | Line |
|---|---|
| First encounter | *"You look like you have something to prove. Good. So does my Fox."* |
| Battle start | *"Don't blink."* |
| Win (player wins) | *"You're faster than you look. The Forest Cave is through those trees. Don't say I didn't warn you."* |
| Lose (player loses) | *"Speed beats strength, most of the time. Come back when you've figured out the exceptions."* |
| Repeat visit | *"Back again? I'll let my Eagle warm up this time."* |

**Pet Team:**

| Slot | Species | Level | Stage | Element | Key Skills |
|---|---|---|---|---|---|
| 1 | Fox | 50 | Stage 1 | Wind | Shadow Strike, Quick Step |
| 2 | Eagle | 55 | Stage 1 | Wind | Talon Strike, Wind Dive |
| 3 | Wolf | 60 | Stage 1 | Dark | Fang Strike, Howl |

**Battle Reward:**

| Win | XP (total, split) | Notes |
|---|---|---|
| `math.random(200, 500)` Silver | `55 × 50 = 2,750` (avg Lv 55) | No Gold at Forest zone |

**Battle Notes:**
- All three pets are Speed-archetype; Tobias's AI prioritises SPD-buff skills on first available turn, then damage
- Wolf (Lv 60) has Pack Leader passive — if either Fox or Eagle fell this battle, Wolf's ATK stacks 1–2 times; Tobias saves Wolf until last precisely for this compounding effect
- Counter strategy: SPD debuffs (Shock) or Blind to nullify their speed advantage; high-DEF pets tank their damage while dealing back

**Dev Notes:**
- `npc_id = "forest_warden_tobias"`
- Tobias is positioned near the dungeon gate to serve as a natural checkpoint: players who can beat Tobias are ready for Forest Cave. Optional: trigger a hint popup "Forest Cave Dungeon is nearby" after first Tobias win
- Pet swap logic for Tobias: the AI always uses Fox → Eagle → Wolf in order (not based on HP — scripted sequential reveal); implement as `tobias_active_slot` counter, increment on pet defeat

---

## 003 · Knight Commander Vessa `Trainer`

**Zone:** Mountain (`zone_mountain`)  
**Location:** Stone courtyard at the base of the Mountain Ruins dungeon, between two crumbled pillars  
**Type:** Trainer  
**Cooldown:** 24 hours (resets midnight UTC)  

> *"I have cleared Mountain Ruins forty-seven times. Not once did I feel ready beforehand. Readiness is a lie you tell yourself on the way in. What matters is that you come back out."*

**Appearance:** Tall armoured woman in silver-grey voxel plate armour, a white cape, and a visored helmet that she holds under one arm. A rank-crest badge pin (Commander insignia) floats above her left pauldron. Cold blue eyes, stern expression, close-cropped dark hair.

**Behaviour:** Methodical and disciplined. Vessa's team is a balanced triad — Tiger for speed and burst, Lion for sustained pressure and Pride passive, Bear for closing tanky. She opens with Tiger to threaten, Lion to sustain mid-battle, and Bear as a wall in the final stretch. Does not speak mid-battle.

**Dialogue:**

| Trigger | Line |
|---|---|
| First encounter | *"A challenger. What is your pet's best level? Honest answer only — I can tell if you're lying."* |
| Battle start | *"Let's see what you are made of."* |
| Win (player wins) | *"Acceptable. Mountain Ruins will test you harder than I did. Remember: the Lich King does not pause for breathing room."* |
| Lose (player loses) | *"Your defence collapsed on turn three. You need a tank that can actually hold the line. Come back when you've built one."* |
| Repeat visit | *"Again? I'll use Lion first this time. He has been wanting the spotlight."* |

**Pet Team:**

| Slot | Species | Level | Stage | Element | Key Skills |
|---|---|---|---|---|---|
| 1 | Tiger | 150 | Stage 2 (White Tiger) | Light | Pounce, Tiger Slash |
| 2 | Lion | 155 | Stage 2 | None | Mauling Paw, Pride Roar |
| 3 | Bear | 160 | Stage 2 (Grizzly) | Earth | Crushing Bite, Primal Strength |

**Battle Reward:**

| Win | XP (total, split) | Notes |
|---|---|---|
| `math.random(500, 1,500)` Silver | `155 × 50 = 7,750` (avg Lv 155) | No Gold at Mountain zone |

**Battle Notes:**
- Tiger Lv 150 Stage 2: Pounce (always-first) on turn 1 — critical to counter with high DEF or SPD buff before his first strike
- Lion Lv 155 Stage 2: Pride passive (ATK bonus when own ATK > opponent's ATK) means debuffing Lion's ATK with moves like Primal Roar (Gorilla) or Alpha Mark (Wolf) is the correct counterplay
- Bear Lv 160 Stage 2: deep DEF tank; requires Armor Break stacking or DEF-ignore skills to deal meaningful damage; designed to make the fight go long if the player spent resources defeating Tiger and Lion

**Dev Notes:**
- `npc_id = "knight_commander_vessa"`
- Sequential pet reveal: Tiger → Lion → Bear (scripted order, not HP-based)
- Vessa's loss dialogue references "turn three" — this is flavour text and does not require implementation; it is hardcoded in the loss string, not computed
- Vessa's win dialogue contains a dungeon hint about the Lich King — trigger a one-time highlight on the Mountain Ruins dungeon icon on the world map after first Vessa win

---

## 004 · Flamecaller Grimtusk `Trainer`

**Zone:** Volcano (`zone_volcano`)  
**Location:** Scorched ledge overlooking the Volcano Pit dungeon entrance, smoke rising from cracked stone underfoot  
**Type:** Trainer  
**Cooldown:** 24 hours (resets midnight UTC)  

> *"You come here to test yourself. Good. The volcano tests everyone eventually — I simply make sure only the worthy ones reach it."*

**Appearance:** Stocky half-orc figure in charred iron-voxel armour, with a broken tusk on the left side, ember-orange eyes, and burn scars across both arms. Carries a volcanic-stone warhammer (cosmetic). Armour glows faintly orange at the joints as if heat-soaked.

**Behaviour:** Aggressive opener. Grimtusk leads with his hardest hit first, then layers debuffs and DoTs. All three pets are Fire-element, meaning players without Water or Earth pets will struggle against the shared type advantage. He respects strength and shows visible contempt for weakness in his dialogue.

**Dialogue:**

| Trigger | Line |
|---|---|
| First encounter | *"The Volcano Pit has eaten better hunters than you. You want to go in? Convince me you deserve to."* |
| Battle start | *"My Manticore hasn't lost in thirty matches. Try not to be number thirty-one."* |
| Win (player wins) | *"Ha. Maybe you'll survive in there after all. Don't embarrass yourself against the Overlord."* |
| Lose (player loses) | *"That's what the Volcano eats. Come back stronger — or don't come back."* |
| Repeat visit | *"Again? I'll lead with the Phoenix this time. She's been restless."* |

**Pet Team:**

| Slot | Species | Level | Stage | Element | Key Skills |
|---|---|---|---|---|---|
| 1 | Manticore | 400 | Stage 2 (Blood Manticore) | Fire | Lion Mauling, Scorpion Tail, Manic Frenzy |
| 2 | Gorilla | 410 | Stage 2 (Silverback) | Fire | Ground Pound, Primal Roar, Silverback Charge |
| 3 | Phoenix | 420 | Stage 1 | Fire (natural) | Ember Strike, Flame Wing |

**Battle Reward:**

| Win | XP (total, split) | Gold |
|---|---|---|
| `math.random(2,000, 5,000)` Silver | `410 × 50 = 20,500` (avg Lv 410) | `math.random(1, 5)` Gold |

**Battle Notes:**
- Manticore Lv 400 Stage 2: Chaos Manifestation is Stage 3 only — not available; Manic Frenzy (Stage 2) is the dangerous skill; open with Blind or Armor Break prevention before Scorpion Tail + Manic Frenzy combo strips everything
- Gorilla Lv 410 Stage 2: Knuckle Guard passive (25% counter on Physical hit) — avoid Physical multi-hit skills or they will generate additional counter attacks; use Elemental skills instead
- Phoenix Lv 420 Stage 1: naturally Fire affinity; likely has Rebirth passive (revival at low HP once) — treat every Phoenix fight as a two-phase encounter; plan resources for the second HP bar
- Water-element pets have the strongest matchup here (all three are Fire-element); Earth-element pets also perform well

**Dev Notes:**
- `npc_id = "flamecaller_grimtusk"`
- Grimtusk is the first Trainer NPC whose pet team shares a unified element type — design intent is to teach element strategy before the player enters Volcano Pit dungeon
- Phoenix Rebirth passive (if implemented): triggers once when Phoenix HP reaches 0; restore to 30% MaxHP; this is a species passive defined in BEAST.md Phoenix entry (not yet documented); flag for implementation when Phoenix entry is added
- Grimtusk's reward includes Gold for the first time (Volcano zone tier) — surface to players via a "Gold earned!" animation distinct from Silver rewards

---

## 005 · Void Seeker Nyx `Trainer`

**Zone:** Abyss (`zone_abyss`)  
**Location:** A cracked stone platform at the rim of the Abyss Rift dungeon, surrounded by floating dark-crystal shards  
**Type:** Trainer  
**Cooldown:** 24 hours (resets midnight UTC)  

> *"You have come very far. Most do not reach this place. Those that do find that the distance was the easy part."*

**Appearance:** Tall, cloaked figure in deep-violet and black voxel robes, face partially obscured by a hood, only glowing silver eyes visible. Three dark energy wisps orbit slowly around the cloak. Staff topped with an Abyss crystal fragment.

**Behaviour:** Methodical and silent in combat. Nyx's team is the hardest NPC team in the game — all Stage 3 evolved, high level, with deep skill pools. She opens with Kitsune for speed pressure and Fox Fire mark accumulation; Werewolf for burst in Phase 2; Thunderbird as an overwhelming closer. She speaks in riddles and never directly addresses the player by name.

**Dialogue:**

| Trigger | Line |
|---|---|
| First encounter | *"Another seeker of the Abyss. How interesting. Tell me — do you chase power, or does power chase you?"* |
| Battle start | *"My companions have faced things from the edge of the world. Do not take it personally."* |
| Win (player wins) | *"Remarkable. Perhaps you are what this place has been waiting for. The Abyss Rift opens before you. What you find inside is your own to carry."* |
| Lose (player loses) | *"The Abyss does not care about readiness. It simply is. Come back when you have made peace with that."* |
| Repeat visit | *"You return. The Abyss has a word for that: stubbornness. I mean it as a compliment."* |

**Pet Team:**

| Slot | Species | Level | Stage | Element | Key Skills |
|---|---|---|---|---|---|
| 1 | Kitsune | 750 | Stage 3 (Celestial Kitsune) | Dark | Spirit Flame, Illusion Strike, Phantom Step, Celestial Fox Flame |
| 2 | Werewolf | 780 | Stage 3 (Lunar Werewolf) | Dark | Claw Rend, Moon Howl, Full Moon Rampage, Lycan Transformation |
| 3 | Thunderbird | 800 | Stage 2 (Storm Lord) | Electric | Thunder Talons, Gale Wing, Storm Surge |

**Battle Reward:**

| Win | XP (total, split) | Gold |
|---|---|---|
| `math.random(8,000, 20,000)` Silver | `777 × 50 = 38,850` (avg Lv 777) | `math.random(5, 15)` Gold |

**Battle Notes:**
- Kitsune Lv 750 Stage 3: Fox Fire marks accumulate via Celestial Fox Flame (instant detonation); Phantom Step gives 30% dodge; approach with always-first skills or high-SPD pets to out-pace her action
- Werewolf Lv 780 Stage 3: Lunar Rage (odd/even ATK/SPD alternation) + Lycan Transformation (doubles both) in Phase 3 of a long fight makes him disproportionately dangerous in turns 5+; burst him down before Lycan Transformation is usable
- Thunderbird Lv 800 Stage 2: Storm Stacks cap at 6 (+60% ATK); every Electric skill he uses charges closer to cap; use SPD debuffs early (before Gale Wing always-first fires) to interrupt his turn order
- This is the hardest trainer encounter in the game; only players with Stage 3 Epic+ pets should attempt

**Dev Notes:**
- `npc_id = "void_seeker_nyx"`
- Nyx's pet team order is always Kitsune → Werewolf → Thunderbird regardless of circumstances (scripted sequential reveal)
- Nyx's first-win dialogue triggers the Abyss Rift dungeon entrance highlight and a one-time server notification: "[PlayerName] has earned the respect of the Void Seeker" (opt-in server announcement, off by default)
- Achievement trigger on first Nyx defeat: `all_trainers_defeated` — rewards Title "Beast Tamer" (Rare rarity, blue text) if not already granted by a different path

---

## 006 · Merchant Kaine `Shopkeeper`

**Zone:** Hub (`zone_hub`)  
**Location:** Open-front stall at the eastern edge of the Hub market street, recognisable by a large golden coin sign above the entrance  
**Type:** Shopkeeper  
**Interaction:** Item Shop UI (buy only; sell via the "Sell Items" tab)  
**Availability:** Always open; no cooldown  

> *"Quality goods, reasonable prices, and I never ask what you need the Legend Trap for. Everyone wins."*

**Appearance:** Round-faced male merchant in a bright-yellow voxel vest and wide-brimmed hat, permanent cheerful grin, a coin purse attached to his belt, and a Slime companion sitting on the counter (cosmetic). Bright yellow and white colour palette.

**Behaviour:** Cheerful and efficient. No battle. Players interact with Kaine to purchase consumables, traps, and evolution materials. He has brief contextual comments when players buy specific items.

**Dialogue:**

| Trigger | Line |
|---|---|
| Approach | *"Welcome! Everything you need to stay alive out there — and some things you don't need but will definitely want."* |
| Buy HP Potion | *"Can't fight if you're dead. Smart purchase."* |
| Buy Legend Trap | *"For the ambitious type. I respect that."* |
| Buy Evolution Shard | *"Something special's about to happen. I can feel it."* |
| Idle (no interaction 10s) | *"Don't let the prices scare you. They are very reasonable. Mostly."* |

**Shop Inventory:**

| Item | Effect | Price |
|---|---|---|
| HP Potion (Small) | Restore 30% MaxHP to target pet | 30 Silver |
| HP Potion (Large) | Restore 100% MaxHP to target pet | 150 Silver |
| Stamina Potion | Restore 50% MaxStamina to target pet | 50 Silver |
| Energy Drink | Restore 100 Hunt Energy | 500 Silver |
| Basic Trap | Capture (30% base rate) | 50 Silver |
| Iron Trap | Capture (50% base rate) | 200 Silver |
| Gold Trap | Capture (70% base rate) | 50 Gold |
| Legend Trap | Capture (90% base rate) | 300 Gold |
| Evolution Shard | Required for Stage 2 evolution | 500 Silver **or** 10 Gold |
| Evolution Crystal | Required for Stage 3 evolution | 100 Gold |
| Re-imbue Stone | Change a pet's imbued element | 200 Gold |

**Sell Tab:**  
Players can sell collected items for their listed sell value (30% of buy price where applicable). Non-purchasable items (Collectibles, boss drops) have a fixed `sell_price` defined in item config.

**Dev Notes:**
- `npc_id = "merchant_kaine"`
- Evolution Shard dual-currency: both payment paths (`{ Silver = 500 }` and `{ Gold = 10 }`) must be validated server-side; the shop UI should show both options and allow the player to select preferred currency
- Kaine's stall is always stocked — no rotation, no stock limits; all items are always available
- "Sell Items" tab: triggers `ShopSell` RemoteEvent; server validates item ownership before removing from inventory and crediting Silver; collectibles from boss drops should have their sell values defined in a centralised `ItemConfig` table

---

## 007 · Beastmaster Yuna `Shopkeeper`

**Zone:** Hub (`zone_hub`)  
**Location:** Large open building at the Hub centre — the Pet Shop, with a smaller counter at the back for the Skill Shop  
**Type:** Shopkeeper  
**Interaction:** Pet Shop UI (buy/sell pets) + Skill Shop counter (buy skills for selected pet)  
**Availability:** Pet stock rotates every 24 hours (midnight UTC); skill shop always stocked  

> *"Every creature you see here chose to be here. I simply introduced myself first. That's the whole secret, really."*

**Appearance:** Young-adult woman in earthy voxel robes covered in small animal-print patterns, dark braided hair, a pair of spectacles, and three different pets following her at any given time (rotates daily based on what's in stock — cosmetic showcase). A colourful map of all zones hangs behind the counter.

**Behaviour:** Knowledgeable and nurturing. Yuna gives genuine advice about pet species when players browse. She rotates stock daily and can explain each pet's basic archetype. The Skill Shop counter appears at the rear; selecting a pet from the player's roster unlocks the relevant skill list automatically.

**Dialogue:**

| Trigger | Line |
|---|---|
| Approach (Pet Shop) | *"Looking for a companion? Every species has a story. Let me introduce you."* |
| Approach (Skill Shop) | *"Bring your pet to the counter — I'll show you what it can learn."* |
| Player buys Common pet | *"A fine starter. Treat it well and it will grow into something remarkable."* |
| Player buys Rare pet | *"Not cheap, but worth every Silver. That species has real depth."* |
| Player sells a pet | *"I'll find it a good home. You have my word."* |
| Stock rotates (new day) | *"Fresh arrivals this morning — take a look."* |

**Pet Shop Inventory (Daily Rotation):**

| Rarity | Slots in Stock (up to 10 total) | Buy Price | Sell Price (30%) |
|---|---|---|---|
| Common | 60% of slots (≈6) | 500 Silver | 150 Silver |
| Uncommon | 30% of slots (≈3) | 2,000 Silver | 600 Silver |
| Rare | 10% of slots (≈1) | 100 Gold | 30 Gold |
| Epic | Only during seasonal events | 500 Gold | 150 Gold |
| Legendary | Only during seasonal events | 2,000 Gold | 600 Gold |

Stock is generated at midnight UTC via a weighted-random species selector per slot. Pets in stock are generated at level 1, Stage 1, no element, with default skills equipped.

**Skill Shop Inventory (Counter at Rear):**

| Skill Tier | Price | Notes |
|---|---|---|
| Common species skill | 100 Silver | Only shows skills for selected pet's species |
| Uncommon species skill | 500 Silver | — |
| Rare species skill | 100 Gold | — |
| Epic species skill | 300 Gold | — |
| Legendary species skill | 800 Gold | — |
| Element skill (any element) | 200 Gold | Only shows if pet is Lv 50+ and has an imbued element |

Skills already known by the selected pet are greyed out (purchased) in the UI. Skill slots must be available to equip; purchasing a skill does not auto-equip.

**Dev Notes:**
- `npc_id = "beastmaster_yuna"`
- Pet stock generation: `generate_daily_pet_stock()` runs at server startup if current day differs from `ServerData.LastStockDate`; generate 10 pets using weighted rarity selector; store as `ServerData.PetShopStock` array; persist via `DataStore`
- Skill Shop context: when player selects a pet from their roster, the Skill Shop UI fetches `species_config[pet.SpeciesId].skill_pool` and filters out already-purchased skills; display is dynamic, not a static list
- Selling pets: `sell_price = math.floor(base_buy_price × 0.30)` regardless of level or evolution stage; the base buy price used is always the Lv-1 Stage-1 price from the price table above; confirm this is acceptable for evolved pets (players should be informed that sell price doesn't reflect evolution investment)

---

## 008 · Bounty Master Rex `Quest Giver`

**Zone:** Hub (`zone_hub`)  
**Location:** Bounty Board — large stone board with scrolled notices on it, located near the Hub entrance gate  
**Type:** Quest Giver  
**Interaction:** Bounty Board UI (view active bounties, accept, claim rewards)  
**Availability:** Always accessible; board content rotates as bounties complete or expire  

> *"I don't ask why anyone wants a Vampire captured. I don't ask why anyone needs thirty dead Goblins. I just post the jobs and hand out the Gold. Simple."*

**Appearance:** Gruff older male in worn hunter's gear — scarred voxel face, a missing eye replaced with a carved stone socket, fingerless gloves, a battered coat covered in patches. A hand-rolled map of all zones is permanently tucked under one arm. Grey-brown palette, weathered aesthetic.

**Behaviour:** Blunt and efficient. Rex gives no praise and no sympathy. He runs the Bounty Board mechanically — posts jobs, verifies completions, distributes rewards. His dialogue is sparse and direct. He is the only NPC who knows the locations of every rare species in every zone (implied, not implemented as a mechanic).

**Dialogue:**

| Trigger | Line |
|---|---|
| Approach | *"You after work, or just browsing? Board doesn't care either way."* |
| View bounty | *"Jobs are jobs. Pick one. Finish it. Get paid."* |
| Complete bounty | *"Done, as promised. Here's your cut. Next."* |
| Board empty (all taken) | *"Board's full up. Come back when someone finishes something."* |
| Bounty expires | *"Time's up on that one. Bounty dissolved. Happens."* |

**Bounty Board Rules:**

| Property | Value |
|---|---|
| Active bounties shown | 4 at a time |
| Board queue (pending) | Up to 8 bounties |
| Bounty duration | 48 hours per bounty |
| Refresh condition | Bounty completed or expired |

**Bounty Pool Reference:**

| Type | Example | Reward |
|---|---|---|
| Capture specific species | "Capture a Wolf" | 50 Gold |
| Dungeon kill count | "Defeat 30 Goblins in any dungeon" | Evolution Shard ×2 |
| PvP wins | "Win 5 PvP battles" | +100 Reputation |
| Boss hunt | "Defeat the Lich King" | Legend Trap ×1 + 40 Gold |
| NPC clear | "Defeat 10 Volcano NPCs" | 3,000 Silver |

**Dev Notes:**
- `npc_id = "bounty_master_rex"`
- Bounty Board is server-wide: all players see the same 4 active bounties; multiple players can complete the same bounty independently (each gets the reward); bounties are not exclusive
- Bounty generation: `BountyService` selects from a weighted bounty pool at board initialisation and on each bounty slot becoming vacant; pool weights: capture (25%), kill count (30%), PvP (15%), boss (15%), NPC clear (15%)
- Bounty progress tracked in `PlayerData.QuestProgress[bounty_id]`; validated server-side before reward distribution
- 48-hour timer: store `bounty.expires_at = os.time() + 172800`; check on each board load; remove and replace expired entries
- Rex does not interact with the daily quest system — those are separate from bounties and managed independently

---

## 009 · Arena Master Blake `Service`

**Zone:** Hub (`zone_hub`)  
**Location:** Arena building at the northern end of the Hub — a circular stone pit with spectator voxel seats around the edge  
**Type:** Service  
**Interaction:** PvP matchmaking UI  
**Availability:** Always available  

> *"You want to fight someone? I find someone. That's it. I've been doing this for fifteen years. I am very good at it."*

**Appearance:** Broad-shouldered male in black-and-gold voxel official's uniform, a referee's flag in one hand and a clipboard in the other. A prominent gold chain belt buckle engraved with the Arena crest. Confident neutral expression — he has seen everything.

**Behaviour:** Neutral arbitrator. Blake does not take sides, does not comment on battle outcomes, and does not engage in small talk. He runs the challenge queue, announces match starts, and distributes rep changes after each PvP battle. His Arena building hosts both challenge-invite PvP and open queue PvP (if implemented).

**Dialogue:**

| Trigger | Line |
|---|---|
| Approach | *"Looking for a fight? Good. I have one. Challenger pool: [X] players ready."* |
| Challenge sent | *"Challenge dispatched. Thirty seconds for them to accept."* |
| Challenge accepted | *"Both parties confirmed. Battle start."* |
| Challenge expired | *"No response. Challenger pool available for rematch."* |
| After PvP win | *"[PlayerName] wins. Rep updated. Next challenger?"* |
| After PvP loss | *"Battle concluded. Rep adjusted. Better luck next time."* |
| After draw | *"Fifty turns. No winner. Rep unchanged. Respectable."* |

**Service Functions:**

| Function | Description |
|---|---|
| Open Challenge | Player issues an open PvP challenge; any nearby player can accept |
| Directed Challenge | Player selects a specific player from a list; they receive a 30-second accept prompt |
| View Rankings | Displays the `lb_pvp` leaderboard (top 100 by rep) |
| View Rep History | Shows the player's last 10 PvP match results and rep changes |
| Arena Practice | *(Future scope)* vs scripted bot opponents for XP only, no rep change |

**PvP Rules Reference (managed by Blake):**

| Rule | Value |
|---|---|
| Action timeout | 30 seconds auto-Attack |
| Max turns before draw | 50 |
| Rep change | See GDD §5.1 and BATTLE.md §14 |
| Item use in PvP | Costs a turn (unless Battle Tactician pass) |

**Dev Notes:**
- `npc_id = "arena_master_blake"`
- Blake is a UI-wrapper NPC, not a logic NPC — he opens the PvP matchmaking menu on interaction; all PvP logic is in `BattleService` and `PvPMatchmakingService`
- Challenge notification to target player: `RemoteEvent:FireClient(target_player, "pvp_challenge", { challenger_id, expires_at })` with a client-side countdown UI
- "Challenger pool" count in Blake's greeting is a live query of `#active_pvp_challengers` — a server-side table of players who have queued for open challenges; update dynamically
- Arena building cosmetics: voxel crowd animations (idle spectators) should play in the pit seating area when a PvP battle is active inside; purely visual, no gameplay effect

---

## 010 · Cosmetic Stylist Faye `Shopkeeper`

**Zone:** Hub (`zone_hub`)  
**Location:** Boutique storefront on the western Hub street — identifiable by animated voxel mannequins displaying current stock in the window  
**Type:** Shopkeeper  
**Interaction:** Cosmetic Shop UI (browse and purchase cosmetics for Robux)  
**Availability:** Always open; stock rotates weekly (Monday 00:00 UTC)  

> *"Style is the only thing in this world that is entirely yours. Everything else can be taken. A perfectly chosen pet skin? That goes with you everywhere."*

**Appearance:** Elegant female in a flowing white-and-rose voxel outfit with a large decorative collar, pastel colour palette, and an oversized paint-brush accessory she uses as a walking cane. Always has a different pet skin applied to a companion pet (cosmetic showcase — rotates weekly to display what's new in stock).

**Behaviour:** Enthusiastic, opinionated about aesthetics, and deeply invested in helping players look their best. She never comments on stats or combat. She will occasionally compliment a player's visible pet skin if they're already wearing one. The Cosmetic Shop is Robux-only — no Silver or Gold accepted.

**Dialogue:**

| Trigger | Line |
|---|---|
| Approach | *"Oh, you have good taste — you came to me. Let's see what we can do for you and your companions."* |
| Browse pet skins | *"Every pet has a potential they haven't fully expressed yet. A skin just helps them get there."* |
| Purchase skin | *"Perfect choice. Your [pet name] is going to love this."* |
| Browse player outfits | *"Adventurer gear is practical. Mine is both practical and beautiful. There is no contradiction."* |
| Weekly stock restock | *"New arrivals! Some of these I have been waiting to show for weeks."* |
| Approach with no Robux | *"Window shopping is also perfectly acceptable. No judgment."* |

**Shop Inventory (Weekly Rotation):**

| Category | Examples | Price (R$) |
|---|---|---|
| Pet Skin (Common tier) | Dog → Dalmatian, Slime → Crystal Slime, Cat → Midnight Cat | 99 R$ |
| Pet Skin (Rare tier) | Wolf → Shadow Wolf, Eagle → Storm Eagle | 249 R$ |
| Pet Skin (Legendary tier) | Phoenix → Inferno Phoenix (animated flame), Dragon → Frost Dragon | 499 R$ |
| Player Outfit | Full voxel armour/clothing sets (e.g. "Forest Scout Armour", "Void Wanderer Robe") | 149–299 R$ |
| Pet Accessory | Hat, wings, halo, floating orb (on walking pet) | 79–199 R$ |
| Name Tag Style | Coloured, animated, or gradient player name display | 49–99 R$ |
| Emote Pack | 3-emote bundle | 99 R$ |
| Pet Trail | Particle trail following walking pet (e.g. flower petals, void sparks, starlight) | 149 R$ |

**Weekly Rotation Rules:**

- Stock is replaced every Monday at 00:00 UTC
- Each week has 8–12 items in stock across all categories
- Items never repeat within 4 consecutive weeks (cooldown pool)
- Limited-time seasonal cosmetics override one slot during event weeks and are removed when the event ends
- Purchased items are permanent and never expire (`PlayerData.OwnedCosmetics`)

**Dev Notes:**
- `npc_id = "cosmetic_stylist_faye"`
- All Cosmetic Shop purchases go through `MarketplaceService:PromptProductPurchase` with Robux-denominated Developer Products; each cosmetic item is its own product ID
- After successful purchase, add item to `PlayerData.OwnedCosmetics[item_id] = true`; equip via `CosmeticService:EquipSkin(pet_id, skin_id)` or `CosmeticService:EquipOutfit(player, outfit_id)`
- Skin on pet instance: if the pet is later released, skin returns to `PlayerData.OwnedCosmetics` unequipped (not lost)
- Weekly rotation: `FayeShopService:GenerateWeeklyStock()` runs at server startup if `os.time() > ServerData.FayeNextRotationTime`; generates stock from `cosmetic_pool` excluding items in the 4-week cooldown list; stores in `ServerData.FayeCurrentStock`; updates `FayeNextRotationTime = next_monday_utc()`
- Faye's companion pet (showcase) reflects the featured skin of the week — update her companion's appearance when stock rotates; purely cosmetic display logic
