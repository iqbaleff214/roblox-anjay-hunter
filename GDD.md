# Game Design Document — Anjay Hunter

## 1. Overview

| Field | Value |
|---|---|
| **Title** | Anjay Hunter |
| **Platform** | Roblox |
| **Genre** | Monster Capture / Turn-Based RPG |
| **Art Style** | Voxel / Block |
| **Core Loop** | Explore → Hunt wild beasts → Capture → Train → Battle |

---

## 2. Core Concept

Players explore a voxel world, hunting and capturing wild animals/beasts to keep as pets. Pets level up, learn skills, gain elements, and fight in turn-based battles — against wild beasts, NPCs, or other players. Reputation and rank grow through player-vs-player combat.

---

## 3. World & Aesthetic

- Voxel/block visual style throughout (terrain, buildings, pets, players)
- World zones:
  - **Wild Areas** — roaming beasts, hunting grounds
  - **Town/Hub** — shops, social space, battle arenas
  - **NPC Zones** — scripted NPC trainers with currency rewards

---

## 4. Player System

### 4.1 Reputation & Ranking

Player reputation rank increases by winning PvP battles. Ranks from lowest to highest:

**Copper → Iron → Silver → Gold → Platinum → Mithril → Orichalcum → Adamantite**

| Battle Type | Reward |
|---|---|
| Wild Beast | Capture beast as pet |
| NPC | Silver / Gold currency |
| Other Player | Reputation points → rank progress |

PvP uses **open challenge** — any player can challenge any other player directly in the world.

### 4.2 Inventory

Three item categories:

| # | Category | Description |
|---|---|---|
| 1 | **Consumable** | Used on pets (health items, stamina items, etc.) |
| 2 | **Collectible** | Show off or sell; no functional use |
| 3 | **Cosmetic** | Worn by player (outfits, accessories) |

### 4.3 Currency

| Currency | Use |
|---|---|
| **Silver** | Common — daily purchases, basic items |
| **Gold** | Premium — rare pets, skill slots, upgrades |

---

## 5. Pet System

### 5.1 Pet Capacity

- Default: **2 pet slots**
- Upgradable via currency or special items
- Maximum cap: **500 pet slots**

### 5.2 Species

Examples (not exhaustive):

| Tier | Species |
|---|---|
| Common | Dog, Cat, Pig, Horse |
| Rare | Lion, Eagle, Tiger |
| Legendary | Dragon, Phoenix |

Each species has a fixed **skill pool** from which default and buyable skills are drawn.

### 5.3 Attributes

| Attribute | Description |
|---|---|
| **HP** | Health Points — pet knocked out when 0 |
| **Stamina** | Fuel for skills; regenerates fully at start of each battle |
| **Attack** | Base physical damage output |
| **Defense** | Damage reduction from incoming hits |
| **Speed** | Determines turn order in battle |
| *(extendable)* | Additional stats possible per species |

### 5.4 Level & Experience

- Max level: **1000**
- XP gained from battles (wild, NPC, PvP)
- Each level-up increases base attributes
- **Level 50**: element imbuing becomes available for all species

### 5.5 Elements

Pet can be imbued with one element at **level 50+**. Elements follow a weakness/strength chart inspired by Dragon City — every element is strong against at least one and weak against at least one.

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

- **Strong against** = deals bonus damage
- **Weak against** = takes bonus damage
- No element = neutral damage in both directions
- Imbuing also unlocks access to element-specific skills in the skill shop

### 5.6 Skill System

**Default skills:** Every pet spawns with 2 skills tied to its species.

**Skill slots:** Default 2 slots; purchase additional slots with Gold. No hard cap defined — scales with currency investment.

**Buying skills:** Skills purchasable from the Skill Shop (separate counter inside Pet Shop or standalone).

**Skill management:** Player equips/unequips skills from their pet's learned pool into active slots.

**Stamina cost:** Every skill has a stamina cost; pet cannot use a skill if stamina is insufficient.

| Action | Description |
|---|---|
| Default skills | 2 per pet, species-based, pre-equipped |
| Buy skill | Spend currency to add to pet's skill pool |
| Equip skill | Assign from pool to an active slot |
| Upgrade slot | Spend Gold to unlock additional active slot |

---

## 6. Battle System

