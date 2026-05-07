# Beast Encyclopedia — Anjay Hunter

> Capturable species that can become pets. Each entry is a complete design reference for that species.
> Stats follow GDD §6.3 tier base values. Evolution thresholds follow GDD §6.6.

## Symbol Guide

| Symbol | Meaning |
|---|---|
| ★ | Default skill — pre-equipped on capture |
| [D] | Dungeon-capturable only; not found in wild |
| T | Turns (duration of effect) |
| SP | Stamina cost |
| — | Not applicable (non-damage skill) |

---

## 001 · Dog `Common`

**Natural Affinity:** Neutral
**Stat Build:** Balanced
**Habitat:** Open fields and village outskirts — `zone_starter`, `zone_forest`
**Behaviour:** Passive. Non-aggressive unless cornered. After capture, follows player eagerly and responds well to commands.

> *"Found at the edge of every settlement in the voxel world, the Dog has walked beside hunters since the earliest days — loyal to a fault, fierce when it needs to be."*

**Evolution Chain:**
```
Dog  ──(Lv 20 + Evolution Shard)──►  Wolf  ──(Lv 100 + Evolution Crystal + Dire Fang)──►  Dire Wolf
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Dog | Small, blocky, wagging tail | — |
| 2 | Wolf | Larger, grey coat, amber eyes | Howl |
| 3 | Dire Wolf | Massive, dark fur, glowing red eyes | Pack Leader |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 100 | 50 | 15 | 10 | 10 |

**Growth / Lv:** +5 HP · +2 Sta · +2 ATK · +1 DEF · +1 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Bite | Physical | 10 | ×1.2 | Standard fang strike |
| ★ | Bark | Debuff | 8 | — | Target SPD −25%, 2T (40% chance) |
| | Growl | Debuff | 12 | — | Target ATK −30%, 2T |
| | Howl | Self-Buff | 15 | — | Own ATK & SPD +20%, 2T; unlocks at Stage 2 |
| | Fang Rush | Physical | 20 | ×1.8 | 25% chance: Bleed DOT (×0.8 per turn, 3T) |
| | Pack Leader | Self-Buff | 35 | — | Own all stats +30%, 3T; unlocks at Stage 3 |

**Lore Notes:**
- Common starting pet; recommended for new players
- Dire Fang drop location: Forest Cave dungeon boss (Goblin Warchief), 10% drop rate
- Strong PvP utility via SPD debuff chain (Bark → Fang Rush)

---

## 002 · Fox `Uncommon`

**Natural Affinity:** Dark-lean
**Stat Build:** Speed
**Habitat:** Dense forest edges and shadowy undergrowth — `zone_forest`, `zone_mountain`
**Behaviour:** Skittish. Flees on first contact; escape chance 60%. Requires patience or Iron Trap to capture reliably.

> *"The Fox does not fight with strength — it fights with the idea of itself. By the time you see it clearly, it has already won."*

**Evolution Chain:**
```
Fox  ──(Lv 30 + Evolution Shard)──►  Nine-Tail Fox  ──(Lv 150 + Evolution Crystal + Spirit Orb)──►  Celestial Fox
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Fox | Small, orange-red voxel coat, bushy tail | — |
| 2 | Nine-Tail Fox | Larger, silver-white coat, 3 visible tails, faint dark aura | Spirit Flame |
| 3 | Celestial Fox | Elegant gold and white, 9 glowing tails, ethereal particle trail | Fox God's Blessing |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 110 | 70 | 19 | 11 | 20 |

**Growth / Lv:** +7 HP · +3 Sta · +3 ATK · +2 DEF · +1 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Quick Bite | Physical | 10 | ×1.2 | Fast strike; goes before target if SPD tied |
| ★ | Illusion Dash | Self-Buff | 12 | — | Own SPD +30% & 20% dodge chance, 2T |
| | Shadow Step | Debuff | 15 | — | Target misses next attack (50% chance) |
| | Spirit Flame | Dark Elemental | 18 | ×1.8 | 30% Blind on target, 2T; unlocks at Stage 2 |
| | Tail Whip | Physical | 22 | ×2.5 | Hits 3× at ×0.8 each; can trigger Blind on each hit |
| | Fox God's Blessing | Self-Buff | 40 | — | Own ATK & SPD +50%, immune to debuffs, 2T; Stage 3 only |

**Lore Notes:**
- Spirit Orb drops from Mountain Ruins boss (Lich King), 8% drop rate
- Highest base SPD of all Uncommon tier at Stage 1
- Celestial Fox is a social prestige pet — its 9-tail particle effect is visible from a distance

---

## 003 · Tiger `Rare`

**Natural Affinity:** Neutral (Dark-lean at Stage 3)
**Stat Build:** Offensive
**Habitat:** Dense jungle undergrowth and rocky overhangs — `zone_mountain`, `zone_volcano`
**Behaviour:** Territorial. Ignores player until within 15 studs; then charges immediately. Does not flee.

> *"Tigers do not hunt — they simply arrive. Everything before that moment is just the world pretending it was safe."*

