# Game Design Document — Anjay Hunter

## 1. Overview

| Field | Value |
|---|---|
| **Title** | Anjay Hunter |
| **Platform** | Roblox |
| **Genre** | Monster Capture / Turn-Based RPG |
| **Art Style** | Voxel / Block |
| **Core Loop** | Explore → Hunt → Capture → Train → Evolve → Battle → Rank Up |

---

## 2. Core Concept

Players explore a voxel world, hunting and capturing wild animals/beasts to keep as pets. Pets level up, evolve, learn skills, gain elements, and fight in turn-based battles — against wild beasts, dungeon monsters, NPCs, or other players. Reputation and rank grow through PvP. Multiple overlapping reward loops keep players coming back daily.

---

## 3. Game Loops

Three layered loops create short-term satisfaction and long-term retention.

### Micro Loop (minutes)
```
Battle (wild beast / monster / NPC)
  → XP + Silver/Gold + Loot
  → Pet levels up → attributes grow
  → Unlock stronger skills / element
  → Battle harder enemy
```

### Mid Loop (hours / days)
```
Clear Dungeon → Boss drop (rare item / rare pet)
  → Evolve pet → stronger team
  → Challenge higher zone dungeon
  → Capture rarer species → fill Codex
  → Daily Quests + Bounties → bonus rewards
```

### Macro Loop (weeks / months)
```
Climb PvP rank → unlock rank rewards
  → Build guild → Guild War
  → Seasonal Events → exclusive pets / cosmetics
  → Complete Pet Codex → prestige title
  → Leaderboard competition → social status
```

---

## 4. World & Aesthetic

- Voxel/block visual style throughout (terrain, buildings, pets, players, monsters)
- World zones:

| Zone | Level Range | Content |
|---|---|---|
| Starter Plains | 1 – 20 | Tutorial, first wild beasts, basic NPC trainers |
| Forest | 21 – 100 | Wild beasts, Forest Dungeon, NPC trainers |
| Mountain | 101 – 300 | Wild beasts, Mountain Dungeon, tougher NPCs |
| Volcano | 301 – 600 | Wild beasts, Volcano Dungeon, elite NPCs |
| Abyss | 601 – 1000 | Rare wild beasts, Abyss Dungeon, endgame bosses |
| Town / Hub | — | Shops, Bounty Board, Battle Arena, Guild Hall, social space |

---

## 5. Player System

### 5.1 Reputation & Ranking

Rank climbs by winning PvP battles. Ranks lowest to highest:

**Copper → Iron → Silver → Gold → Platinum → Mithril → Orichalcum → Adamantite**

Each rank tier has sub-divisions (I, II, III) for finer progression. Rank rewards (cosmetics, currency, titles) unlock at each tier milestone.

PvP uses **open challenge** — any player can challenge any other player directly in the world.

| Battle Type | Win Reward | Lose Penalty |
|---|---|---|
| Wild Beast | Capture beast as pet | None |
| Dungeon Monster | Silver / Gold + loot drop | None |
| NPC Trainer | Silver / Gold | None |
| Other Player | Reputation points | Minor reputation loss |

### 5.2 Inventory

| # | Category | Description |
|---|---|---|
| 1 | **Consumable** | Used on pets (HP restore, stamina items, evolution materials) |
| 2 | **Collectible** | Show off or sell; no functional use |
| 3 | **Cosmetic** | Worn by player (outfits, accessories) |

### 5.3 Currency

| Currency | Use |
|---|---|
| **Silver** | Common — consumables, basic traps, NPC battles, skill purchases |
| **Gold** | Premium — rare pets, pet slot upgrades, skill slot upgrades, evolution |

### 5.4 Hunt Energy

Players have a daily **Hunt Energy** pool (e.g., 100 points). Engaging wild beasts and dungeon runs consume energy. Recharges naturally over time or via consumable items. Prevents infinite farming while keeping casual and hardcore players both satisfied.

---

## 6. Pet System

### 6.1 Pet Capacity

