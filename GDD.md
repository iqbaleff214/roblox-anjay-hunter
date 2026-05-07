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

Player reputation rank increases by winning PvP battles. Ranks are tiered (e.g., Bronze → Silver → Gold → Platinum → Diamond → Legend).

| Battle Type | Reward |
|---|---|
| Wild Beast | Capture beast as pet |
| NPC | Silver / Gold currency |
| Other Player | Reputation points → rank progress |

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
| **Stamina** | Fuel for skills; regenerates between turns/battles |
| **Attack** | Base physical damage output |
| **Defense** | Damage reduction from incoming hits |
| **Speed** | Determines turn order in battle |
| *(extendable)* | Additional stats possible per species |

### 5.4 Level & Experience

- Max level: **1000**
- XP gained from battles (wild, NPC, PvP)
- Each level-up increases base attributes
- Certain level thresholds unlock:
  - Element imbuing eligibility
  - Additional skill slot purchases

### 5.5 Elements

Imbued at a specific level threshold (exact level TBD per species).

| Element | Weakness | Strength |
|---|---|---|
| Fire | Water | Earth |
| Water | Earth | Fire |
| Earth | Fire | Water |
| *(expand)* | ... | ... |

Element adds elemental bonus to attacks and may unlock element-specific skills.

### 5.6 Skill System

**Default skills:** Every pet spawns with 2 skills tied to its species.

**Skill slots:** Upgradable — default 2 slots, purchase additional slots with currency.

**Buying skills:** Skills purchasable from shop (pet skill shop or dedicated skill shop).

**Skill management:** Player equips/unequips skills into available slots.

**Stamina cost:** Every skill has a stamina cost; pet cannot use skill if stamina insufficient.

| Action | Description |
|---|---|
| Default skills | 2 per pet, species-based, pre-equipped |
| Buy skill | Spend currency to add to pet's skill pool |
| Equip skill | Assign from pool to an active slot |
| Upgrade slot | Spend currency to unlock additional slot |

---

## 6. Battle System

Turn-based combat. Player selects action each turn.

### 6.1 Turn Order

Determined by **Speed** attribute. Higher speed acts first.

### 6.2 Actions Per Turn

- **Attack** — basic physical hit (uses Attack vs Defense)
- **Use Skill** — consumes stamina, applies skill effect
- **Use Item** — consume item from inventory mid-battle
- **Swap Pet** — switch to another owned pet (costs turn)
- **Flee** — attempt escape (only valid vs wild beasts)

### 6.3 Battle Types

| Type | Opponent | Win Reward | Lose Penalty |
|---|---|---|---|
| **Wild Hunt** | Roaming beast | Capture beast as pet | None |
| **NPC Battle** | Scripted trainer | Silver / Gold | None |
| **PvP** | Other player | Reputation points | Reputation loss (minor) |

### 6.4 Capture Mechanic (Wild Hunt)

- Trigger capture attempt when wild beast is low HP
- Capture success rate influenced by: beast HP remaining, player capture item used, beast rarity
- On capture: beast added to player's pet roster (if slot available)

---

## 7. Pet Showing Off

- Pets walk alongside player in the world (visible to others)
- Players see equipped pets as social status flex
- Cosmetic items on player complement aesthetic display

---

## 8. Shop System

Two distinct shop types — no cross-selling.

### 8.1 Item Shop

Sells: consumables, collectibles, cosmetics

| Stock | Currency |
|---|---|
| HP/Stamina restore items | Silver |
| Rare collectibles | Gold |
| Cosmetic gear | Silver / Gold |

### 8.2 Pet Shop

Sells/buys: pets directly

| Action | Description |
|---|---|
| Buy | Purchase pre-caught pets from shop stock |
| Sell | Sell player-owned pets for currency |

Regular stock rotates; rare/legendary pets cost Gold.

---

## 9. Progression Summary

```
New Player
  └─ 2 pet slots
  └─ No pets, basic currency
      │
      ▼
Explore wild area → battle beast → capture first pet
      │
      ▼
Train pet (battles for XP) → level up → stronger attributes
      │
      ▼
Buy skills / upgrade skill slots
      │
      ▼
Reach element unlock threshold → imbue element
      │
      ▼
Challenge other players → earn reputation → climb rank
      │
      ▼
Upgrade pet capacity → collect more species
      │
      ▼
Max level 1000 legendary beast → Legend rank → endgame flex
```

---

## 10. Open Design Questions

- Exact level threshold for element imbuing per species: 50
- Maximum pet slot cap (after all upgrades): 100
- Full rank tier list and reputation thresholds: Adamantite, Orichalcum, Mithril, Platinum, Gold, Silver, Iron, Copper
- Stamina regen rate (per turn? per battle? time-based?): per battle
- PvP matchmaking method (open challenge vs ranked queue): open challenge
- Full element table (beyond Fire/Water/Earth): use dragon city elements also use their concept certain element is weak againt other element
- Capture item types and success rate formula: you decide
- NPC difficulty scaling by zone: you decide
- Guild / clan system (future scope?): yes