**Evolution Chain:**
```
Tiger  ──(Lv 50 + Evolution Shard)──►  White Tiger  ──(Lv 200 + Evolution Crystal + Shadow Claw)──►  Shadow Tiger
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Tiger | Orange-black striped voxel body, crouching stance | — |
| 2 | White Tiger | White fur, ice-blue eyes, faint frost breath particle | Ambush |
| 3 | Shadow Tiger | Black translucent body, glowing violet stripes, shadow particle trail | Shadow Fang |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 150 | 85 | 34 | 14 | 21 |

**Growth / Lv:** +10 HP · +4 Sta · +5 ATK · +2 DEF · +3 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Pounce | Physical | 15 | ×1.8 | Always acts first on the turn it is used, regardless of SPD |
| ★ | Claw Swipe | Physical | 10 | ×1.2 | 35% Armor Break on target (DEF −30%, 2T) |
| | Ambush | Physical | 28 | ×2.5 | +50% extra damage if used on turn 1 of battle; unlocks at Stage 2 |
| | Roar | Debuff | 15 | — | Target ATK & SPD −20%, 2T |
| | Hunter's Mark | Debuff | 20 | — | Target takes +25% damage from all sources, 3T |
| | Shadow Fang | Physical | 40 | ×3.5 | Ignores 50% of target DEF; Stage 3 only |

**Lore Notes:**
- Shadow Claw drops from Volcano Pit boss (Orc Overlord), 12% drop rate
- Highest single-turn burst damage among Rare tier via Pounce + Hunter's Mark combo
- Difficult to capture (Rare rarity modifier ×2.5); recommend Gold Trap at 1 HP remaining

---

## 004 · Griffin `Epic`

**Natural Affinity:** Wind-lean
**Stat Build:** Balanced
**Habitat:** Mountain cliff peaks and storm-lashed ridges — `zone_volcano`, `zone_abyss`
**Behaviour:** Territorial. Patrols a fixed aerial circuit; dives aggressively when territory is entered. Cannot be fled from once engaged.

> *"Half lion, half eagle, and entirely uninterested in compromise. The Griffin does not share its sky."*

**Evolution Chain:**
```
Griffin  ──(Lv 75 + Evolution Shard)──►  War Griffin  ──(Lv 300 + Evolution Crystal + Feather of Heaven)──►  Celestial Griffin
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Griffin | Brown voxel eagle-head, lion-body, folded wings | — |
| 2 | War Griffin | Armored shoulder plates, battle-scarred, wings spread wider | Dive Bomb |
| 3 | Celestial Griffin | White and gold plumage, radiant wing glow, cloud particle trail | Celestial Slash |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 220 | 110 | 36 | 26 | 22 |

**Growth / Lv:** +14 HP · +6 Sta · +6 ATK · +4 DEF · +2 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Talon Strike | Physical | 15 | ×1.8 | Powerful claw rake |
| ★ | Wind Gust | Wind Elemental | 12 | ×1.2 | 35% Shock on target (SPD −25%, 2T) |
| | Battle Cry | Debuff | 20 | — | Target ATK −25%, 2T; also lowers target DEF −15%, 1T |
| | Dive Bomb | Physical | 25 | ×2.5 | Ignores 30% of target DEF; unlocks at Stage 2 |
| | Feather Storm | Wind Elemental | 30 | ×1.8 | Hits 2× at ×1.8 each; 20% Shock each hit |
| | Celestial Slash | Wind Elemental | 42 | ×3.5 | 40% Shock + Blind simultaneously; Stage 3 only |

**Lore Notes:**
- Feather of Heaven drops from Abyss Rift boss (Abyssal Demon Lord), 15% drop rate
- Only obtainable in `zone_volcano` (rare spawn) and `zone_abyss` (uncommon spawn)
- Celestial Griffin is a high-tier PvP and social prestige pet; Feather Storm is its core PvP tool

---

## 005 · Dragon `Legendary`

**Natural Affinity:** Fire-lean
**Stat Build:** Balanced
**Habitat:** Deep lava vents and ancient ruins in the Abyss — `zone_abyss` (rare spawn only)
**Behaviour:** Aggressive. Attacks all creatures in range on sight. Engages the player immediately and relentlessly. Cannot be fled from.

> *"The Dragon does not distinguish between hunter and prey. In its world, everything that moves is already a target — and everything that doesn't is next."*

**Evolution Chain:**
```
Whelp  ──(Lv 100 + Evolution Shard)──►  Drake  ──(Lv 500 + Evolution Crystal + Dragon Heart)──►  Elder Dragon
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Whelp | Small, clumsy voxel dragonling, tiny wings, no fire yet | — |
| 2 | Drake | Mid-size, defined scales, small flame jet from mouth, wing span doubled | Dragon Roar |
| 3 | Elder Dragon | Enormous, layered armored scales, full fire breath particle, lava glow eyes | Ancient Fury |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 300 | 150 | 50 | 36 | 30 |

**Growth / Lv:** +20 HP · +9 Sta · +9 ATK · +6 DEF · +3 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Dragon Bite | Physical | 15 | ×1.8 | Crushing jaw strike |
| ★ | Flame Breath | Fire Elemental | 12 | ×1.2 | 30% Burn on target (−5% max HP/turn, 3T) |
| | Scale Shield | Self-Buff | 20 | — | Own DEF +40%, 3T; also grants 15% Burn immunity |
| | Dragon Roar | Debuff | 25 | — | Target all stats −15%, 3T; unlocks at Stage 2 |
| | Inferno Dive | Fire Elemental | 32 | ×2.5 | 50% Burn; also deals 10% of target max HP as flat bonus damage |
| | Ancient Fury | Fire Elemental | 45 | ×3.5 | 100% Burn; bypasses elemental resistance; Stage 3 only |

**Lore Notes:**
- Dragon Heart drops exclusively from Elder Dragon (Stage 3 must be defeated in the wild or owned and sacrificed via a special NPC ritual — design TBD)
- Highest total stat ceiling in the game at Lv 1000 Stage 3
- Ancient Fury bypassing elemental resistance is the only skill in the game with this property — flag for balance review before ship
- Whelp spawn rate in `zone_abyss`: ~0.5% per wild encounter roll (extremely rare; most players obtain via Pet Shop during seasonal events)