- Default: **2 pet slots**
- Upgradable via Gold or special items
- Maximum cap: **500 pet slots**

### 6.2 Species & Rarity Tiers

| Tier | Examples | Source |
|---|---|---|
| Common | Dog, Cat, Pig, Horse, Slime | Wild areas, Pet Shop |
| Uncommon | Goblin, Wolf, Fox, Parrot | Wild areas, Dungeon drop |
| Rare | Lion, Eagle, Tiger, Orc | Wild areas (rare spawn), Dungeon boss drop |
| Epic | Troll, Elf, Vampire, Werewolf | Deep dungeons, special events |
| Legendary | Dragon, Phoenix | Abyss zone, seasonal events only |

Each species has a fixed **skill pool** from which default and buyable skills are drawn.

### 6.3 Attributes

| Attribute | Description |
|---|---|
| **HP** | Health Points — pet knocked out when 0 |
| **Stamina** | Fuel for skills; restores fully at the start of each battle |
| **Attack** | Base physical damage output |
| **Defense** | Damage reduction from incoming hits |
| **Speed** | Determines turn order in battle |

### 6.4 Level & Experience

- Max level: **1000**
- XP gained from all battle types
- Each level-up increases base attributes
- **Level 50**: element imbuing unlocks for all species
- Evolution level thresholds vary per species (see §6.6)

### 6.5 Elements

Pet imbued with one element at **level 50+**. Imbuing also unlocks element-specific skills in the Skill Shop. Changing element requires a costly re-imbue item.

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

- **Strong against** → 1.5× damage multiplier
- **Weak against** → 0.5× damage received
- No element → neutral (1×) in both directions

### 6.6 Evolution

Every species has **up to 3 evolution stages**. Evolving changes the pet's voxel model, boosts base stats beyond normal level scaling, and may unlock a new default skill.

| Stage | Requirement | Cost |
|---|---|---|
| Base → Stage 2 | Reach evolution level (varies per species) + Evolution Shard | Silver |
| Stage 2 → Stage 3 | Higher evolution level + Evolution Crystal + species-specific item | Gold |

Example evolution chains:

| Species | Base | Stage 2 | Stage 3 |
|---|---|---|---|
| Dog | Dog | Wolf | Dire Wolf |
| Slime | Slime | Slime King | Slime Titan |
| Dragon | Whelp | Drake | Elder Dragon |
| Goblin | Goblin | Hobgoblin | Goblin Warchief |

### 6.7 Skill System

**Default skills:** Every pet spawns with 2 skills tied to its species.

**Skill slots:** Default 2 slots; purchase additional slots with Gold. No hard cap — scales with currency investment.

**Buying skills:** Purchasable from Skill Shop (inside Pet Shop).

**Skill management:** Player equips/unequips skills from the pet's learned pool into active slots.

**Stamina cost:** Every skill has a stamina cost; pet cannot use a skill if stamina is insufficient.

| Action | Description |
|---|---|
| Default skills | 2 per pet, species-based, pre-equipped |
| Buy skill | Spend Silver/Gold to add to pet's skill pool |
| Equip skill | Assign from pool to an active slot |
| Upgrade slot | Spend Gold to unlock additional active slot |

### 6.8 Pet Codex

A collection journal tracking every species the player has captured at least once. Completing entries (capturing every evolution stage) rewards Silver, Gold, cosmetics, and exclusive titles. Completion percentage is visible to other players — a social status signal.

---

## 7. Monster System

Monsters are non-animal enemies found exclusively in **Dungeons**. Unlike wild beasts, most monsters cannot be captured — they drop loot and currency. A select few species (Slime, Goblin) are capturable via dungeon-specific traps.

### 7.1 Monster Roster

