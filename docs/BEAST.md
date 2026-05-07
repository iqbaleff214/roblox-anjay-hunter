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

---

## 006 · Turtle `Common`

**Natural Affinity:** Earth-lean
**Stat Build:** Tank
**Habitat:** Shallow riverbanks and mossy stone patches — `zone_starter`, `zone_forest`
**Behaviour:** Passive. Ignores the player entirely until attacked. Once aggro'd, retreats into shell first (triggers DEF buff), then counter-attacks steadily.

> *"The Turtle has survived every age of the voxel world not by outrunning danger, but by outlasting it."*

**Evolution Chain:**
```
Turtle  ──(Lv 20 + Evolution Shard)──►  Armored Turtle  ──(Lv 100 + Evolution Crystal + Ancient Shell Fragment)──►  Stone Tortoise
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Turtle | Small green shell, stubby legs, gentle expression | — |
| 2 | Armored Turtle | Larger hexagonal shell plates, stone-grey tones, crack patterns | Stone Skin |
| 3 | Stone Tortoise | Massive, ancient-looking shell covered in moss and runes, earth particles | Seismic Shell |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 130 | 45 | 11 | 15 | 6 |

**Growth / Lv:** +5 HP · +2 Sta · +2 ATK · +1 DEF · +1 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Shell Slam | Physical | 12 | ×1.2 | Rams target with shell; 25% Armor Break (DEF −30%, 2T) |
| ★ | Withdraw | Self-Buff | 10 | — | Own DEF +50%, 1T; also reduces SPD −20% same turn |
| | Mud Toss | Earth Elemental | 14 | ×0.8 | 50% Shock on target (SPD −25%, 2T) |
| | Stone Skin | Self-Buff | 20 | — | Own DEF +40% & Regen +5% max HP/turn, 3T; unlocks at Stage 2 |
| | Crushing Shell | Physical | 28 | ×2.5 | Deals bonus damage equal to 5% of own max DEF as flat extra |
| | Seismic Shell | Earth Elemental | 38 | ×3.5 | Armor Break + 30% chance to skip target's next turn; Stage 3 only |

**Lore Notes:**
- Best natural DEF-to-HP ratio among all Common beasts
- Ancient Shell Fragment drops from Mountain Ruins boss (Lich King), 10% drop rate
- Stone Tortoise's `Seismic Shell` is the only Common-line skill that can inflict a turn skip — balance-check at Epic/Legendary PvP tiers

---

## 007 · Bee `Common`

**Natural Affinity:** Fire-lean
**Stat Build:** Offensive
**Habitat:** Flower meadows and hollow logs — `zone_starter`, `zone_forest`
**Behaviour:** Territorial. Passive until within 8 studs of spawn point (hive zone). If player steps inside, entire hive aggros at once — single Bee encounter, but with +20% ATK modifier (swarm context).

> *"Small enough to ignore. Numerous enough to be a problem. Brave enough to sting something ten thousand times its size."*

**Evolution Chain:**
```
Bee  ──(Lv 20 + Evolution Shard)──►  Queen Bee  ──(Lv 100 + Evolution Crystal + Royal Jelly Vial)──►  Hive Lord
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Bee | Tiny yellow-black striped voxel, buzzing wing particles | — |
| 2 | Queen Bee | Larger, crown-like head crest, golden tone, trailing pollen particles | Nectar Burst |
| 3 | Hive Lord | Imposing armored thorax, glowing amber eyes, swarm particle cloud around body | Royal Decree |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 90 | 50 | 18 | 8 | 12 |

**Growth / Lv:** +5 HP · +2 Sta · +2 ATK · +1 DEF · +1 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Sting | Physical | 8 | ×1.2 | 40% Poison on target (−3% max HP/turn, 5T) |
| ★ | Swarm | DOT | 15 | — | Inflicts Swarm: −4% max HP/turn for 4T; does not stack with Poison |
| | Pollen Cloud | Debuff | 12 | — | Target ATK −20% & 30% Blind, 2T |
| | Nectar Burst | Heal | 18 | — | Restores 25% of own max HP; unlocks at Stage 2 |
| | Stinger Barrage | Physical | 25 | ×1.8 | Hits 4× at ×0.5 each; each hit independently rolls 25% Poison |
| | Royal Decree | Self-Buff | 38 | — | Own ATK +60%, Poison proc chance on all skills +20%, 3T; Stage 3 only |