Turn-based combat. Player selects one action per turn.

### 6.1 Turn Order

Determined by **Speed** attribute. Higher speed acts first. On equal Speed, resolve randomly.

### 6.2 Actions Per Turn

- **Attack** — basic physical hit (uses Attack vs Defense)
- **Use Skill** — consumes stamina, applies skill effect
- **Use Item** — consume item from inventory mid-battle
- **Swap Pet** — switch to another owned pet (costs the turn)
- **Flee** — attempt escape (only valid vs wild beasts)

### 6.3 Battle Types

| Type | Opponent | Win Reward | Lose Penalty |
|---|---|---|---|
| **Wild Hunt** | Roaming beast | Capture beast as pet | None |
| **NPC Battle** | Scripted trainer | Silver / Gold | None |
| **PvP** | Other player | Reputation points | Minor reputation loss |

### 6.4 Capture Mechanic (Wild Hunt)

Capture attempt triggers when wild beast HP is low. Uses a **Trap item** from inventory.

**Success formula:**

```
capture_chance = base_rate × (1 - current_hp / max_hp) × (1 / rarity_modifier)
```

| Trap Item | Base Rate | Rarity Modifier |
|---|---|---|
| Basic Trap | 30% | ×1.0 |
| Iron Trap | 50% | ×1.0 |
| Gold Trap | 70% | ×0.8 (better on rares) |
| Legend Trap | 90% | ×0.5 (best on legendaries) |

- Lower beast HP = higher chance
- Higher beast rarity = harder to capture
- On success: beast added to roster if slot available; otherwise must release a pet first

### 6.5 NPC Difficulty by Zone

| Zone | Pet Level Range | Currency Reward |
|---|---|---|
| Starter Plains | 1 – 20 | Low Silver |
| Forest | 21 – 100 | Medium Silver |
| Mountain | 101 – 300 | High Silver / Low Gold |
| Volcano | 301 – 600 | Medium Gold |
| Abyss | 601 – 1000 | High Gold |

NPC trainers in each zone field pets scaled to that zone's level range.

---

## 7. Pet Showing Off

- Pets walk alongside player in the world (visible to all)
- Players see equipped pets as social status display
- Cosmetic items on player complement the aesthetic

---

## 8. Shop System

Two distinct shop types — no cross-selling between them.

### 8.1 Item Shop

Sells: consumables, collectibles, cosmetics

| Stock | Currency |
|---|---|
| HP/Stamina restore items | Silver |
| Trap items (Basic, Iron, Gold, Legend) | Silver / Gold |
| Rare collectibles | Gold |
| Cosmetic gear | Silver / Gold |

### 8.2 Pet Shop

Sells/buys: pets directly. Includes a **Skill Shop** counter for purchasing pet skills.

| Action | Description |
|---|---|
| Buy Pet | Purchase pre-caught pets from rotating stock |
| Sell Pet | Sell player-owned pets for currency |
| Buy Skill | Purchase skills for a specific species |
| Upgrade Slot | Buy additional skill slots for a pet |

Regular stock rotates; rare/legendary pets cost Gold.

---

## 9. Guild / Clan System *(Future Scope)*

- Players form guilds with a name and banner
- Guild battles (guild vs guild) for territory or leaderboard placement
- Guild chat and shared storage (collectibles / items)
- Guild rank separate from player rank
- Implementation deferred to post-launch

---

## 10. Progression Summary

```
New Player
  └─ 2 pet slots (max 100)
  └─ No pets, basic currency
      │
      ▼
Explore wild area → use Trap on low-HP beast → capture first pet
      │
      ▼
Battle NPCs in Starter Plains → earn Silver → level up pet
      │
      ▼
Buy skills / upgrade skill slots at Pet Shop
      │
      ▼
Reach level 50 → imbue element → unlock element skills
      │
      ▼
Challenge other players (open challenge) → earn reputation → climb rank
      Copper → Iron → Silver → Gold → Platinum → Mithril → Orichalcum → Adamantite
      │
      ▼
Upgrade pet capacity → explore higher zones → capture rarer species
      │
      ▼
Farm Abyss zone NPCs for Gold → acquire legendary pets (Dragon, Phoenix)
      │
      ▼
Max level 1000 legendary beast → Adamantite rank → endgame flex
```