| Dungeon | Common Monsters | Rare Monsters | Boss |
|---|---|---|---|
| Forest Cave | Slime, Bat, Goblin | Hobgoblin, Giant Bat | Goblin Warchief |
| Mountain Ruins | Skeleton, Ghost, Zombie | Vampire, Wraith | Lich King |
| Dark Forest | Elf Archer, Fairy (hostile) | Treant, Dark Elf | Elder Treant |
| Volcano Pit | Orc, Troll, Lava Slime | Ogre, Fire Orc | Orc Overlord |
| Abyss Rift | Demon, Wraith, Specter | Dark Troll, Fallen Elf | Abyssal Demon Lord |

### 7.2 Monster Drops

| Drop Type | Description |
|---|---|
| Silver / Gold | Standard currency drop |
| Evolution Shards / Crystals | Required for pet evolution |
| Species-specific items | Used in Stage 3 evolution recipes |
| Rare Collectibles | Sell or show off |
| Trap Blueprints | Craft higher-tier traps |
| Pet (capturable species only) | Added to roster on successful capture |

### 7.3 Dungeon Structure

- **Wave-based:** 5–10 waves of monsters per dungeon run, scaling difficulty per wave
- **Boss wave:** Final wave features the zone boss — higher HP, unique skills, guaranteed rare drop
- **Daily limit:** Players can run each dungeon a set number of times per day (energy-gated)
- **Solo or co-op:** Players can enter dungeons alone or with a partner (2-player co-op)

---

## 8. Battle System

Turn-based combat. Player selects one action per turn.

### 8.1 Turn Order

Determined by **Speed** attribute. Higher speed acts first. Equal Speed resolves randomly.

### 8.2 Actions Per Turn

| Action | Description |
|---|---|
| **Attack** | Basic physical hit; damage = Attack − Defense (min 1) |
| **Use Skill** | Costs stamina; applies skill effect (damage, heal, buff, debuff) |
| **Use Item** | Consume item from inventory; does not cost the turn in wild/NPC battles; costs turn in PvP |
| **Swap Pet** | Switch active pet; costs the turn |
| **Flee** | Attempt escape; valid only vs wild beasts and dungeon monsters |

### 8.3 Elemental Combat

On every hit, check attacker element vs defender element:
- Strong matchup → ×1.5 damage
- Weak matchup → ×0.5 damage
- Neutral → ×1.0 damage

### 8.4 Capture Mechanic (Wild Beasts)

Capture attempt requires a **Trap item**. Can only be used when beast is below 50% HP.

```
capture_chance = base_rate × (1 - current_hp / max_hp) × (1 / rarity_modifier)
```

| Trap | Base Rate | Rarity Modifier | Cost |
|---|---|---|---|
| Basic Trap | 30% | ×1.0 | Silver |
| Iron Trap | 50% | ×1.0 | Silver |
| Gold Trap | 70% | ×0.8 | Gold |
| Legend Trap | 90% | ×0.5 | Gold (rare drop / craft) |

On success: beast added to roster if slot available. Full slot = prompted to release a pet first.

### 8.5 Battle Types

| Type | Opponent | Win | Lose |
|---|---|---|---|
| Wild Hunt | Roaming beast | Capture pet | None |
| Dungeon Run | Monster waves + Boss | Silver / Gold + loot | None (exit dungeon) |
| NPC Battle | Scripted trainer | Silver / Gold | None |
| PvP | Other player | Reputation points | Minor reputation loss |

---

## 9. Progression & Retention Systems

### 9.1 Daily Quests

Resets every 24 hours. Complete 3–5 tasks for bonus rewards.

| Example Quest | Reward |
|---|---|
| Win 5 battles (any type) | Silver |
| Capture 1 wild beast | Iron Trap ×3 |
| Complete 1 dungeon run | Gold |
| Win 2 PvP battles | Reputation boost |
| Use a skill 10 times | Evolution Shard |

### 9.2 Bounty Board

Located in Town/Hub. Rotating posted bounties with 24–48 hour timers.

| Bounty Type | Example | Reward |
|---|---|---|
| Hunt specific beast | "Capture a Wolf" | Gold ×5 |
| Dungeon kill count | "Defeat 30 Goblins" | Evolution Shard ×2 |
| PvP challenge | "Win 5 PvP battles" | Reputation ×2 |
| Boss hunt | "Defeat the Lich King" | Legend Trap + Gold |