**Lore Notes:**
- Royal Jelly Vial drops from Forest Cave boss (Goblin Warchief), 8% drop rate
- Stinger Barrage + Royal Decree is the strongest multi-Poison setup in Common tier; monitor in PvP
- Hive Lord's swarm particle cloud is a distinct visual from all other Common-tier Stage 3 models

---

## 008 · Slime `Common`

**Natural Affinity:** Neutral (adapts to imbued element — lore: Slime takes on the colour of its element)
**Stat Build:** Defensive
**Habitat:** Damp cave floors and underground pools — `zone_starter`, `zone_forest` (cave areas)
**Behaviour:** Passive. Bounces curiously toward the player. Never initiates combat. If attacked, it wobbles and splits visual but does not flee.

> *"The Slime has no ambition, no territory, and no enemies. It is simply there — and somehow, always fine."*

**Evolution Chain:**
```
Slime  ──(Lv 20 + Evolution Shard)──►  Slime King  ──(Lv 100 + Evolution Crystal + Prism Core)──►  Slime Titan
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Slime | Small translucent green blob, jiggle idle animation | — |
| 2 | Slime King | Larger, with tiny voxel crown, deeper green-blue hue, trail of droplets | Absorb |
| 3 | Slime Titan | Massive crystalline form; colour shifts to match imbued element; prismatic glow | Prism Burst |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 120 | 50 | 12 | 14 | 8 |

**Growth / Lv:** +5 HP · +2 Sta · +2 ATK · +1 DEF · +1 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Slime Shot | Physical | 10 | ×1.2 | Gooey projectile; 30% Shock (SPD −25%, 2T) |
| ★ | Sticky Body | Debuff | 12 | — | Target SPD −40% for 3T; also reduces flee chance by 20% |
| | Split Dodge | Self-Buff | 15 | — | 35% dodge chance for 2T; own DEF +20% same duration |
| | Absorb | Heal | 20 | — | Restores HP equal to 15% of damage taken last turn (min 5); unlocks at Stage 2 |
| | Ooze Wave | Physical | 22 | ×1.8 | Coats target; all debuffs on target last +1T extra |
| | Prism Burst | Elemental | 40 | ×3.5 | Element matches pet's imbued element; if no element, deals true neutral damage ignoring resistances; Stage 3 only |

**Lore Notes:**
- Prism Core drops from Mountain Ruins boss, 12% drop rate
- Slime Titan's `Prism Burst` is the only skill that uses the pet's imbued element dynamically — dev must resolve element at cast time, not at skill definition time
- Slime's visual colour reacting to its imbued element is a unique cosmetic behaviour; requires element-to-colour mapping in the CosmeticService

---

## 009 · Octopus `Uncommon`

**Natural Affinity:** Water-lean
**Stat Build:** Defensive
**Habitat:** Coastal rock pools and underwater cave openings — `zone_forest` (rivers), `zone_mountain` (deep lakes)
**Behaviour:** Skittish. Retreats and inks when approached. Will only fight if cornered or if HP is above 80% (it retreats when weakened).

> *"Eight arms. Eight opinions. All of them wrong about whether you're a threat — until one of them wraps around your leg and proves you are."*

**Evolution Chain:**
```
Octopus  ──(Lv 30 + Evolution Shard)──►  Giant Octopus  ──(Lv 150 + Evolution Crystal + Deep-Sea Beak)──►  Kraken Spawn
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Octopus | Small orange-brown voxel, 8 short tentacles, suction-cup detail | — |
| 2 | Giant Octopus | Larger, deep-sea blue, longer tentacles with bioluminescent tips | Eight Arms |
| 3 | Kraken Spawn | Enormous dark-purple form, crackling water aura, tentacles leave water trail | Abyssal Wave |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 155 | 65 | 16 | 19 | 10 |

**Growth / Lv:** +7 HP · +3 Sta · +3 ATK · +2 DEF · +1 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Ink Blast | Debuff | 10 | — | Target accuracy −40% (50% miss chance), 2T; Blind variant |
| ★ | Tentacle Grab | Physical | 15 | ×1.2 | 40% chance: skip target's next turn (Bind) |
| | Water Jet | Water Elemental | 14 | ×1.8 | Knocks target back (cosmetic) + 25% Shock (SPD −25%, 2T) |
| | Suction Grip | Self-Buff | 18 | — | Own DEF +35%; reduces damage from Physical skills by 20%, 3T |
| | Eight Arms | Physical | 30 | — | Hits 8× at ×0.4 each; each hit independently rolls 20% Bind; unlocks at Stage 2 |
| | Abyssal Wave | Water Elemental | 42 | ×3.5 | 60% Blind + 40% Bind simultaneously; Stage 3 only |

