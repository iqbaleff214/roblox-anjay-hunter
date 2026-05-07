# Game Design Document — Anjay Hunter

**Version:** 1.1
**Status:** In Progress
**Platform:** Roblox
**Last Updated:** 2026-05-07

---

## Table of Contents

1. [Overview](#1-overview)
2. [Core Concept](#2-core-concept)
3. [Game Loops](#3-game-loops)
4. [World & Zones](#4-world--zones)
5. [Player System](#5-player-system)
6. [Pet System](#6-pet-system)
7. [Monster System](#7-monster-system)
8. [Battle System](#8-battle-system)
9. [Progression & Retention](#9-progression--retention)
10. [Pet Showing Off](#10-pet-showing-off)
11. [Shop System](#11-shop-system)
12. [Guild System](#12-guild-system)
13. [Economy Design](#13-economy-design)
14. [Progression Summary](#14-progression-summary)
15. [Monetization](#15-monetization)
16. [Technical Reference](#16-technical-reference)

---

## 1. Overview

| Field | Value |
|---|---|
| **Title** | Anjay Hunter |
| **Platform** | Roblox |
| **Genre** | Monster Capture / Turn-Based RPG |
| **Art Style** | Voxel / Block |
| **Core Loop** | Explore → Hunt → Capture → Train → Evolve → Battle → Rank Up |
| **Max Players per Server** | 20 (hub); dungeon instances are 1–2 players |

---

## 2. Core Concept

Players explore a voxel world, hunting and capturing wild animals/beasts to keep as pets. Pets level up, evolve, learn skills, gain elements, and fight in turn-based battles — against wild beasts, dungeon monsters, NPCs, or other players. Reputation and rank grow through PvP. Multiple overlapping reward loops keep players coming back daily.

---

## 3. Game Loops

### Micro Loop (minutes)
```
Battle (wild beast / dungeon monster / NPC)
  → XP + Silver / Gold + Loot
  → Pet levels up → attributes grow
  → Unlock element / stronger skills
  → Battle harder enemy
```

### Mid Loop (hours / days)
```
Clear Dungeon → Boss drops Evolution Shard / Crystal
  → Evolve pet → stats multiply
  → Challenge higher-zone dungeon
  → Capture rarer species → fill Codex
  → Daily Quests + Bounties → bonus currency
```

### Macro Loop (weeks / months)
```
Climb PvP rank → unlock rank rewards + titles
  → Build guild → Guild War
  → Seasonal Events → exclusive pets / cosmetics
  → Complete Pet Codex → prestige title
  → Dominate leaderboards → social status
```

---

## 4. World & Zones

All terrain, buildings, pets, monsters, and players use voxel/block art style.

| Zone ID | Zone Name | Pet / NPC Level Range | Wild Beast Rarity | Key Content |
|---|---|---|---|---|
| `zone_starter` | Starter Plains | 1–20 | Common | Tutorial, first captures, basic NPC trainers |
| `zone_forest` | Forest | 21–100 | Common, Uncommon | Forest Cave Dungeon, NPC trainers |
| `zone_mountain` | Mountain | 101–300 | Uncommon, Rare | Mountain Ruins Dungeon, tougher NPCs |
| `zone_volcano` | Volcano | 301–600 | Rare, Epic | Volcano Pit Dungeon, elite NPCs |
| `zone_abyss` | Abyss | 601–1000 | Epic, Legendary | Abyss Rift Dungeon, endgame bosses |
| `zone_hub` | Town / Hub | — | — | All shops, Bounty Board, Arena, Guild Hall, Donor Hall of Fame |

---

## 5. Player System

### 5.1 Reputation & Ranking

Reputation (rep) increases by winning PvP. Each rank has 3 sub-divisions (I, II, III).

| Rank | Rep Range | Sub I | Sub II | Sub III |
|---|---|---|---|---|
| Copper | 0–499 | 0–149 | 150–299 | 300–499 |
| Iron | 500–1,499 | 500–749 | 750–999 | 1,000–1,499 |
| Silver | 1,500–2,999 | 1,500–1,999 | 2,000–2,499 | 2,500–2,999 |
| Gold | 3,000–5,499 | 3,000–3,832 | 3,833–4,665 | 4,666–5,499 |
| Platinum | 5,500–8,999 | 5,500–6,665 | 6,666–7,832 | 7,833–8,999 |
| Mithril | 9,000–13,999 | 9,000–10,665 | 10,666–12,332 | 12,333–13,999 |
| Orichalcum | 14,000–20,999 | 14,000–16,332 | 16,333–18,665 | 18,666–20,999 |
| Adamantite | 21,000+ | 21,000–24,999 | 25,000–29,999 | 30,000+ |

**Rep change per PvP battle:**

| Outcome | vs Lower Rank | vs Same Rank | vs Higher Rank |
|---|---|---|---|
| Win | +15 | +25 | +40 |
| Lose | −25 | −15 | −5 |

Rep never drops below 0. Rep does not drop below the floor of the current rank's Sub I threshold (no de-rank from loss alone; de-rank requires manually forfeiting, not implemented at launch).

### 5.2 Inventory

| Category | Description | Max Stack |
|---|---|---|
| **Consumable** | HP potions, stamina items, traps, evolution materials | 999 |
| **Collectible** | Show off or sell; no gameplay function | 99 |
| **Cosmetic** | Worn by player; outfits, accessories | 1 per unique item |

Max unique item types in inventory: **500 slots total**.

### 5.3 Currency

| Currency | Storage | Use |
|---|---|---|
| **Silver** | `PlayerData.Silver` | Consumables, basic traps, NPC rewards, common skills |
| **Gold** | `PlayerData.Gold` | Pet/skill slot upgrades, evolution, rare pets, premium traps |

Both currencies are integers, minimum 0, no maximum cap.

### 5.4 Hunt Energy

| Property | Value |
|---|---|
| Max | 100 |
| Wild beast encounter cost | 10 |
| Dungeon run cost | 25 |
| Natural regen rate | 10 per hour (evaluated lazily on player action) |
| Full restore item | "Energy Drink" consumable (drops from dungeons, sold in Item Shop) |

**Lazy regen formula** (run on login and before any energy-consuming action):
```
elapsed_hours = (os.time() - PlayerData.LastEnergyTime) / 3600
regen_amount  = math.floor(elapsed_hours * 10)
PlayerData.HuntEnergy = math.min(100, PlayerData.HuntEnergy + regen_amount)
PlayerData.LastEnergyTime = os.time()
```

---

## 6. Pet System

### 6.1 Pet Capacity

| Property | Value |
|---|---|
| Default slots | 2 |
| Maximum slots | 500 |
| Pets shown walking with player | Up to 2 (the first 2 in `ActivePetIds`) |

**Pet slot upgrade costs:**

| Slot Range | Gold per Slot |
|---|---|
| 3–5 | 500 |
| 6–10 | 1,000 |
| 11–20 | 2,000 |
| 21–50 | 5,000 |
| 51–100 | 10,000 |
| 101–500 | 20,000 |

### 6.2 Species & Rarity Tiers

| Tier | Examples | Spawn Source |
|---|---|---|
| Common | Dog, Cat, Pig, Horse, Slime | Wild areas (all zones), Pet Shop |
| Uncommon | Goblin, Wolf, Fox, Parrot | Wild areas, Dungeon drop |
| Rare | Lion, Eagle, Tiger, Orc | Wild areas (rare spawn), Dungeon boss drop |
| Epic | Troll, Elf, Vampire, Werewolf | Deep dungeons, seasonal events |
| Legendary | Dragon, Phoenix | Abyss zone only, seasonal events only |

Each species has a fixed **skill pool** (defined in species config) from which default and purchasable skills are drawn.

### 6.3 Base Attributes by Tier

Stat at level N = `base + (N - 1) × growth`.

| Tier | HP base | HP growth | Stamina base | Stamina growth | ATK base | ATK growth | DEF base | DEF growth | SPD base | SPD growth |
|---|---|---|---|---|---|---|---|---|---|---|
| Common | 100 | 5 | 50 | 2 | 15 | 2 | 10 | 1 | 10 | 1 |
| Uncommon | 130 | 7 | 65 | 3 | 20 | 3 | 14 | 2 | 13 | 1 |
| Rare | 170 | 10 | 85 | 4 | 27 | 4 | 19 | 3 | 17 | 2 |
| Epic | 220 | 14 | 110 | 6 | 36 | 6 | 26 | 4 | 22 | 2 |
| Legendary | 300 | 20 | 150 | 9 | 50 | 9 | 36 | 6 | 30 | 3 |

Example — Common Dog at level 100:
- HP = 100 + (99 × 5) = **595**
- ATK = 15 + (99 × 2) = **213**

### 6.4 Level & Experience

| Property | Value |
|---|---|
| Max level | 1,000 |
| XP to level up | `math.floor(50 × level ^ 1.15)` |
| Level 1→2 XP | 50 |
| Level 50→51 XP | ~224 |
| Level 500→501 XP | ~3,145 |
| Level 999→1000 XP | ~5,720 |

**XP gained per battle:**

| Source | XP Formula |
|---|---|
| Wild beast defeated | `beast_level × 30` |
| NPC trainer defeated | `npc_avg_pet_level × 50` |
| PvP win | `opponent_avg_pet_level × 75` |
| Dungeon monster kill | `monster_level × 20` |
| Dungeon boss kill | `boss_level × 150` |

XP is split equally across all pets used in the battle.

**Level unlock milestone:** Level 50 → element imbuing becomes available.

### 6.5 Elements

Pet can hold **one element** at level 50+. Changing element costs a **Re-imbue Stone** (200 Gold).

| Element | Strong Against | Weak Against |
|---|---|---|
| **Fire** | Nature, Ice, Metal | Water |
| **Water** | Fire, Earth | Electric |
| **Nature** | Water, Earth | Fire |
| **Earth** | Electric, Metal | Nature |
| **Electric** | Water, Ice | Earth |
| **Ice** | Nature, Wind | Fire |
| **Metal** | Ice, Wind | Fire |
| **Dark** | Electric, Nature | Light |
| **Light** | Dark, Metal | Dark |
| **Wind** | Earth, Water | Ice |

Elemental multipliers applied to all damage (physical and skill):
- Strong match → **×1.5**
- Weak match → **×0.5**
- No element (attacker or defender) → **×1.0**
- Both same element → **×1.0**

Imbuing unlocks element-specific skills in the Skill Shop.

### 6.6 Evolution

Every species has **up to 3 evolution stages**. Evolution changes the pet's voxel model, applies a stat multiplier, and may unlock a new default skill.

**Stat multiplier:** Stage 2 = ×1.3 to all stats; Stage 3 = ×1.7 to all stats (applied after level scaling).

**Evolution level thresholds by rarity:**

| Tier | Base → Stage 2 | Stage 2 → Stage 3 |
|---|---|---|
| Common | Level 20 | Level 100 |
| Uncommon | Level 30 | Level 150 |
| Rare | Level 50 | Level 200 |
| Epic | Level 75 | Level 300 |
| Legendary | Level 100 | Level 500 |

**Evolution cost:**

| Stage | Materials | Currency |
|---|---|---|
| Base → Stage 2 | 1× Evolution Shard | 500 Silver |
| Stage 2 → Stage 3 | 1× Evolution Crystal + 1× species-specific item | 300 Gold |

**Example evolution chains:**

| Species (Tier) | Stage 1 | Stage 2 | Stage 3 |
|---|---|---|---|
| Dog (Common) | Dog | Wolf | Dire Wolf |
| Slime (Common) | Slime | Slime King | Slime Titan |
| Goblin (Uncommon) | Goblin | Hobgoblin | Goblin Warchief |
| Tiger (Rare) | Tiger | White Tiger | Shadow Tiger |
| Vampire (Epic) | Vampire | Elder Vampire | Vampire Lord |
| Dragon (Legendary) | Whelp | Drake | Elder Dragon |

### 6.7 Skill System

**Default skills:** Every pet spawns with **2 pre-equipped skills** from its species skill pool.

**Skill slots:** Default **2 active slots**. Purchase additional with Gold.

| Skill Slot | Gold Cost |
|---|---|
| Slot 3 | 200 |
| Slot 4 | 500 |
| Slot 5 | 1,000 |
| Slot 6+ | 2,000 each |

**Skill power multipliers** (used in damage formula, see §16.2):

| Tier | Power Multiplier | Example Use |
|---|---|---|
| Weak | ×0.8 | Side effect skill with debuff |
| Normal | ×1.2 | Standard damage skill |
| Strong | ×1.8 | Hard-hitting single-target |
| Heavy | ×2.5 | Slow, high-damage |
| Ultimate | ×3.5 | High stamina cost |

**Status effects from skills:**

| Effect | Element Source | What It Does | Duration | Apply Chance |
|---|---|---|---|---|
| Burn | Fire skill | −5% max HP per turn | 3 turns | 30% |
| Freeze | Ice skill | Skip turn | 1 turn | 25% |
| Shock | Electric skill | −25% Speed | 2 turns | 35% |
| Poison | Nature skill | −3% max HP per turn | 5 turns | 30% |
| Armor Break | Earth / Metal skill | −30% Defense | 2 turns | 40% |
| Blind | Dark skill | 50% miss chance | 2 turns | 30% |
| Regen | Nature / Light skill | +5% max HP per turn | 3 turns | — (always) |
| Taunt | Wind / War skill | Force opponent to target this pet | 2 turns | — (always) |

Multiple status effects stack independently. A pet can be Burned and Poisoned simultaneously.

### 6.8 Pet Codex

Tracks every species captured. Entry unlocked on first capture. Entry completed when all 3 evolution stages have been captured (each must be caught separately or evolved).

**Codex completion rewards:**

| Milestone | Reward |
|---|---|
| 10 species captured | 500 Silver |
| 25 species captured | 50 Gold |
| 50 species captured | Cosmetic + 100 Gold |
| All Common captured | Title: "Beast Friend" |
| All Rare captured | Title: "Dragon Tamer" |
| All species captured (100%) | Title: "Grand Hunter" (Legendary) + 1,000 Gold + exclusive cosmetic |

Codex completion % displayed above player name in the world.

---

## 7. Monster System

Monsters are non-animal enemies found **only in Dungeons**. Most cannot be captured. Slime and Goblin are exceptions — capturable with a dungeon-specific **Iron Trap** or higher during the wave they spawn in.

### 7.1 Dungeon Roster

| Dungeon ID | Dungeon Name | Zone | Common Monsters | Rare Monsters | Boss |
|---|---|---|---|---|---|
| `dungeon_forest` | Forest Cave | Forest | Slime, Bat, Goblin | Hobgoblin, Giant Bat | Goblin Warchief |
| `dungeon_mountain` | Mountain Ruins | Mountain | Skeleton, Ghost, Zombie | Vampire, Wraith | Lich King |
| `dungeon_darkforest` | Dark Forest | Mountain | Elf Archer, Hostile Fairy | Treant, Dark Elf | Elder Treant |
| `dungeon_volcano` | Volcano Pit | Volcano | Orc, Troll, Lava Slime | Ogre, Fire Orc | Orc Overlord |
| `dungeon_abyss` | Abyss Rift | Abyss | Demon, Wraith, Specter | Dark Troll, Fallen Elf | Abyssal Demon Lord |

### 7.2 Dungeon Structure

| Property | Value |
|---|---|
| Waves per run | 8 (waves 1–7 = monsters, wave 8 = boss) |
| Daily run limit per dungeon | 3 runs (resets at midnight UTC) |
| Max players per dungeon instance | 2 (solo or 2-player co-op) |
| Hunt Energy cost per run | 25 |
| Flee option | Available; exits dungeon; partial loot from cleared waves kept |

Wave scaling: each wave increases monster level by `floor(zone_max_level × 0.08)` per wave above wave 1.

### 7.3 Monster Drop Table

| Drop | Condition | Quantity |
|---|---|---|
| Silver | Every monster kill | `monster_level × 5` |
| Gold | 2% chance per monster kill | `math.floor(monster_level × 0.1)` (min 1) |
| Evolution Shard | Boss kill, 60% chance | 1 |
| Evolution Crystal | Boss kill, 20% chance | 1 |
| Species-specific item | Boss kill, 15% chance | 1 |
| Rare Collectible | Boss kill, 40% chance | 1 |
| Legend Trap | Boss kill, 5% chance | 1 |
| Capturable pet | Slime/Goblin wave, capture attempt | See §8.4 |

Boss kill always drops: **Silver** (`boss_level × 50`) + **Gold** (see table below) + guaranteed one item from the drop table.

| Dungeon | Boss Gold Drop Range |
|---|---|
| Forest Cave | 10–20 |
| Mountain Ruins | 25–50 |
| Dark Forest | 60–120 |
| Volcano Pit | 150–300 |
| Abyss Rift | 400–800 |

---

## 8. Battle System

Turn-based. All battle logic runs **server-side only**. No client authority on damage, XP, or rewards.

### 8.1 Battle State Machine

```
IDLE
  │  (challenge accepted / wild beast engaged / dungeon wave starts)
  ▼
INIT
  │  Build participant list. Sort turn order by Speed (desc). Ties broken randomly.
  ▼
TURN_START
  │  Evaluate start-of-turn status effects (Burn, Poison, Regen tick).
  ▼
ACTION_SELECT
  │  PvP: 30s timeout → auto-Attack if expired.
  │  Wild / NPC / Dungeon: no timeout.
  ▼
ACTION_RESOLVE
  │  Apply chosen action. Calculate damage / heal. Resolve status effect procs.
  ▼
CHECK_END
  ├─ Any side has 0 living pets? → BATTLE_END
  └─ Otherwise → TURN_START (next turn)

BATTLE_END
  │  Distribute XP, Silver, Gold, loot.
  │  Update PlayerData (rep, codex, quest progress, achievement triggers).
  └─ Return players to world.
```

### 8.2 Actions Per Turn

| Action | Effect | Turn Cost |
|---|---|---|
| **Attack** | Physical hit: `max(1, ATK − DEF) × elemental_multiplier` | Yes |
| **Use Skill** | Deduct stamina cost; apply skill formula (§16.2); may proc status effect | Yes |
| **Use Item** | Apply consumable to own or target pet | Wild/NPC: No; PvP: Yes |
| **Swap Pet** | Replace active pet with another in roster | Yes |
| **Flee** | 70% base escape chance; fails → turn wasted | Yes (Wild/Dungeon only) |

### 8.3 Damage Formulas

**Physical Attack:**
```
raw    = attacker.Attack - defender.Defense
damage = math.max(1, raw) × elemental_multiplier
damage = math.floor(damage)
```

**Skill Attack:**
```
raw    = (attacker.Attack × skill.PowerMultiplier) - defender.Defense
damage = math.max(1, raw) × elemental_multiplier
damage = math.floor(damage)
```

**Heal Skill:**
```
heal = math.floor(target.MaxHP × skill.HealPercent)
target.HP = math.min(target.MaxHP, target.HP + heal)
```

**Status effect damage (Burn / Poison per tick):**
```
tick_damage = math.floor(target.MaxHP × effect.TickPercent)
```

### 8.4 Capture Mechanic

Can only attempt capture when beast/dungeon monster is **below 50% HP**. Uses one Trap item from inventory per attempt.

```
rarity_modifier = { Common=1.0, Uncommon=1.5, Rare=2.5, Epic=5.0, Legendary=10.0 }
capture_chance  = base_rate × (1 - current_hp / max_hp) × (1 / rarity_modifier[rarity])
roll            = math.random()  -- 0.0–1.0
captured        = roll < capture_chance
```

| Trap | Base Rate | Silver / Gold Cost |
|---|---|---|
| Basic Trap | 0.30 | 50 Silver |
| Iron Trap | 0.50 | 200 Silver |
| Gold Trap | 0.70 | 50 Gold |
| Legend Trap | 0.90 | 300 Gold |

On capture success: add PetData to `PlayerData.PetRosterIds`. If `PetRosterIds.count >= PetSlots`, prompt player to release a pet before adding.

### 8.5 Battle Types Summary

| Type | Opponent | Flee? | Win Reward | Lose Outcome |
|---|---|---|---|---|
| Wild Hunt | Roaming beast | Yes | Capture attempt available | Nothing |
| Dungeon Run | Monster wave + Boss | Yes (exit dungeon) | Silver + Gold + loot | Partial loot from cleared waves |
| NPC Battle | Scripted trainer | No | Silver + Gold | Nothing |
| PvP | Other player | No | +Rep | −Rep |

**NPC Silver reward by zone:**

| Zone | Silver Reward Range |
|---|---|
| Starter Plains | 50–150 |
| Forest | 200–500 |
| Mountain | 500–1,500 |
| Volcano | 2,000–5,000 (+1–5 Gold) |
| Abyss | 8,000–20,000 (+5–15 Gold) |

---

## 9. Progression & Retention

### 9.1 Daily Quests

Resets at **midnight UTC**. Player receives **5 quests** per day from a pool. Completing all 5 gives a **bonus reward** (50 Gold).

| Quest | Reward |
|---|---|
| Win 5 battles (any type) | 300 Silver |
| Capture 1 wild beast | Iron Trap ×3 |
| Complete 1 dungeon run | 20 Gold |
| Win 2 PvP battles | +50 Reputation |
| Use a skill 10 times in battle | Evolution Shard ×1 |
| Defeat a dungeon boss | 30 Gold |
| Sell 3 items at any shop | 200 Silver |
| Log in (passive) | 100 Silver |

Hunter's VIP Game Pass: +1 bonus quest slot per day (6 quests instead of 5).

### 9.2 Bounty Board

Located in Town/Hub (`zone_hub`). **4 active bounties** at a time. Each bounty has a **48-hour timer**. Bounties refresh as they are completed or expire. Board holds up to 8 pending bounties in the queue.

| Bounty Type | Example | Reward |
|---|---|---|
| Capture specific species | "Capture a Wolf" | 50 Gold |
| Dungeon kill count | "Defeat 30 Goblins in any dungeon" | Evolution Shard ×2 |
| PvP wins | "Win 5 PvP battles" | +100 Reputation |
| Boss hunt | "Defeat the Lich King" | Legend Trap ×1 + 40 Gold |
| NPC clear | "Defeat 10 Volcano NPCs" | 3,000 Silver |

### 9.3 Achievements

One-time permanent milestones. Stored in `PlayerData.AchievementsCompleted`.

| Achievement ID | Trigger | Reward |
|---|---|---|
| `first_capture` | Capture first pet | Basic Trap ×5 |
| `capture_50` | Capture 50 different species | Cosmetic + 100 Gold |
| `pet_lv100` | Reach level 100 with any pet | 100 Gold + Evolution Shard |
| `pvp_100` | Win 100 PvP battles | Title: "Brawler" |
| `codex_complete` | Capture all species | Title: "Grand Hunter" + 1,000 Gold + exclusive cosmetic |
| `all_bosses` | Defeat all 5 dungeon bosses | Title: "Dungeon Clearer" |
| `adamantite_rank` | Reach Adamantite rank | Title: "Adamantite" + exclusive cosmetic |
| `first_donation` | Make first donation (dev or player tip) | Title progress: "True Supporter" Roblox Badge |

### 9.4 Pet Expedition

Send 1–3 pets on an expedition while offline. Pets on expedition are **locked** — cannot be used in battle. Expedition slots default to **1**; +2 with Expedition Master Game Pass.

| Type | Duration | XP per Pet | Silver | Bonus |
|---|---|---|---|---|
| Short | 1 hour | 500 | 200 | — |
| Medium | 4 hours | 2,500 | 800 | 1 random common item |
| Long | 12 hours | 8,000 | 2,000 | 1 random item (uncommon–rare chance) + 5% Gold drop |

On return, results written to `PlayerData` server-side. Client shows "expedition complete" popup on next login.

### 9.5 Leaderboards

Stored in Roblox `OrderedDataStore`. Updated on significant change events (not on a loop).

| Board ID | Metric | Update Trigger | Display Location |
|---|---|---|---|
| `lb_pvp` | Reputation | After every PvP result | Hub billboard + global menu |
| `lb_pet_level` | Highest single pet level | On pet level-up | Hub billboard + global menu |
| `lb_codex` | Codex species count | On new Codex entry | Global menu |
| `lb_guild` | Guild battle wins | After Guild War | Guild Hall |
| `lb_dungeon_speed` | Fastest dungeon clear (seconds) | On dungeon completion | Hub billboard |
| `lb_tips_received` | Tips received (weekly, resets Monday 00:00 UTC) | On tip receipt | Hub billboard |

Show top 100 per board. Player's own rank always shown even if outside top 100.

### 9.6 Seasonal Events

Runs ~4 weeks. One event per major holiday / game anniversary.

- Exclusive pet species (not obtainable outside event window)
- Event-specific dungeon with unique boss
- Event currency (e.g., "Festival Coins") earned from all battles → spend at event shop
- Event cosmetics and collectibles (never return after event)
- Battle Pass activates alongside event (see §15.5)

### 9.7 Title System

One active title equipped at a time. Displayed above player name. Stored as `PlayerData.ActiveTitle`.

| Category | Examples | Source |
|---|---|---|
| Rank | "Iron", "Adamantite" | Reach PvP rank |
| Achievement | "Grand Hunter", "Dungeon Clearer", "Brawler" | Achievement unlock |
| Collection | "Beast Friend", "Dragon Tamer" | Codex milestone |
| Event | "Festival Champion", "Seasonal Hero" | Event completion |
| Donor | "Supporter", "Patron", "Benefactor", "Grand Patron", "Legend Donor" | Cumulative donation total |
| Social | "Generous Soul", "Patron of the Wild" | Cumulative tip total |
| Special | "Pioneer", "Tester", "Dev Friend" | Staff-granted |

**Title rarity renders:**

| Rarity | Visual |
|---|---|
| Common | White static text |
| Uncommon | Green static text |
| Rare | Blue static text |
| Epic | Purple static text |
| Legendary | Gold animated gradient text |
| Special | Rainbow animated text |

Donor and Special titles always render Legendary or Special regardless of other progression.

### 9.8 Badge System

**Roblox Platform Badges** (permanent on player's Roblox profile):

| Badge Name | Trigger |
|---|---|
| First Steps | Capture first pet |
| Beast Slayer | Defeat 100 wild beasts total |
| Dungeon Diver | Complete first dungeon run |
| Boss Hunter | Defeat all 5 dungeon bosses |
| PvP Champion | Reach Gold rank |
| Adamantite Legend | Reach Adamantite rank |
| Codex Complete | Capture all species |
| True Supporter | Make first donation (dev or player) |

**In-Game Badge Pins** (voxel pin worn on character model; max 3 equipped; stored in `PlayerData.BadgePins`):

| Pin | Source |
|---|---|
| Rank crest | Auto-equips current rank icon |
| Dungeon star | Number of bosses defeated (1–5 stars) |
| Donor heart | Any donation ever made |
| Event medal | Seasonal event completion |
| Guild emblem | Active guild membership |

---

## 10. Pet Showing Off

- First 2 pets in `PlayerData.ActivePetIds` walk alongside player in the world
- Rare evolved pets are visually distinct (larger voxel models, Stage 3 glow effect)
- Codex completion % shown above player name (format: `[username] | 🐾 42%`)
- PvP rank crest badge pin auto-displays on character
- Player outfit + pet accessories + pet skins compose the full visual flex

---

## 11. Shop System

All shops in `zone_hub`. Separate NPCs; no cross-selling.

### 11.1 Item Shop

| Item | Effect | Price |
|---|---|---|
| HP Potion (Small) | Restore 30% of target pet's max HP | 30 Silver |
| HP Potion (Large) | Restore 100% of target pet's max HP | 150 Silver |
| Stamina Potion | Restore 50% of target pet's max Stamina | 50 Silver |
| Energy Drink | Restore 100 Hunt Energy | 500 Silver |
| Basic Trap | Capture attempt (30% base) | 50 Silver |
| Iron Trap | Capture attempt (50% base) | 200 Silver |
| Gold Trap | Capture attempt (70% base) | 50 Gold |
| Legend Trap | Capture attempt (90% base) | 300 Gold |
| Evolution Shard | Required for Stage 2 evolution | 500 Silver or 10 Gold |
| Evolution Crystal | Required for Stage 3 evolution | 100 Gold |
| Re-imbue Stone | Change pet's element | 200 Gold |

### 11.2 Pet Shop

Stock rotates every **24 hours**. Up to **10 pets** in stock at a time. Rarity distribution: 60% Common, 30% Uncommon, 10% Rare. Epic and Legendary only appear during seasonal events.

| Tier | Buy Price | Sell Price (30% of buy) |
|---|---|---|
| Common | 500 Silver | 150 Silver |
| Uncommon | 2,000 Silver | 600 Silver |
| Rare | 100 Gold | 30 Gold |
| Epic | 500 Gold | 150 Gold |
| Legendary | 2,000 Gold | 600 Gold |

Players can also sell any owned pet. Sell price = 30% of base buy price regardless of level or evolution stage.

### 11.3 Skill Shop (counter inside Pet Shop NPC)

| Skill Tier | Price |
|---|---|
| Common species skill | 100 Silver |
| Uncommon species skill | 500 Silver |
| Rare species skill | 100 Gold |
| Epic species skill | 300 Gold |
| Legendary species skill | 800 Gold |
| Element skill (any element) | 200 Gold |

Skill Shop shows only skills compatible with species or element of the pet currently selected in the UI.

---

## 12. Guild / Clan System *(Post-Launch)*

- Players form guilds (name, banner, voxel emblem)
- **Guild War**: scheduled PvP events between guilds; winner earns Guild Points + territory
- **Guild Storage**: shared item/collectible bank (max 500 slots)
- **Guild Rank**: separate from player rank
- **Guild Quests**: cooperative daily missions → shared reward pool
- Max guild members at launch: 30

Implementation deferred. Data schema and API surface to be defined in a separate technical doc before development begins.

---

## 13. Economy Design

**Design rules:**
1. Silver flows freely — earned from all battle types, spent on everyday items
2. Gold is scarce in-game — only from bosses, daily quests, bounties, and Robux purchase
3. Every currency has meaningful sinks to prevent inflation

| Silver Sink | Gold Sink |
|---|---|
| HP / Stamina consumables | Pet slot upgrades (500–20,000 per slot) |
| Basic / Iron Traps | Skill slot upgrades (200–2,000 per slot) |
| Stage 2 evolution (500 Silver) | Stage 3 evolution (300 Gold) |
| Common / Uncommon skill purchase | Rare–Legendary skill purchase |
| Energy Drink | Gold Trap / Legend Trap |
| Common pet shop purchase | Rare+ pet shop purchase |
| — | Re-imbue Stone (200 Gold) |

---

## 14. Progression Summary

```
New Player (2 pet slots, 100 Hunt Energy)
  │
  ▼
Starter Plains → wild beast battle → Basic Trap capture → first pet
  │
  ▼
Daily Quests + Bounties → Silver income + Iron Traps
  │
  ▼
Forest Cave Dungeon (25 energy) → 8 waves → Goblin Warchief boss
  → Drop: Evolution Shard (60% chance), 10–20 Gold
  │
  ▼
Pet reaches evolution level → spend Shard + 500 Silver → Stage 2
  → ×1.3 stat multiplier + possible new skill
  │
  ▼
Pet reaches level 50 → imbue element → buy element skills
  │
  ▼
PvP open challenge → earn rep → climb Copper → Iron → Silver → ...
  │
  ▼
Upgrade pet slots → capture Rare/Epic species → expand Codex
  │
  ▼
Abyss Rift Dungeon → Evolution Crystal drop → Stage 3 evolution
  → ×1.7 stat multiplier + unique Stage 3 model
  │
  ▼
Seasonal event → exclusive Legendary pet → social flex
  │
  ▼
Reach Adamantite rank → "Adamantite" title + exclusive cosmetic
  │
  ▼
Codex 100% → "Grand Hunter" title + 1,000 Gold → Leaderboard #1
```

---

## 15. Monetization

**Three principles:**
1. No pay-to-win in PvP — nothing purchased gives stat advantage in combat
2. Everything earnable in-game — paid items only accelerate or cosmetically enhance
3. Transparent — no hidden odds; all random elements show exact probability

### 15.1 Robux as Premium Currency

Roblox native currency (R$). Developer earns 70% after DevEx. All Robux purchases handled via `MarketplaceService`.

### 15.2 Game Passes (One-Time)

| Pass | Perk | Price |
|---|---|---|
| Hunter's VIP | +25% Silver & Gold from all battles, +1 daily quest slot, VIP badge | 499 R$ |
| Pet Whisperer | +10% flat capture rate, no capture attempt cooldown | 299 R$ |
| Double XP | Pets earn 2× XP from all battles permanently | 399 R$ |
| Expedition Master | +2 expedition slots (1→3), −25% expedition duration | 349 R$ |
| Dungeon Veteran | +1 daily dungeon run per dungeon, auto-collect loot per wave | 449 R$ |
| Battle Tactician | Item use in PvP does not cost a turn | 299 R$ |
| Slot Booster | Start with 10 pet slots instead of 2 | 199 R$ |

Passes stack. Checked via `MarketplaceService:UserOwnsGamePassAsync` on relevant actions.

### 15.3 Developer Products (Repeatable)

| Product | Description | Price |
|---|---|---|
| Gold: 100 | 100 Gold added to account | 49 R$ |
| Gold: 500 | 500 Gold added to account | 199 R$ |
| Gold: 2,000 | 2,000 Gold added to account | 699 R$ |
| Gold: 5,000 | 5,000 Gold added to account | 1,499 R$ |
| Energy Refill | Restore Hunt Energy to 100 | 29 R$ |
| Dungeon Key | +1 dungeon run today (any dungeon) | 39 R$ |
| Capture Boost | +20% capture rate for next 5 attempts | 19 R$ |
| XP Boost (1h) | 3× XP for all pets for 1 real-time hour | 49 R$ |

All products processed in `MarketplaceService.ProcessReceipt`. Use receipt ID to guarantee idempotency.

### 15.4 Cosmetic Shop

Weekly rotating stock. No gameplay effect.

| Category | Examples | Price |
|---|---|---|
| Pet Skin (Common) | Dog → Dalmatian, Slime → Crystal Slime | 99 R$ |
| Pet Skin (Rare) | Wolf → Shadow Wolf | 249 R$ |
| Pet Skin (Legendary) | Phoenix → Inferno Phoenix (animated) | 499 R$ |
| Player Outfit | Full voxel armor/clothing set | 149–299 R$ |
| Pet Accessory | Hat, wings, aura on walking pet | 79–199 R$ |
| Name Tag Style | Colored or animated name display | 49–99 R$ |
| Emote Pack | 3-emote bundle | 99 R$ |
| Pet Trail | Particle trail following walking pet | 149 R$ |

Skin applied to one pet instance. If pet is released, skin returns to player's cosmetic inventory.

### 15.5 Seasonal Battle Pass

Active during each seasonal event (~4 weeks).

| Track | Cost | Tiers | Content |
|---|---|---|---|
| Free | Free | 10 | Silver, consumables, common trap, basic cosmetic |
| Paid | 499 R$ | 50 | All free rewards + event pet skin, Gold bundles, Evolution Crystal, unique title, animated pet accessory |

- Pass XP earned from: daily quests, battles, dungeon runs
- Paid track purchasable any time during event; retroactively unlocks earned tiers
- Exclusive rewards never re-enter shop after event ends

### 15.6 Roblox Premium Perks

| Perk | Details |
|---|---|
| +15% Silver bonus | Applied to all Silver earned in battles |
| Free daily Energy Refill | Once per day, auto-applied on login |
| Premium badge pin | Shown on character model |
| Early event access | 24h head start on seasonal events |

Checked via `Players:GetPlayerByUserId():MembershipType`.

### 15.7 Donation System

**Developer Donations** (fixed-price Game Passes used as donation vessels, not consumable):

| Pass | Price | Reward |
|---|---|---|
| Supporter | 50 R$ | "Supporter" title + Donor Heart badge pin |
| Patron | 250 R$ | "Patron" title (Epic) + exclusive cosmetic |
| Benefactor | 750 R$ | "Benefactor" title (Legendary) + pet skin + badge |
| Grand Patron | 2,000 R$ | "Grand Patron" title (Legendary animated) + all above + Hall of Fame |
| Legend Donor | 5,000 R$ | "Legend Donor" title (Special rainbow) + aura effect + permanent top Hall of Fame slot |

Tiers are cumulative (`PlayerData.DonationTotal` tracks total R$ donated). Tier recalculated each time a donation pass is purchased.

**Donor Hall of Fame** — physical board in `zone_hub`, top 10 donors by cumulative amount. Updates in real-time via `OrderedDataStore`. Opt-in only (`PlayerData.ShowOnHallOfFame = true`).

**Player-to-Player Tips** — implemented as per-player Developer Products (created dynamically or via static price tiers with recipient logged server-side):

| Tip | Price | Sender Gets | Receiver Gets |
|---|---|---|---|
| Small Tip | 10 R$ | Tip progress toward title | In-game Silver bonus (200) |
| Medium Tip | 50 R$ | Tip progress toward title | Silver (1,000) + Gold (5) |
| Big Tip | 150 R$ | Tip progress toward title | Weekly leaderboard entry |
| Mega Tip | 500 R$ | "Patron of the Wild" title progress | Top weekly leaderboard slot + thank-you effect |

`PlayerData.TipSentTotal` tracks cumulative tips sent. Reaching **1,000 R$ total tipped** unlocks "Generous Soul" title (Legendary).

**Most Tipped Leaderboard** — weekly, resets Monday 00:00 UTC. Winner gets "Weekly Favorite" cosmetic name border for 7 days.

### 15.8 Revenue Model Summary

| Source | Type | Primary Audience |
|---|---|---|
| Game Passes | One-time | New player conversion |
| Gold Bundles | Repeatable | Engaged mid-core players |
| Convenience Products | Repeatable | Daily active grinders |
| Cosmetic Shop | Repeatable | Social / vanity players |
| Battle Pass | Per-season | Retained seasonal players |
| Developer Donations | One-time per tier | Fans and supporters |
| Player-to-Player Tips | Repeatable | Social economy |
| Roblox Premium | Platform payout | Premium members |

### 15.9 Ethical Guardrails

- No loot boxes or gacha — all purchases show exact contents before buying
- No stat advantages from any purchase in PvP
- Wild-caught pets are always as strong as shop-bought at equal level/evolution
- Capture rates, drop rates, expedition yields displayed in-game (UI tooltip)
- Donor titles are cosmetic only — zero gameplay effect
- Player tips are voluntary; no prompts during or after battles
- Hall of Fame listing requires explicit opt-in

---

## 16. Technical Reference

### 16.1 Data Schemas

```lua
-- DataStore key: "Player_" .. tostring(UserId)
PlayerData = {
  -- Currency
  Silver              = 0,          -- integer, min 0
  Gold                = 0,          -- integer, min 0

  -- Energy
  HuntEnergy          = 100,        -- integer, 0–100
  LastEnergyTime      = 0,          -- os.time() snapshot

  -- Rank
  Reputation          = 0,          -- integer, min 0
  Rank                = "Copper_I", -- string enum

  -- Pets
  PetSlots            = 2,          -- integer, 2–500
  ActivePetIds        = {},         -- array of PetId strings, max 2
  PetRosterIds        = {},         -- array of all owned PetId strings

  -- Inventory: itemId -> quantity
  Inventory           = {},

  -- Social
  ActiveTitle         = "",
  BadgePins           = {},         -- array of pin IDs, max 3
  ShowOnHallOfFame    = false,

  -- Codex: speciesId -> highest stage captured (1|2|3)
  CodexEntries        = {},

  -- Donations
  DonationTotal       = 0,          -- cumulative R$ donated to dev
  TipSentTotal        = 0,          -- cumulative R$ tipped to players

  -- Quests
  DailyQuestIds       = {},         -- today's 5 quest IDs
  QuestProgress       = {},         -- questId -> current count
  DailyQuestResetTime = 0,          -- midnight UTC timestamp

  -- Dungeons
  DungeonRunsToday    = {},         -- dungeonId -> runs used today
  LastDungeonReset    = 0,          -- midnight UTC timestamp

  -- Expeditions (array of active slots)
  Expeditions         = {},
  -- each entry: { petId, startTime, duration, type }

  -- Achievements (set of completed IDs)
  AchievementsCompleted = {},

  -- Game Passes (cached, re-checked on join)
  OwnedPasses         = {},         -- set of pass IDs
}

-- DataStore key: "Pet_" .. PetId
PetData = {
  PetId           = "",     -- UUID string
  OwnerId         = 0,      -- UserId number
  SpeciesId       = "",     -- e.g. "dog", "dragon"
  EvolutionStage  = 1,      -- 1|2|3
  Level           = 1,      -- 1–1000
  XP              = 0,
  Element         = nil,    -- string | nil
  SkillPool       = {},     -- array of learned skill IDs
  EquippedSkills  = {},     -- active slots (max = SkillSlots)
  SkillSlots      = 2,
  SkinId          = nil,    -- string | nil
  Accessories     = {},
  CustomName      = nil,    -- string | nil, player-set name
}
```

### 16.2 Formula Reference

| Formula | Expression |
|---|---|
| Stat at level N | `base + (N - 1) × growth` |
| XP to level up | `math.floor(50 × level ^ 1.15)` |
| Physical damage | `math.floor(math.max(1, ATK - DEF) × elem_mult)` |
| Skill damage | `math.floor(math.max(1, ATK × power_mult - DEF) × elem_mult)` |
| Heal amount | `math.floor(max_hp × heal_pct)` |
| Status tick dmg | `math.floor(max_hp × tick_pct)` |
| Capture chance | `base_rate × (1 - cur_hp/max_hp) × (1 / rarity_mod)` |
| Energy regen | `math.min(100, energy + math.floor(elapsed_hours × 10))` |

### 16.3 Server Services & Responsibilities

| Service | Responsibilities |
|---|---|
| `PlayerService` | Load/save PlayerData, currency, energy, rank, inventory |
| `PetService` | Load/save PetData, stat calculation, evolution, element |
| `BattleService` | State machine, damage calc, XP distribution, reward dispatch |
| `CaptureService` | Capture roll, roster add, slot check |
| `DungeonService` | Wave spawning, energy gate, daily limit, boss logic, loot table |
| `SkillService` | Skill data lookup, stamina deduction, status effect application |
| `ShopService` | Stock generation, buy/sell transaction, price validation |
| `QuestService` | Quest assignment, progress tracking, reward grant |
| `BountyService` | Bounty pool, timer, completion check |
| `AchievementService` | Event listener → trigger check → one-time reward |
| `ExpeditionService` | Slot management, lazy return check on login |
| `LeaderboardService` | `OrderedDataStore` reads/writes on trigger events |
| `DonationService` | `MarketplaceService` receipt processing, tier calculation |
| `TitleService` | Title unlock logic, render rarity lookup |
| `CosmeticService` | Skin apply/remove, accessory equip |

### 16.4 Remote API Surface

All remotes fire **server → client** for state updates. Clients fire **client → server** for action requests. Server validates all inputs before processing.

| RemoteEvent | Direction | Payload |
|---|---|---|
| `BattleAction` | C→S | `{ actionType, targetId, itemId?, skillId? }` |
| `CaptureAttempt` | C→S | `{ trapItemId, targetPetInstanceId }` |
| `ShopBuy` | C→S | `{ shopId, itemId, quantity }` |
| `ShopSell` | C→S | `{ petId }` |
| `DungeonEnter` | C→S | `{ dungeonId, partnerUserId? }` |
| `ExpeditionSend` | C→S | `{ petIds[], expeditionType }` |
| `BattleStateUpdate` | S→C | Full battle snapshot |
| `PlayerDataUpdate` | S→C | Delta of changed PlayerData fields |

| RemoteFunction | Direction | Returns |
|---|---|---|
| `GetPetData` | C→S | `PetData` for given PetId |
| `GetLeaderboard` | C→S | Top 100 array for given board ID |
| `GetCodex` | C→S | Full `CodexEntries` map |

### 16.5 Roblox-Specific Notes

| Topic | Guidance |
|---|---|
| Data persistence | Use **ProfileService** or **DataStore2** for atomic saves and session locking |
| Pet data size | Store `PetRosterIds` in PlayerData; load individual PetData on demand — avoids DataStore size limit |
| Battle authority | All damage, XP, and reward logic server-side only; client is display only |
| Dungeon instancing | Use `TeleportService:TeleportAsync` to a reserved server; pass dungeon config via `TeleportOptions:SetTeleportData` |
| Player-to-player tips | Use `MarketplaceService:PromptProductPurchase`; log sender + receiver in `ProcessReceipt`; transfer in-game rewards server-side |
| Receipt idempotency | Store processed receipt IDs in DataStore; check before granting rewards in `ProcessReceipt` |
| Energy regen | Lazy evaluation only — compute on login and before any energy action; no server loop |
| Leaderboard updates | Write to `OrderedDataStore` only on rep change, level-up, or codex update — not on every frame |
| Anti-exploit | Validate all C→S inputs: item ownership, energy availability, dungeon daily limit, pet ownership |