### 9.3 Achievements

Permanent one-time milestones with rewards. Never expires.

| Achievement | Reward |
|---|---|
| First Capture | Basic Trap ×5 |
| Capture 50 different species | Cosmetic + Gold |
| Reach pet level 100 | Gold + Evolution Shard |
| Win 100 PvP battles | Title: "Brawler" |
| Complete the Pet Codex | Title: "Grand Hunter" + Legendary Cosmetic |
| Defeat all dungeon bosses | Title: "Dungeon Clearer" |
| Reach Adamantite rank | Title: "Adamantite" + exclusive cosmetic |

### 9.4 Pet Expedition (Idle Loop)

Send 1–3 pets on an expedition while offline. They return after a set duration with XP, Silver, and common items. Pets on expedition cannot be used in battle. Encourages daily login to collect rewards.

| Expedition | Duration | Returns |
|---|---|---|
| Short | 1 hour | Small XP + Silver |
| Medium | 4 hours | Medium XP + Silver + random item |
| Long | 12 hours | High XP + Gold chance + rare item |

### 9.5 Leaderboards

Visible in Town/Hub and via a global menu.

| Board | Metric |
|---|---|
| PvP Rank | Reputation points |
| Top Pets | Highest single pet level |
| Codex Completion | % of species captured |
| Guild War | Guild battle wins |
| Dungeon Speed | Fastest dungeon clear time |

### 9.6 Seasonal Events

Time-limited events (holiday, anniversary, etc.) with exclusive content:
- Exclusive pet species only available during the event
- Event-specific dungeon with unique boss
- Event currency earned from all battles → spend at event shop
- Event cosmetics and collectibles

### 9.7 Title System

Players equip **one active title** displayed above their name. Titles are the primary social flex tool — rare titles signal history, dedication, or generosity that cannot be bought with Gold alone.

#### Title Categories

| Category | Examples | Source |
|---|---|---|
| **Rank** | "Iron", "Adamantite", "Orichalcum" | Reach that PvP rank |
| **Achievement** | "Grand Hunter", "Dungeon Clearer", "Brawler" | Complete achievements |
| **Collection** | "Codex Master", "Dragon Tamer", "Legendary Keeper" | Codex milestones |
| **Event** | "Festival Champion", "Shadow Slayer", "Seasonal Hero" | Win or complete events |
| **Donor** | "Supporter", "Patron", "Benefactor", "Legend Donor" | Cumulative donation tiers |
| **Social** | "Generous Soul", "Patron of the Wild" | Donate to other players |
| **Special** | "Pioneer" (early player), "Tester", "Dev Friend" | Staff-granted, one-off |

#### Title Rarity Visual

Title text color and style indicates rarity:

| Rarity | Style |
|---|---|
| Common | White plain text |
| Uncommon | Green text |
| Rare | Blue text |
| Epic | Purple text |
| Legendary | Gold animated gradient text |
| Special | Rainbow animated text |

Donor and special titles always render at Legendary or Special rarity regardless of account progression — visible distinction that rewards real support.

### 9.8 Badge System

Two distinct badge layers:

#### Roblox Platform Badges
Awarded via Roblox's official Badge system — permanently visible on the player's Roblox profile page. These persist even after leaving the game and serve as proof of achievement to the wider Roblox community.

| Badge | Trigger |
|---|---|
| First Steps | Capture your first pet |
| Beast Slayer | Defeat 100 wild beasts |
| Dungeon Diver | Complete your first dungeon |
| Boss Hunter | Defeat all 5 dungeon bosses |
| PvP Champion | Reach Gold rank |
| Adamantite Legend | Reach Adamantite rank |
| Codex Complete | Capture all species |
| True Supporter | Make first donation to any player |

#### In-Game Badge Pins
Small voxel badge icons pinned to the player's character model. Stackable — players can display up to 3 at once. Visible in the world to everyone nearby.