**Lore Notes:**
- Deep-Sea Beak drops from Dark Forest boss (Elder Treant), 9% drop rate — thematic mismatch by design (Treant guards a coastal grotto)
- Eight Arms hitting 8× makes it the highest hit-count skill in the game; each hit is individually weak (×0.4) — verify damage cap isn't exploitable with Armor Break stacked
- Kraken Spawn is the visual precursor to the Kraken Legendary beast; lore connection intentional

---

## 010 · Scorpion `Uncommon`

**Natural Affinity:** Dark-lean
**Stat Build:** Balanced
**Habitat:** Arid stone flats and volcanic sand dunes — `zone_mountain`, `zone_volcano`
**Behaviour:** Aggressive in `zone_volcano`; Territorial in `zone_mountain`. Raises tail as a warning before charging — players have 2 seconds before auto-attack triggers.

> *"The Scorpion does not chase. It waits. The desert is patient, and so is everything that lives in it."*

**Evolution Chain:**
```
Scorpion  ──(Lv 30 + Evolution Shard)──►  Venom Scorpion  ──(Lv 150 + Evolution Crystal + Abyss Stinger)──►  Abyss Scorpion
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Scorpion | Sandy-brown voxel, curved tail with bright red tip | — |
| 2 | Venom Scorpion | Darker purple carapace, dripping venom particle from stinger | Death Mark |
| 3 | Abyss Scorpion | Black armored exoskeleton, glowing violet stinger, dark mist trail | Scorpion's Judgment |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 130 | 65 | 20 | 14 | 13 |

**Growth / Lv:** +7 HP · +3 Sta · +3 ATK · +2 DEF · +1 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Pincer Snap | Physical | 10 | ×1.2 | 35% Armor Break on target (DEF −30%, 2T) |
| ★ | Venom Sting | DOT | 14 | — | Inflicts Poison (−3% max HP/turn, 5T) + 20% Armor Break |
| | Sand Blind | Debuff | 12 | — | Target accuracy −35%, 2T; also 25% SPD −20%, 2T |
| | Death Mark | Debuff | 22 | — | Target takes +40% damage from all sources for 2T; unlocks at Stage 2 |
| | Scorpion Dance | Self-Buff | 18 | — | Own SPD +35% & dodge chance +25%, 2T |
| | Scorpion's Judgment | Dark Elemental | 40 | ×3.5 | Target current Poison DOT ticks are dealt instantly as burst damage, then Poison resets; Stage 3 only |

**Lore Notes:**
- Abyss Stinger drops from Volcano Pit boss (Orc Overlord), 11% drop rate
- `Scorpion's Judgment` has a unique mechanic: it requires the target to already have Poison active to deal bonus damage; dev must implement a target-state check at cast time
- Death Mark + Scorpion's Judgment + Venom Sting is the primary damage combo — high skill ceiling, strong PvP threat at Abyss Scorpion tier

---

## 011 · Eagle `Rare`

**Natural Affinity:** Wind-lean
**Stat Build:** Speed
**Habitat:** Open mountain peaks and windswept cliffs — `zone_mountain`, `zone_volcano`
**Behaviour:** Predatory. Circles overhead at high altitude before diving on any player that stands still for 3+ seconds. Will not pursue below a certain altitude (cannot follow into caves).

> *"The Eagle does not look at the ground the way other beasts do. It looks at it the way a hunter looks at a map."*