| Badge Pin | Source |
|---|---|
| Rank crest (current rank icon) | Auto-updates with rank |
| Dungeon star (# of bosses defeated) | Achievement |
| Donor heart | Any donation made |
| Event medal | Seasonal event completion |
| Guild emblem | Guild membership |

---

## 10. Pet Showing Off

- Active pets (up to 2 shown by default) walk alongside player in the world
- Other players see your pets — rare evolved pets attract attention
- Codex completion % displayed above player name
- PvP rank badge visible on player
- Cosmetics (player outfit + pet cosmetic accessories) complete the flex

---

## 11. Shop System

Three distinct shops in Town/Hub.

### 11.1 Item Shop

| Stock | Currency |
|---|---|
| HP / Stamina consumables | Silver |
| Trap items (Basic, Iron, Gold) | Silver |
| Legend Trap (rare stock) | Gold |
| Evolution Shards | Silver / Gold |
| Collectibles | Silver / Gold |
| Cosmetic gear | Silver / Gold |

### 11.2 Pet Shop

| Action | Description |
|---|---|
| Buy Pet | Pre-caught pets from rotating stock (Common–Rare tiers) |
| Sell Pet | Sell owned pets for Silver / Gold |
| Upgrade Slot | Buy additional pet roster slots |

### 11.3 Skill Shop (inside Pet Shop)

| Action | Description |
|---|---|
| Buy Skill | Purchase species-specific or element-specific skills |
| Upgrade Skill Slot | Buy additional active skill slots per pet |

---

## 12. Guild / Clan System *(Future Scope)*

- Players form guilds (name, banner, voxel emblem)
- **Guild War**: scheduled guild-vs-guild PvP events; winning guild earns Guild Points and territory
- **Guild Storage**: shared collectible/item bank
- **Guild Rank**: separate progression from player rank
- **Guild Quests**: cooperative daily missions for shared reward pool
- Implementation deferred to post-launch

---

## 13. Economy Design

Two key principles: **meaningful sinks** and **earn vs buy balance**.

| Silver Sink | Gold Sink |
|---|---|
| Basic traps, consumables | Pet slot upgrades |
| Common skill purchases | Skill slot upgrades |
| Stage 2 evolution cost | Stage 3 evolution cost |
| NPC battle fees (optional toll) | Legend Trap |
| Re-imbue element | Rare pet from Pet Shop |

Gold is earnable in-game (dungeon bosses, daily quests, bounties) but at a slow rate — keeps it premium without being pay-to-win. Silver flows freely to sustain the daily loop.

---

## 14. Progression Summary

```
New Player (2 pet slots)
  │
  ▼
Starter Plains → battle wild beasts → capture first pet
  │
  ▼
Daily Quests + Bounties → Silver income + trap supplies
  │
  ▼
Forest Dungeon → fight Goblins + Slimes → boss drop (Evolution Shard)
  │
  ▼
Pet hits evolution level → evolve with Shard → stronger stats + new skill
  │
  ▼
Pet hits level 50 → imbue element → buy element skills from Skill Shop
  │
  ▼
Open challenge other players → climb rank (Copper → Adamantite)
  │
  ▼
Expand pet slots → capture Rare + Epic species → fill Codex
  │
  ▼
Abyss Dungeon → epic loot → Stage 3 evolution → endgame team
  │
  ▼
Seasonal events → exclusive Legendary pets → social flex
  │
  ▼
Pet Codex 100% → "Grand Hunter" title → Leaderboard top → prestige
```

---

## 15. Monetization

All monetization is built on three principles:
1. **No pay-to-win in PvP** — nothing purchasable gives a stat advantage over other players in combat
2. **Everything earnable in-game** — paid items only accelerate or cosmetically enhance; never gate core content
3. **Transparent** — no hidden odds; any random element shows exact probability

---

### 15.1 Robux as Premium Currency

Roblox's native currency (R$) is used for all real-money purchases. Players buy Robux through Roblox platform. Developer earns 70% of Robux spent after DevEx.

---

### 15.2 Game Passes (One-Time Purchase)

Permanent perks bought once with Robux.

| Game Pass | Perks | Suggested Price |
|---|---|---|
| **Hunter's VIP** | +25% Silver & Gold from all battles, +1 daily quest slot, VIP badge on profile | 499 R$ |
| **Pet Whisperer** | +10% flat capture rate bonus, no cooldown between capture attempts | 299 R$ |
| **Double XP** | Pets earn 2× XP from all battle types permanently | 399 R$ |
| **Expedition Master** | +2 expedition slots (1 → 3), expedition timers run 25% faster | 349 R$ |
| **Dungeon Veteran** | +1 daily dungeon run per dungeon, auto-collect loot after each wave | 449 R$ |
| **Battle Tactician** | Using items in PvP does not cost a turn | 299 R$ |
| **Slot Booster** | Start with 10 pet slots instead of 2 | 199 R$ |

> Game passes stack. A player with Hunter's VIP + Double XP gets both bonuses simultaneously.

---

### 15.3 Developer Products (Repeatable Purchases)

Spent per-use with Robux. Main source of recurring revenue.

#### Gold Bundles

| Bundle | Gold Amount | Suggested Price |
|---|---|---|
| Small Pouch | 100 Gold | 49 R$ |
| Medium Chest | 500 Gold | 199 R$ |
| Large Vault | 2,000 Gold | 699 R$ |
| Titan Hoard | 5,000 Gold | 1,499 R$ |

#### Convenience Items

| Product | Description | Suggested Price |
|---|---|---|
| **Energy Refill** | Restore full Hunt Energy immediately | 29 R$ |
| **Dungeon Key** | One extra dungeon run beyond daily limit | 39 R$ |
| **Capture Boost** | +20% capture rate for next 5 attempts | 19 R$ |
| **XP Boost (1h)** | 3× XP for all pets for 1 hour | 49 R$ |

---

### 15.4 Cosmetic Shop

Purely visual. No gameplay effect. Rotates weekly stock to create FOMO without pay-to-win.

#### Pet Skins

Alternate voxel models for a specific pet species. Applied to one pet; transferred if pet is released.

| Skin Tier | Example | Price |
|---|---|---|
| Common Skin | Dog → Dalmatian, Slime → Crystal Slime | 99 R$ |
| Rare Skin | Wolf → Shadow Wolf, Dragon → Gold Dragon | 249 R$ |
| Legendary Skin | Phoenix → Inferno Phoenix (animated flames) | 499 R$ |

#### Player Cosmetics

| Item | Description | Price |
|---|---|---|
| Outfit sets | Full voxel armor/clothing sets | 149–299 R$ |
| Pet accessories | Hats, wings, aura effects on your walking pets | 79–199 R$ |
| Name tag styles | Colored or animated player name display | 49–99 R$ |
| Emote packs | 3-emote bundles for social expression | 99 R$ |
| Pet trails | Particle effect following your walking pet | 149 R$ |

---

### 15.5 Seasonal Battle Pass

Runs alongside each seasonal event (~4 weeks). Two tracks:

| Track | Cost | Content |
|---|---|---|
| **Free Track** (10 tiers) | Free | Silver, consumables, common trap, basic cosmetic |
| **Paid Track** (50 tiers) | 499 R$ | All free rewards + exclusive event pet skin, Gold bundles, Evolution Crystals, unique title, animated pet accessory |

- XP for both tracks earned from daily quests, battles, and dungeon runs
- Paid track can be purchased any time during the event — retroactively unlocks already-earned paid tiers
- Exclusive rewards never return to the shop after event ends

---

### 15.6 Roblox Premium Perks

Passive bonuses for players with active Roblox Premium subscription (handled by Roblox platform, not Robux spend).

| Perk | Description |
|---|---|
| +15% Silver bonus | All Silver earned from battles boosted |
| Free daily Energy Refill | One free Hunt Energy restore per day |
| Premium badge | Visible on player profile |
| Early event access | 24-hour head start on seasonal events |

---

### 15.7 Donation System

Two donation flows: **player-to-developer** (supports the game) and **player-to-player** (social tipping between players).

#### Developer Donations

Players donate directly to support the game's development. Implemented as fixed-price Robux game passes (not consumable — purely a donation vessel).

| Donation Pass | Price | Reward |
|---|---|---|
| Supporter | 50 R$ | "Supporter" donor title + Donor Heart badge pin |
| Patron | 250 R$ | "Patron" donor title (Epic purple) + exclusive Patron cosmetic |
| Benefactor | 750 R$ | "Benefactor" title (Legendary gold) + exclusive Benefactor pet skin + badge |
| Grand Patron | 2,000 R$ | "Grand Patron" title (Legendary animated) + all previous rewards + name on Donor Hall of Fame |
| Legend Donor | 5,000 R$ | "Legend Donor" title (Special rainbow) + unique aura effect + permanent top-slot on Donor Hall of Fame |

Donor tiers are **cumulative** — total Robux donated across all passes determines tier. A player who buys Supporter × 5 counts as 250 R$ total.

#### Donor Hall of Fame

Physical board in Town/Hub listing top donors by cumulative amount. Refreshes in real-time. Players walk past it daily — powerful social signal. Top 10 shown with name, title, and amount donated.

#### Player-to-Player Donations

Players can tip other players they admire (strong PvP fighter, impressive pet collection, generous trader). Implemented via per-player donation boards placed in the world or at a dedicated "Tip Jar" social area in Town/Hub.

**Flow:**
1. Player A visits Player B's profile or donation board
2. Selects a tip amount (pre-set tiers)
3. Roblox processes purchase — Player B earns Robux (70% after Roblox cut)
4. Both players get social rewards

| Tip Tier | Price | Sender Gets | Receiver Gets |
|---|---|---|---|
| Small Tip | 10 R$ | "Generous Soul" badge progress | Silver bonus |
| Medium Tip | 50 R$ | "Generous Soul" badge progress | Silver + Gold bonus |
| Big Tip | 150 R$ | "Generous Soul" badge progress | Exclusive "Most Tipped" leaderboard entry |
| Mega Tip | 500 R$ | "Patron of the Wild" title | "Most Tipped" top slot + special thank-you effect |

**Sender rewards accumulate** — reaching 1,000 R$ total tipped across all players unlocks the "Generous Soul" title (Legendary rarity).

#### Most Tipped Leaderboard

Weekly leaderboard in Town/Hub showing players who received the most tips that week. Winner gets "Weekly Favorite" cosmetic border for 7 days — resets next week. Strong incentive for skilled/famous players to show off and attract tips.

---

### 15.8 Revenue Model Summary


| Source | Type | Revenue Driver |
|---|---|---|
| Game Passes | One-time | New player conversion |
| Gold Bundles | Repeatable | Engaged mid-core players |
| Convenience Products | Repeatable | Daily active grinders |
| Cosmetic Shop | Repeatable | Social/vanity-driven players |
| Battle Pass | Per-season | Retention + seasonal engagement |
| Developer Donations | One-time (per tier) | Fans and supporters |
| Player-to-Player Tips | Repeatable | Social economy, community engagement |
| Roblox Premium | Platform | Passive payout from Premium members |

### 15.9 Ethical Guardrails

- No loot boxes or gacha — all purchases show exact contents before buying
- No exclusive gameplay-affecting skills, pets, or stats locked behind paywall
- Wild-caught pets are always as strong as shop-bought pets at the same level
- PvP matchmaking ignores purchased passes when calculating skill level
- Capture rates, drop rates, and expedition yields displayed transparently in-game
- Donor titles are social recognition only — zero stat or gameplay advantage
- Player-to-player tipping is voluntary; no pressure mechanics or prompts mid-battle
- Hall of Fame listing requires explicit player opt-in