**Evolution Chain:**
```
Eagle  ──(Lv 50 + Evolution Shard)──►  War Eagle  ──(Lv 200 + Evolution Crystal + Skystone Feather)──►  Sky Emperor
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Eagle | Brown-white voxel, sharp yellow beak, talons visible on ground stance | — |
| 2 | War Eagle | Larger wingspan, armored chest plate, battle-worn markings, wind trail on wings | Storm Ride |
| 3 | Sky Emperor | Silver-white plumage, golden crown crest, radiant wind aura, contrail particle | Sky Domination |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 140 | 90 | 26 | 15 | 26 |

**Growth / Lv:** +10 HP · +4 Sta · +4 ATK · +2 DEF · +3 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Talon Dive | Physical | 14 | ×1.8 | Always goes first on the turn used regardless of SPD (same rule as Tiger's Pounce) |
| ★ | Eagle Eye | Debuff | 10 | — | Target accuracy −30% & DEF −20%, 2T |
| | Wind Slash | Wind Elemental | 16 | ×1.2 | 35% Shock (SPD −25%, 2T) |
| | Storm Ride | Self-Buff | 20 | — | Own SPD +50%, 2T; next Physical skill ignores 25% DEF; unlocks at Stage 2 |
| | Aerial Assault | Physical | 26 | ×2.5 | Damage +30% for each active SPD buff on self |
| | Sky Domination | Wind Elemental | 42 | ×3.5 | Removes all buffs from target before dealing damage; Stage 3 only |

**Lore Notes:**
- Skystone Feather drops from Dark Forest boss (Elder Treant), 10% drop rate
- Highest base SPD among all Rare tier at Stage 1 — faster than most Epic beasts until mid-level
- Sky Domination's buff-strip effect resolves before damage calculation — dev must apply strip then recalculate target DEF before damage
- Both Eagle `Talon Dive` and Tiger `Pounce` use the same "always-first" mechanic; if both are used in the same turn vs. each other, resolve by raw SPD as tiebreaker

---

## 012 · Bear `Rare`

**Natural Affinity:** Earth-lean
**Stat Build:** Tank
**Habitat:** Thick mountain pine forests and highland caves — `zone_mountain`
**Behaviour:** Territorial. Leaves claw marks on trees as boundary markers. Attacks any player who crosses into its zone. Retreats to cave at 20% HP to hibernate (auto-flee with 100% success rate at that threshold).

> *"The Bear is not angry. It is simply very clear about what is, and is not, its forest."*

**Evolution Chain:**
```
Bear  ──(Lv 50 + Evolution Shard)──►  Grizzly  ──(Lv 200 + Evolution Crystal + Primal Fur Clump)──►  Ancient Bear
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Bear | Brown blocky voxel, rounded ears, lumbering idle | — |
| 2 | Grizzly | Larger, silver-tipped fur, battle scars, heavier stance | Thick Hide |
| 3 | Ancient Bear | Massive, dark-brown with stone-like fur texture, glowing amber eyes, earth particle trail | Ancient Wrath |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 220 | 75 | 20 | 30 | 10 |

**Growth / Lv:** +10 HP · +4 Sta · +4 ATK · +3 DEF · +1 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Maul | Physical | 15 | ×1.8 | 30% Armor Break (DEF −30%, 2T) |
| ★ | Intimidate | Debuff | 10 | — | Target ATK −35% & 20% chance to skip target's next turn (fear) |
| | Bear Hug | Physical | 22 | ×1.2 | 50% Bind (skip target's next turn); lower power compensates high CC |
| | Thick Hide | Self-Buff | 20 | — | Own DEF +50% & Regen +5% max HP/turn, 3T; unlocks at Stage 2 |
| | Ground Slam | Earth Elemental | 28 | ×2.5 | 40% Shock (SPD −25%, 2T) + minor Armor Break (DEF −15%, 1T) |
| | Ancient Wrath | Physical | 40 | ×3.5 | Damage scales with own DEF: adds 10% of own DEF as flat bonus damage; Stage 3 only |

**Lore Notes:**
- Highest base DEF among all Rare-tier beasts at Stage 1 (30 vs tier baseline of 19)
- Primal Fur Clump drops from Mountain Ruins boss (Lich King), 13% drop rate
- `Ancient Wrath` creating a DEF-scaled damage bonus makes Ancient Bear a unique off-tank attacker — the higher the DEF investment, the harder it hits; balance requires damage cap (suggest: DEF bonus capped at +200 flat)
- Bear's combat-flee at 20% HP is a **world behaviour only** — in battle it does not flee; it fights until KO

---

## 013 · Cerberus `Epic`

**Natural Affinity:** Dark-lean
**Stat Build:** Offensive
**Habitat:** The outermost ring of the Abyss, near dungeon entry gates — `zone_abyss`
**Behaviour:** Aggressive. Circles its patrol route constantly. Three heads look in different directions simultaneously — no blind spot; cannot be ambushed. Charges on sight with all three heads growling.

> *"Three heads, one grudge. No one who has met the Cerberus has been in a position to argue about which head bit them first."*

**Evolution Chain:**
```
Cerberus  ──(Lv 75 + Evolution Shard)──►  Hell Cerberus  ──(Lv 300 + Evolution Crystal + Hellgate Key)──►  Gate Guardian
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Cerberus | Large three-headed black dog, red collar on each neck, ember eyes | — |
| 2 | Hell Cerberus | Larger, flame mane on all three heads, cracked-rock skin texture, fire particle | Death Howl |
| 3 | Gate Guardian | Enormous, obsidian-armored, chains dragging behind it, infernal aura, all eyes glow white | Final Judgment |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 195 | 110 | 45 | 20 | 27 |

**Growth / Lv:** +14 HP · +6 Sta · +6 ATK · +4 DEF · +2 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Triple Bite | Physical | 18 | — | Hits 3× at ×0.8 each; each hit independently rolls 25% Bleed (DOT, 3T) |
| ★ | Hellfire Breath | Fire Elemental | 15 | ×1.2 | 40% Burn (−5% max HP/turn, 3T) |
| | Chain Pull | Debuff | 20 | — | Forces target to attack Cerberus next turn (Taunt); removes target SPD buffs |
| | Death Howl | Debuff | 25 | — | Target all stats −20%, 3T; also inflicts 30% fear (skip next turn); unlocks at Stage 2 |
| | Underworld Strike | Dark Elemental | 32 | ×2.5 | Damage bypasses 20% of target DEF; 35% Blind |
| | Final Judgment | Dark Elemental | 44 | ×3.5 | If target HP < 30%, deals double total damage; Stage 3 only |

**Lore Notes:**
- Hellgate Key drops from Abyss Rift boss (Abyssal Demon Lord), 8% drop rate — one of the rarest Stage 3 materials
- `Final Judgment` execute mechanic: resolve HP check before damage roll; if target is at exactly 30% HP boundary, include (i.e., use `<=`)
- Triple Bite hitting 3× with independent Bleed rolls makes Bleed management critical — a target can have overlapping Bleed DOTs; dev must decide if Bleed stacks or refreshes (recommended: refresh, not stack)
- Cerberus cannot be obtained before `zone_abyss` unlock; no Pet Shop availability at launch

---

## 014 · Unicorn `Epic`

**Natural Affinity:** Light-lean
**Stat Build:** Defensive
**Habitat:** A hidden sacred glade deep in the Volcano zone, accessible only after clearing zone_mountain — `zone_volcano` (rare static spawn, one per server)
**Behaviour:** Passive. Never initiates combat. If attacked, it does not flee — it faces the attacker and raises its horn in warning. Attacks only to protect itself, using heal skills first.

> *"The Unicorn does not need to prove it is powerful. That is, in itself, proof."*

**Evolution Chain:**
```
Unicorn  ──(Lv 75 + Evolution Shard)──►  Dark Unicorn  ──(Lv 300 + Evolution Crystal + Moonveil Horn)──►  Celestial Unicorn
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Unicorn | White voxel horse, single silver horn, soft glow particle | — |
| 2 | Dark Unicorn | Sleek black coat, purple-silver horn, crescent moon mark on flank, dark shimmer aura | Lunar Charge |
| 3 | Celestial Unicorn | Translucent white-gold body, rainbow aurora trail from horn tip, ethereal hooves | Celestial Blessing |

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 260 | 110 | 28 | 35 | 17 |

**Growth / Lv:** +14 HP · +6 Sta · +6 ATK · +4 DEF · +2 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Horn Strike | Physical | 15 | ×1.8 | Precise pierce; 20% chance to remove one active buff from target |
| ★ | Holy Light | Heal | 12 | — | Restores 20% of own max HP; also cures one random active debuff |
| | Purify | Self-Buff | 18 | — | Removes ALL active debuffs on self; own DEF +20%, 2T |
| | Divine Shield | Self-Buff | 25 | — | Own DEF +60% & immune to all status effects, 2T; unlocks at Stage 2 — wait: actually the second unlock is Lunar Charge |
| | Lunar Charge | Light Elemental | 28 | ×2.5 | Damage heals self for 30% of damage dealt (lifesteal); unlocks at Stage 2 |
| | Celestial Blessing | Light Elemental | 42 | ×3.5 | Heals self for 40% max HP AND deals damage simultaneously; Stage 3 only |

**Lore Notes:**
- One Unicorn spawns per server in a fixed location in `zone_volcano`; respawns 30 minutes after capture or defeat
- Moonveil Horn drops from Abyss Rift boss (Abyssal Demon Lord), 10% drop rate
- `Celestial Blessing` dealing damage and healing simultaneously requires two separate resolution passes in `BattleService` — damage first, then heal (heal cannot exceed max HP)
- Unicorn's passive buff-strip on `Horn Strike` is the only skill in Epic tier with this property outside of Eagle's `Sky Domination`
- Social value: Celestial Unicorn's rainbow aurora trail is one of the most visually distinct effects in the game

---

## 015 · Phoenix `Legendary`

**Natural Affinity:** Fire-lean
**Stat Build:** Offensive
**Habitat:** Volcanic calderas and lava-crested summits — `zone_abyss` (rare spawn); also obtainable via seasonal events
**Behaviour:** Aggressive. Circles in high-altitude thermals invisibly until the player enters its caldera. Descends in a flaming dive with no warning. Cannot be fled from once engaged.

> *"The Phoenix has died more times than any creature alive. This has not made it cautious. If anything, it has made it bored."*

**Evolution Chain:**
```
Phoenix Chick  ──(Lv 100 + Evolution Shard)──►  Phoenix  ──(Lv 500 + Evolution Crystal + Eternal Ember)──►  Inferno Phoenix
```

| Stage | Name | Model Change | New Skill Unlocked |
|---|---|---|---|
| 1 | Phoenix Chick | Small, fluffy orange-red voxel chick, tiny flame sparks at wing tips | — |
| 2 | Phoenix | Full-size fiery bird, flame wings, glowing tail feathers, heat-shimmer aura | Ash Storm |
| 3 | Inferno Phoenix | Enormous, solar-gold and deep-crimson, wings leave fire trails, rebirth glow effect on low HP | Phoenix Rebirth |

**Passive — Rebirth:** Once per battle, when this pet is reduced to 0 HP, it automatically revives with 30% of its max HP. The revive triggers before KO is confirmed. Cooldown resets between battles. Visual: burst of golden flame on the turn it triggers.

**Base Stats (Lv 1):**
| HP | Stamina | ATK | DEF | SPD |
|---|---|---|---|---|
| 265 | 150 | 65 | 28 | 37 |

**Growth / Lv:** +20 HP · +9 Sta · +9 ATK · +6 DEF · +3 SPD

**Skill Pool:**
| | Skill | Type | SP | Power | Effect |
|---|---|---|---|---|---|
| ★ | Fire Talon | Physical | 15 | ×1.8 | 35% Burn (−5% max HP/turn, 3T) |
| ★ | Rising Flame | Fire Elemental | 12 | ×1.2 | Damage +20% for each Burn DOT currently active on the target |
| | Rebirth Pulse | Heal | 20 | — | Restores 25% own max HP + removes all debuffs on self |
| | Ash Storm | Fire Elemental | 28 | ×2.5 | 60% Burn on target; also reduces target SPD −20%, 2T; unlocks at Stage 2 |
| | Solar Flare | Fire Elemental | 35 | ×3.0 | Ignores elemental resistance (similar to Dragon's Ancient Fury but at ×3.0, not ×3.5) |
| | Phoenix Rebirth | Fire Elemental | 45 | ×3.5 | If Rebirth passive has already triggered this battle, this skill deals +100% bonus damage; Stage 3 only |

**Lore Notes:**
- Eternal Ember drops from Abyss Rift boss (Abyssal Demon Lord), 5% drop rate — second rarest Stage 3 material after Dragon Heart
- Rebirth passive is implemented as a battle flag `PhoenixRebirthUsed` on the PetBattleState object; reset on battle end; check in `CHECK_END` state before confirming KO
- `Phoenix Rebirth` damage bonus requires checking `PhoenixRebirthUsed == true` at cast time — if Rebirth hasn't triggered yet, skill deals normal ×3.5 with no bonus
- `Rising Flame` scaling with active Burn stacks requires reading the target's active status effect list at cast time; dev must sum all Burn instances (refreshed or new) as one count — recommend treating any active Burn as +20% regardless of stack count
- Highest base ATK and SPD of all Legendary beasts at Stage 1 — trades HP and DEF for pure offense; Rebirth compensates for fragility
