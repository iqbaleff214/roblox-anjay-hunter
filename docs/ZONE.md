# ZONE — Anjay Hunter Zone Glossary

**Version:** 1.0
**Status:** In Progress
**Last Updated:** 2026-05-08

---

## Overview

The game world is divided into **six zones**, five of which are open-world hunting areas and one of which is the social/commercial Hub. Zones are contiguous regions connected by zone portals. Players move freely between zones but wild beasts in higher zones will overwhelm under-levelled pets through raw damage calculation — there is no hard level block for exploration, only for dungeon entry.

| Zone ID | Zone Name | Level Range | Beast Rarity | Dungeon(s) | Status |
|---|---|---|---|---|---|
| `zone_starter` | Starter Plains | 1–20 | Common | None | Starting zone |
| `zone_forest` | Forest | 21–100 | Common, Uncommon | Forest Cave | First progression zone |
| `zone_mountain` | Mountain | 101–300 | Uncommon, Rare | Mountain Ruins, Dark Forest | Mid-game |
| `zone_volcano` | Volcano | 301–600 | Rare, Epic | Volcano Pit | Late-game |
| `zone_abyss` | Abyss | 601–1000 | Epic, Legendary | Abyss Rift | Endgame |
| `zone_hub` | Town / Hub | — | None | None | Social/commercial |

---

## Zone Navigation & Travel

### World Structure

The game world is a single connected open map rendered in voxel/block art style. Zones are separated by visible environmental transitions (treeline, mountain pass, volcanic ridge, void rift) and marked by **Zone Portals** — large voxel archways that display the destination zone name and recommended level.

### Zone Portals

| From | To | Portal Type | Recommended Level |
|---|---|---|---|
| Starter Plains | Forest | Forest Gate | 20+ |
| Forest | Mountain | Mountain Pass | 100+ |
| Mountain | Volcano | Volcanic Ridge | 300+ |
| Volcano | Abyss | Void Rift | 600+ |
| Any Zone | Hub | Town Portal (fast travel pad) | No requirement |
| Hub | Any Zone | Zone Portal (hub side) | No requirement |

- **Town Portals** appear in every zone (one per zone); teleport instantly to Hub
- **Hub zone portals** allow direct travel to any zone the player has previously visited
- Zone portals are cosmetically distinct per destination — Forest Gate is made of wood, Mountain Pass is carved stone, Void Rift crackles with purple energy
- No currency cost to travel through any portal

### Soft vs Hard Gates

| Gate Type | Mechanism | Enforced By |
|---|---|---|
| **Soft gate** (wild overworld) | Low-level pets take massive damage from high-zone wild beasts | Battle damage formula |
| **Hard gate** (dungeon entry) | Server rejects entry if average active pet level < dungeon minimum | `DungeonService:ValidateEntry()` |

**Dungeon minimum level requirements:**

| Dungeon | Minimum Average Pet Level |
|---|---|
| Forest Cave | 15 |
| Mountain Ruins | 75 |
| Dark Forest | 75 |
| Volcano Pit | 250 |
| Abyss Rift | 550 |

---

## Wild Encounter System

### Encounter Trigger

Wild beasts roam the zone overworld as visible voxel entities. Players can:
1. **Walk into** a wild beast to initiate battle (aggressive approach)
2. **Interact** with a peacefully-wandering beast by pressing the interact key (stealth approach)

Both methods deduct **10 Hunt Energy** on battle initiation, server-side before battle state changes to `INIT`.

### Rarity Spawn Weights per Zone

| Zone | Common | Uncommon | Rare | Epic | Legendary |
|---|---|---|---|---|---|
| Starter Plains | 90% | 10% | 0% | 0% | 0% |
| Forest | 60% | 35% | 5% | 0% | 0% |
| Mountain | 25% | 50% | 25% | 0% | 0% |
| Volcano | 5% | 15% | 50% | 28% | 2% |
| Abyss | 0% | 15% | 40% | 40% | 5% |

*Weights modified by Beast Lure item (+50% Uncommon weight, +100% Rare weight, +50% Epic weight)*
*Weights modified by active Weather events (see Weather System section)*

### Wild Beast Battle Rewards

| Reward | Formula | Notes |
|---|---|---|
| Silver | `beast_level × 2` | Always granted on battle victory |
| Gold | None | Wild battles do not yield Gold |
| XP (pet) | `beast_level × 30` | Split across all pets used |
| Item drop | Species-specific table (2–10%) | See ITEM.md for species drop tables |
| Capture attempt | Available if HP < 50% | Consumes 1 Trap; see GDD §8.4 |

---

## Weather System

Weather is a **server-wide zone condition** that cycles randomly. Each zone has its own independent weather state. Weather duration is 15–45 minutes, then rolls a new condition.

### Weather Types

| Weather | Zones | Effect on Spawns | Effect on Battle |
|---|---|---|---|
| **Clear** | All | Normal spawn weights | None |
| **Rain** | Forest, Starter Plains | Water-element beasts +15% spawn weight | Beast Lure duration +10 min |
| **Storm** | Forest, Mountain, Abyss | Electric-element beasts +20% spawn weight; Thunderbird world event trigger (Abyss only) | None |
| **Fog** | Mountain, Dark Forest area | Ghost/Specter-type beasts +20% spawn weight | None |
| **Blizzard** | Mountain | Ice-element beasts +25% spawn weight | None |
| **Heat Wave** | Volcano | Fire-element beasts +20% spawn weight; Phoenix encounter enabled | None |
| **Void Mist** | Abyss | Permanent ambient condition; Dark-element beasts always +10% weight | None |

### Weather Display

- Weather state shown in top-right HUD icon with zone name
- Zone portals display active destination weather before entry
- Weather sound effects play per zone
- Client-side particle effects (rain, fog, ash, lightning flashes) match weather type

### Weather Service

```lua
-- WeatherService rolls new weather every 15–45 minutes per zone
-- Fires RemoteEvent "WeatherChange" to all clients in zone
local ZONE_WEATHER_POOLS = {
    zone_starter  = { Clear=60, Rain=30, Fog=10 },
    zone_forest   = { Clear=45, Rain=35, Fog=10, Storm=10 },
    zone_mountain = { Clear=40, Fog=25, Blizzard=20, Storm=15 },
    zone_volcano  = { Clear=45, HeatWave=45, Storm=10 },
    zone_abyss    = { VoidMist=100 },  -- permanent; sub-conditions layered on top
}
```

---

## Zone Progression Summary

```
Starter Plains (Lv1–20)
  │  Tutorial, first captures, Elder Maris trainer
  ▼
Forest (Lv21–100)
  │  Forest Cave Dungeon → Goblin Warchief boss
  │  Forest Warden Tobias trainer
  ▼
Mountain (Lv101–300)
  │  Mountain Ruins Dungeon → Lich King boss
  │  Dark Forest Dungeon → Elder Treant boss
  │  Knight Commander Vessa trainer
  ▼
Volcano (Lv301–600)
  │  Volcano Pit Dungeon → Orc Overlord boss
  │  Flamecaller Grimtusk trainer
  ▼
Abyss (Lv601–1000)
  │  Abyss Rift Dungeon → Abyssal Demon Lord boss
  │  Void Seeker Nyx trainer
  ▼
Hub (Zone-agnostic)
  └─ All shops, Bounty Board, Arena, Guild Hall, Hall of Fame
```

---

## Detailed Zone Entries

---

### [001] Starter Plains

| Field | Value |
|---|---|
| **Zone ID** | `zone_starter` |
| **Zone Name** | Starter Plains |
| **Biome** | Open grassland with gentle hills; rolling terrain; daytime ambient |
| **Level Range** | 1–20 |
| **Access** | Starting zone; no requirement |
| **Size** | Medium — large enough for 20 simultaneous players without crowding |
| **Wild Beast Level Range** | 1–20 |
| **Rarity Distribution** | Common 90%, Uncommon 10% |
| **Hunt Energy per Encounter** | 10 |
| **Dungeons** | None |
| **Weather** | Clear (default, 60%), Rain (30%), Fog (10%) |
| **NPC Trainers** | Elder Maris (Tutorial/Trainer, always available, no cooldown) |
| **Wild Beast Encounter Rate** | High (densely populated; designed for active play) |

**Wild Beast Roster:**

| Species | Rarity | Element(s) | Notes |
|---|---|---|---|
| Dog | Common | Varies | Starter species; Dog → Wolf → Dire Wolf evolution line |
| Cat | Common | Varies | Starter species; agile, high SPD base |
| Pig | Common | Earth | Starter species; HP-focused |
| Horse | Common | Light / Wind | Cavalry Charge always-first skill at Stage 2 |
| Rabbit | Common | Wind | High SPD; easy first capture |
| Slime | Common | Water | Easy capture; Forest Cave also has Slime as dungeon monster |
| Duck | Common | Water / Wind | Starter Plains water areas (ponds) |
| Goat | Common | Earth | Stubborn Stance; immune to Taunt skill |

**Special Spawns:** None. Static, stable encounter pool. No weather-triggered rare spawns.

**Zone Features:**
- Tutorial Area with interactive voxel signs near spawn point
- Elder Maris's cabin near zone centre — first NPC interaction triggers tutorial battle
- Pet corral near Elder Maris — first pet can be observed walking alongside player here
- Flat open terrain — clear sight lines for spotting wild beasts before engagement
- Pond areas (south of zone) — Duck and Slime concentrate near water tiles

**NPC Interactions:**
- **Elder Maris** (NPC 001): Tutorial trainer; Dog Lv8 + Cat Lv10; one-time Trap reward; always available (no 24h cooldown); `tutorial_maris_defeated` flag tracks first completion

**Zone Rewards:**
| Reward Source | Yield |
|---|---|
| Wild beast Silver | Level × 2 (avg 2–40 Silver per fight) |
| Elder Maris win | 50–150 Silver + 5× Basic Trap (first time) |
| Wild beast item drop | HP Potion Small (8%), Basic Trap (10%) |

**Progression Gate:** After defeating Elder Maris and capturing at least 1 pet, players are guided to the Forest Gate portal. No hard block on leaving.

**Lore:** *"The Starter Plains sit at the edge of the Hunter's Hub, close enough that new arrivals can see the town lights from the hilltop. Beasts here are small, friendly enough to be caught by hand (if not always by trap), and quick to understand that a trainer with a Basic Trap means business. Elder Maris has stood at the same spot for thirty years. She is the first face every hunter sees. She has defeated every one of them at least once."*

**Art Direction:**
- Bright palette; vivid greens and yellows
- Low-poly rolling grass with scattered flowers (voxel flowers)
- Wooden fences demarcating Elder Maris's property
- Clear sky with large rounded clouds
- Ambient wildlife sounds (birds, wind, distant animal calls)

**Dev Notes:**
- Zone ID: `zone_starter`
- Wild beast spawn density: highest in game (1 beast per ~15 tiles); intended for tutorial engagement
- Beast spawn height: only flat tile placement; no aerial spawns (Sparrow/Hawk appear in Forest+)
- Energy refill not required here — players arrive at 100 energy; 10 encounters possible before drain
- `BeastSpawnService` uses `zone_starter` weight table; rain weather applies +15% Water weight but Starter Plains has limited Water species (only Duck, Slime) so visual effect is modest

---

### [002] Forest

| Field | Value |
|---|---|
| **Zone ID** | `zone_forest` |
| **Zone Name** | Forest |
| **Biome** | Dense temperate forest; tall voxel trees; canopy shadow; streams and clearings |
| **Level Range** | 21–100 |
| **Access** | Through Forest Gate portal from Starter Plains (recommended Level 20+) |
| **Size** | Large — multiple sub-regions (deep forest, stream valley, dungeon cave entrance) |
| **Wild Beast Level Range** | 21–100 |
| **Rarity Distribution** | Common 60%, Uncommon 35%, Rare 5% |
| **Hunt Energy per Encounter** | 10 |
| **Dungeons** | Forest Cave (`dungeon_forest`) — Level 21+ required |
| **Weather** | Clear (45%), Rain (35%), Fog (10%), Storm (10%) |
| **NPC Trainers** | Forest Warden Tobias (Trainer, 24h cooldown) |
| **Wild Beast Encounter Rate** | High |

**Wild Beast Roster:**

| Species | Rarity | Element(s) | Notes |
|---|---|---|---|
| Goblin | Common | Nature | Capturable; also appears in Forest Cave dungeon |
| Fox | Common | Fire / Nature | Trickster Fox Stage 2 drops Fox Spirit Bead (8%) |
| Sparrow | Common | Wind | Low HP; Feather Veil reflects Blind |
| Frog | Common | Water | Rain Dance + Acid Skin combo |
| Hedgehog | Common | Earth | Iron Quill Strike uses DEF as ATK supplement |
| Beaver | Common | Water / Earth | Grand Levee self-modifier (uncleansable) |
| Parrot | Common | Wind | Mimicry passive — copies last used skill |
| Wolf | Uncommon | Dark | Pack Leader passive — kill blow stacks +15% ATK |
| Wolverine | Uncommon | Nature | Undying Grit — survive at 1HP once per battle |
| Koi | Uncommon | Water | Fortune Scales — 20% random heal/damage/cleanse per turn |
| Hawk | Uncommon | Wind | Aerial Predator — turn 1 priority override |
| Eagle | Rare | Wind / Nature | War Eagle Stage 2 drops Tempest Quill (8%) |

**Special Spawns:**
- **Nocturnal beasts** (Bat, Wolverine): increased spawn rate during night cycle (server-side day/night toggles every 30 minutes)
- **Storm weather**: Electric-type beasts +20% spawn weight — Hawk more common; rare Storm-type variant encounters possible

**Zone Features:**
- Forest Cave dungeon entrance (large hollow in the cliff face, north of zone)
- Stream network running east-west through the zone (Water-type beasts concentrate near streams)
- Clearings used as open combat arenas for NPC Tobias battle
- Forest Warden Tobias patrols the central clearing
- Dense canopy in north sector reduces visible distance to beasts (encounter range shorter)

**NPC Interactions:**
- **Forest Warden Tobias** (NPC 002): Fox Lv50 → Eagle Lv55 → Wolf Lv60 (all Stage 1); 200–500 Silver reward; scripted order

**Zone Rewards:**
| Reward Source | Yield |
|---|---|
| Wild beast Silver | Level × 2 (avg 42–200 Silver per fight) |
| Tobias win | 200–500 Silver |
| Dungeon boss Silver | boss_level(77) × 50 = 3,850 Silver |
| Dungeon boss Gold | 10–20 Gold |
| Dungeon boss drop | Evolution Shard (60%), Void Slime Core (Forest Cave first clear guarantee), Goblin War Crown (15%), Goblin Chief's Trophy (40%), Legend Trap (5%) |

**Dungeon: Forest Cave**

| Property | Value |
|---|---|
| Dungeon ID | `dungeon_forest` |
| Entry Level | 21+ |
| Boss | Goblin Warchief (Lv77) |
| Waves | 7 monster waves + boss wave |
| Entry Level Step | +8 per wave |
| Wave Level Range | Wave 1: Lv21 → Wave 7: Lv69 → Boss: Lv77 |
| Daily Run Limit | 3 runs (resets midnight UTC) |
| Energy Cost | 25 Hunt Energy |
| Notable Capturable | Slime (Common), Goblin (Common) — Iron Trap minimum |
| Rare Monsters | Hobgoblin (Lv45–69, waves 4–7), Giant Bat (waves 4–7) |

**Lore:** *"The Forest stretches further than anyone has mapped. Hunters who venture past the third stream marker find beasts they've never catalogued — and not all of them are small. The Forest Cave was discovered by a Goblin tribe that had lived there for generations before the first hunter pushed through the undergrowth and found their torchlit halls. The tribe is still there. So are the hunters. It's a complicated arrangement."*

**Art Direction:**
- Dense tall-tree canopy blocks direct light; dappled lighting on the forest floor
- Stream tiles shimmer with water animation
- Underground dungeon entrance framed by large glowing mushrooms (lore: Goblin lighting)
- Nocturnal shift: ambient light dims; fireflies appear as particle effects
- Rich mid-green with brown and yellow forest floor tiles

**Dev Notes:**
- Zone ID: `zone_forest`
- `BeastSpawnService` handles day/night toggle every 1800 seconds (30 min game-time)
- Nocturnal spawn pool adds: Bat (Uncommon), Wolverine +15% weight
- Forest Cave entry via `DungeonService:ValidateEntry()` — checks `avg_active_pet_level >= 15` and `PlayerData.HuntEnergy >= 25`
- Goblin War Crown: only boss 15% drop; no field drop path in Forest (unlike Treant Heartwood which has a field drop from Treant monster)

---

### [003] Mountain

| Field | Value |
|---|---|
| **Zone ID** | `zone_mountain` |
| **Zone Name** | Mountain |
| **Biome** | High-altitude rocky mountains; snow-capped peaks; ruins of an ancient civilisation; dark forest region to the northeast |
| **Level Range** | 101–300 |
| **Access** | Through Mountain Pass portal from Forest (recommended Level 100+) |
| **Size** | Extra-Large — largest hunting zone; divided into sub-regions (mountain slopes, ruins plateau, dark forest northeast, frost peaks northwest) |
| **Wild Beast Level Range** | 101–300 |
| **Rarity Distribution** | Common 25%, Uncommon 50%, Rare 25% |
| **Hunt Energy per Encounter** | 10 |
| **Dungeons** | Mountain Ruins (`dungeon_mountain`), Dark Forest (`dungeon_darkforest`) — both Level 75+ required |
| **Weather** | Clear (40%), Fog (25%), Blizzard (20%), Storm (15%) |
| **NPC Trainers** | Knight Commander Vessa (Trainer, Mountain plateau, 24h cooldown) |
| **Wild Beast Encounter Rate** | Medium (larger zone; beasts more spread out) |

**Wild Beast Roster:**

| Species | Rarity | Element(s) | Notes |
|---|---|---|---|
| Skeleton | Uncommon | — / Dark | Wild variant; Stage 2+ drops Lich's Phylactery (8%) |
| Ghost | Uncommon | Dark | Incorporeal — 30% dodge vs Physical only |
| Bat | Uncommon | Dark / Wind | Echolocation passive suppresses dodge; Screech 35% Blind |
| Wolf | Uncommon | Dark | Higher-level wild Wolf (Stage 2 accessible) |
| Tiger | Rare | Light | Stage 2+ White Tiger drops Shadow Fang (8%) |
| Lion | Rare | Light | Stage 2+ Battle Lion drops King's Mane Lock (8%) |
| Bear | Rare | Earth / Light | Heavy hitter; tanky; Mountain zone native |
| Eagle | Rare | Wind / Nature | Stage 2 War Eagle drops Tempest Quill (8%) |
| Turtle | Common | Earth | Armored Turtle Stage 2+ drops Ancient Shell Plate (8%) |
| Gorilla | Rare | Earth | Knuckle Guard 25% counter; Silverback Charge always-first |
| Anaconda | Rare | Water / Dark | Constrictor aura; King Anaconda Stage 2 accessible at high Mountain levels |

**Special Spawns:**
- **Fog weather**: Ghost and Bat spawn rates increase +20%
- **Blizzard weather**: Ice-element beasts +25% spawn weight; movement between areas slowed (client-side only)
- **Storm weather**: Electric-type beasts +20% spawn; rare Thunderbird sighting (first appearance; spawns briefly before Abyss zone access)
- **Dark Forest sub-region** (northeast): Treant, Hostile Fairy, Dark Elf spawn exclusively here — separate from main Mountain spawn pool

**Zone Features:**
- Mountain Ruins dungeon entrance (ancient stone archway in the ruins plateau, central zone)
- Dark Forest dungeon entrance (twisted dark treeline, northeast sub-region — accessible via narrow path)
- Knight Commander Vessa stands at the mountain plateau overlook (dramatic vista point)
- Ruins sub-region: crumbling voxel architecture; columns, broken walls, bonfire remnants
- Frost Peaks (northwest): no wild beasts; blizzard always active here; purely visual/atmospheric

**NPC Interactions:**
- **Knight Commander Vessa** (NPC 003): Tiger Lv150 Stage2 Light → Lion Lv155 Stage2 → Bear Lv160 Stage2 Earth; 500–1,500 Silver reward; Tiger Pounce always-first on turn 1 is a danger indicator

**Zone Rewards:**
| Reward Source | Yield |
|---|---|
| Wild beast Silver | Level × 2 (avg 202–600 Silver per fight) |
| Vessa win | 500–1,500 Silver |
| Mountain Ruins boss Silver | boss_level(269) × 50 = 13,450 Silver |
| Mountain Ruins boss Gold | 25–50 Gold |
| Dark Forest boss Silver | boss_level(269) × 50 = 13,450 Silver |
| Dark Forest boss Gold | 60–120 Gold |
| Boss drops (both dungeons) | Evolution Shard (60%), Evolution Crystal (20%), species material (15%), trophy collectible (40%), Legend Trap (5%) |

**Dungeons: Mountain Ruins & Dark Forest**

| Property | Mountain Ruins | Dark Forest |
|---|---|---|
| Dungeon ID | `dungeon_mountain` | `dungeon_darkforest` |
| Entry Level | 75+ | 75+ |
| Boss | Lich King (Lv269) | Elder Treant (Lv269) |
| Waves | 7 + boss | 7 + boss |
| Wave Level Step | +24 per wave | +24 per wave |
| Wave Range | Lv101–245 → Boss Lv269 | Lv101–245 → Boss Lv269 |
| Daily Run Limit | 3 runs | 3 runs |
| Energy Cost | 25 Hunt Energy | 25 Hunt Energy |
| Boss Species Drop | Lich's Phylactery (15%) | Treant Heartwood (15%) |
| Boss Trophy | Ancient Bone Relic (40%) | Enchanted Bark Rune (40%) |

**Lore:** *"The Mountain has two faces. The ruins on the central plateau were a city once — scholars argue about who built them and why they left; the Lich King appears to remember, but communicating with a Lich King about architectural history is inadvisable. The Dark Forest in the northeast is newer darkness — the trees there grew in wrong directions about three hundred years ago and haven't stopped. Hunters who go in for the first time are warned to bring a Warming Herb. They're also warned not to look at the trees too closely."*

**Art Direction:**
- Rocky grey-brown terrain with snow patches on upper elevations
- Ruins sub-region: warm torch lighting from sconces on broken walls; stone textures
- Dark Forest sub-region: twisted black/dark-purple tree canopy; near-zero ambient light; blue Hostile Fairy glow as the primary light source
- Frost Peaks: pure white voxel snow; blizzard particle effect always active
- Fog weather: thick white mist curtain that reduces sprite visibility distance

**Dev Notes:**
- Zone ID: `zone_mountain`
- Sub-regions split via zone flag: `beast.sub_region = "dark_forest"` for Treant/Fairy spawns; normal Mountain spawn pool for rest
- Two dungeons share the same zone; `DungeonService` distinguishes by `dungeonId` parameter
- Ghost and Bat dodge passives: Ghost (30% Physical dodge), Bat (Echolocation suppresses dodge — including Ghost's) — document interaction in AI behaviour notes for clarity
- Shadow Fang / King's Mane Lock drop from Stage 2+ wild: `BattleService:GrantWildDrops()` checks `wild_beast.stage >= 2` before rolling

---

### [004] Volcano

| Field | Value |
|---|---|
| **Zone ID** | `zone_volcano` |
| **Zone Name** | Volcano |
| **Biome** | Active volcanic landscape; lava rivers, ash plains, obsidian rock formations, battle-worn Orc fortifications |
| **Level Range** | 301–600 |
| **Access** | Through Volcanic Ridge portal from Mountain (recommended Level 300+) |
| **Size** | Large — ashfield open area, fortification ruins, active lava flow channels |
| **Wild Beast Level Range** | 301–600 |
| **Rarity Distribution** | Common 5%, Uncommon 15%, Rare 50%, Epic 28%, Legendary 2% |
| **Hunt Energy per Encounter** | 10 |
| **Dungeons** | Volcano Pit (`dungeon_volcano`) — Level 250+ required |
| **Weather** | Clear (45%), Heat Wave (45%), Storm (10%) |
| **NPC Trainers** | Flamecaller Grimtusk (Trainer, near dungeon entrance, 24h cooldown) |
| **Wild Beast Encounter Rate** | Medium-Low (harsh terrain; beasts are large, spread out) |

**Wild Beast Roster:**

| Species | Rarity | Element(s) | Notes |
|---|---|---|---|
| Orc | Common | Fire / Earth | Low-level wild occurrence; Stage 2+ drops nothing unique (Orc Warbrand Fragment = boss-only) |
| Troll | Uncommon | Earth / Fire | Troll Regeneration 3%/turn; Rock Throw always-first once |
| Gorilla | Rare | Earth / Fire | High-level variant; fire-imbued builds possible |
| Manticore | Rare | Fire | Legendary-adjacent difficulty; Volcanic Spine passive |
| Kitsune | Epic | Fire | Fox Fire mark mechanic; Stage 2 Nine-Tail Kitsune here |
| Werewolf | Epic | Dark | Lunar Rage; Stage 2 Alpha Werewolf accessible |
| Basilisk | Rare | Dark | Petrifying Gaze passive; Abyss Rift also has Basilisk |
| Phoenix | Legendary | Fire | Heat Wave required; rare spawn; first-capture drops Phoenix Ash |
| Anaconda | Rare | Water / Dark | High-level variant from Mountain extends into lower Volcano |

**Special Spawns:**
- **Heat Wave weather**: Phoenix encounter enabled (Phoenix does not appear during other weather conditions in Volcano zone); Fire-element beasts +20% spawn weight
- **Storm weather**: rare Thunderbird precursor sighting event (atmospheric only; Thunderbird itself spawns in Abyss)
- **Phoenix Encounter**: When Heat Wave active, 3% chance per wild encounter roll that the spawned beast is Phoenix instead of standard pool — Phoenix is Legendary rarity so its spawn replaces an Uncommon slot in the weight calculation

**Zone Features:**
- Volcano Pit dungeon entrance (mouth of active volcano caldera; glowing lava visible inside)
- Flamecaller Grimtusk stands on a raised obsidian platform near the dungeon entrance
- Lava river channels divide the ashfield into natural corridors — beasts cluster in cooler rock areas
- Orc fortification ruins (mid-zone): remnants of a destroyed Orc warcamp; large-scale voxel architecture
- Observation overlook (west cliff): shows the full volcanic landscape; used in loading screen art
- Burning tree border (east): transition area from Mountain Dark Forest zone; marks zone boundary

**NPC Interactions:**
- **Flamecaller Grimtusk** (NPC 004): Manticore Lv400 Stage2 Fire → Gorilla Lv410 Stage2 Fire → Phoenix Lv420 Stage1 Fire (natural, not heat-wave special); 2,000–5,000 Silver + 1–5 Gold reward
- Phoenix in Grimtusk's team has Rebirth passive active — bring a follow-up skill for the second KO

**Zone Rewards:**
| Reward Source | Yield |
|---|---|
| Wild beast Silver | Level × 2 (avg 602–1,200 Silver per fight) |
| Grimtusk win | 2,000–5,000 Silver + 1–5 Gold |
| Volcano Pit boss Silver | boss_level(637) × 50 = 31,850 Silver |
| Volcano Pit boss Gold | 150–300 Gold |
| Boss drops | Evolution Shard (60%), Evolution Crystal (20%), Orc Warbrand Fragment (15%), Volcanic Forge Shard (40%), Legend Trap (5%) |

**Dungeon: Volcano Pit**

| Property | Value |
|---|---|
| Dungeon ID | `dungeon_volcano` |
| Entry Level | 250+ |
| Boss | Orc Overlord (Lv637) |
| Waves | 7 + boss |
| Wave Level Step | +48 per wave |
| Wave Range | Lv301–589 → Boss Lv637 |
| Daily Run Limit | 3 runs |
| Energy Cost | 25 Hunt Energy |
| Boss Species Drop | Orc Warbrand Fragment (15%), Phoenix Ash (3% rare bonus) |
| Boss Trophy | Volcanic Forge Shard (40%) |
| Notable Monsters | Fire Orc (Rare, waves 4–7), Ogre (Rare, waves 4–7), Lava Slime |
| Boss Phases | 3 phases: ≤60% Warlord's Rage ATK+25%; ≤30% Feral Instinct SPD+25% |

**Lore:** *"The Volcano was not always erupting. Accounts from a hundred and fifty years ago describe it as dormant, covered in a sparse grey scrub that local Orc clans used for grazing. Then the Orc Overlord declared himself king, built his fortress in the caldera lip, and ordered ritual fires lit in the mountain's name. The mountain answered. The Orc fortifications are ruins now. The Overlord remains. Some elements of that original agreement appear to be still in force."*

**Art Direction:**
- Black and deep red palette; orange glow from lava channels
- Ash-grey flat terrain for open areas; obsidian cliff faces
- Orc ruin structures: large-scale blocky voxel fortifications, collapsed towers, scattered war banners
- Phoenix encounter: blinding white-gold particle burst on spawn; Heat Wave shimmer effect on terrain
- Lava river tiles: animated orange glow; no collision (death zone if walked into — cosmetic/environmental only, no gameplay death in overworld)

**Dev Notes:**
- Zone ID: `zone_volcano`
- Phoenix spawn gate: `if CurrentWeather["zone_volcano"] == "HeatWave" then allow_phoenix_roll = true end`
- Grimtusk Phoenix (NPC team): `species_id = "phoenix"`, element = "Fire", stage = 1 — same as wild Phoenix but NPC-owned; Phoenix Ash does NOT drop from NPC battles, only wild encounters
- Volcano Pit entry gate: `avg_active_pet_level >= 250` — strictest level gate before Abyss
- Lava river cosmetic tiles: client-side visual only; no `OnTouched` damage event

---

### [005] Abyss

| Field | Value |
|---|---|
| **Zone ID** | `zone_abyss` |
| **Zone Name** | Abyss |
| **Biome** | Shattered void landscape; floating rock platforms above an endless dark pit; purple-black sky; corrupted ruins; permanent Void Mist |
| **Level Range** | 601–1000 |
| **Access** | Through Void Rift portal from Volcano (recommended Level 600+) |
| **Size** | Medium — compact but vertically dramatic; platform-based terrain |
| **Wild Beast Level Range** | 601–1000 |
| **Rarity Distribution** | Uncommon 15%, Rare 40%, Epic 40%, Legendary 5% |
| **Hunt Energy per Encounter** | 10 |
| **Dungeons** | Abyss Rift (`dungeon_abyss`) — Level 550+ required |
| **Weather** | Void Mist (permanent ambient, always active), Storm (30% overlay — adds to Void Mist), Darkness (20% overlay — deep Void Mist, visibility near-zero) |
| **NPC Trainers** | Void Seeker Nyx (Trainer, Abyss platform central node, 24h cooldown) |
| **Wild Beast Encounter Rate** | Low (extreme terrain; beasts are endgame-level, spaced far apart) |

**Wild Beast Roster:**

| Species | Rarity | Element(s) | Notes |
|---|---|---|---|
| Kitsune | Epic | Fire / Dark | Stage 2–3 accessible; Spirit Orb from Abyss boss |
| Werewolf | Epic | Dark | Stage 2–3 accessible; Blood Moon Stone from Abyss boss |
| Basilisk | Rare | Dark | Petrified Eye from Abyss boss; Gorgon Stage 3 endgame |
| Anaconda | Rare | Water / Dark | King Anaconda Stage 2+; Anaconda Venom Gem (8%) drop |
| Dragon | Legendary | Fire / any | Rare spawn; first capture grants Dragon Scale; 10% drop on fight victory |
| Thunderbird | Legendary | Wind / Electric | Storm weather required; 10% drop on fight victory; Storm weather only |
| Phoenix | Legendary | Fire | No weather gate in Abyss (unlike Volcano); 10% drop on fight victory |
| Specter | Uncommon | Dark | Ethereal Form — 30% dodge vs Physical AND Elemental (both) |
| Dark Troll | Rare | Dark | Dark Regeneration 4%/turn; hardest non-boss enemy in game |

**Special Spawns:**
- **Storm weather overlay**: Thunderbird enabled (does NOT spawn without Storm); also triggers **Sky Sovereign world event** (see below)
- **Darkness overlay**: Specter spawn rate +40%; Void Shard drop rate doubles (6% from 3%)
- **Dragon encounter**: 2% base chance per roll regardless of weather; boosted to 4% during Storm
- **Sky Sovereign World Event** (Storm only): When a player owns a Stage 2+ Thunderbird in active roster AND Storm weather is active in Abyss → 1% chance per wild encounter that a Sky Sovereign (Stage 3 Thunderbird NPC) appears as a challenge encounter. Win → 5% Storm Feather drop.

**Sky Sovereign World Event Details:**

| Property | Value |
|---|---|
| Trigger | Player has Stage 2+ Thunderbird + Abyss Storm weather active |
| Spawn rate | 1% per wild encounter check while condition met |
| Encounter type | Scripted boss-tier wild battle (not a dungeon) |
| Sky Sovereign level | `player's Thunderbird level + 20` (scales with player) |
| Win reward | 5% Storm Feather drop; `sky_sovereign_level × 50` Silver; no XP |
| Capture | Not capturable (stage 3 NPC-tier entity) |
| Cooldown | 2 hours per player (cannot re-trigger for 2h after any outcome) |

**Zone Features:**
- Abyss Rift dungeon entrance (largest portal in the game; crack in a floating platform leading below)
- Void Seeker Nyx stands at the central platform node — highest vantage point in the zone
- Platform pathways between combat areas (narrow voxel bridges; no fall damage in overworld)
- Corrupted ruins on the largest platform: broken Abyss architecture, void crystal formations
- Sky Sovereign event site: largest open platform (used when event triggers)
- Dragon sighting visual cue: distant roar particle effect + dragon silhouette flies across skybox when Dragon is nearby

**NPC Interactions:**
- **Void Seeker Nyx** (NPC 005): Kitsune Lv750 Stage3 Dark → Werewolf Lv780 Stage3 Dark → Thunderbird Lv800 Stage2 Electric; 8,000–20,000 Silver + 5–15 Gold; hardest trainer in game
- Defeating all 5 trainers (Elder Maris through Void Seeker Nyx) triggers `all_trainers_defeated` achievement

**Zone Rewards:**
| Reward Source | Yield |
|---|---|
| Wild beast Silver | Level × 2 (avg 1,202–2,000 Silver per fight) |
| Void Shard field drop | 3,000 Silver sell value (3% base drop, 5% vs Dark-element) |
| Nyx win | 8,000–20,000 Silver + 5–15 Gold |
| Abyss Rift boss Silver | boss_level(1000 cap) × 50 = 50,000 Silver |
| Abyss Rift boss Gold | 400–800 Gold |
| Boss drops | Evolution Shard (60%), Evolution Crystal (20%), Species Materials (15% each, 4 types), Void Crystal (40%), Legend Trap (5%) |

**Dungeon: Abyss Rift**

| Property | Value |
|---|---|
| Dungeon ID | `dungeon_abyss` |
| Entry Level | 550+ |
| Boss | Abyssal Demon Lord (Lv1000 — capped at game max) |
| Waves | 7 + boss |
| Wave Level Step | +80 per wave |
| Wave Range | Lv601–1,081 (capped) → Boss Lv1000 |
| Daily Run Limit | 3 runs |
| Energy Cost | 25 Hunt Energy |
| Boss Species Drops (independent 15% each) | Abyss Essence, Petrified Eye, Spirit Orb, Blood Moon Stone |
| Boss Trophy | Void Crystal (40%) |
| Notable Monsters | Dark Troll (Rare, waves 4–7), Fallen Elf (Rare, waves 4–7), Wraith, Specter |
| Boss Phases | 3 phases: ≤60% Chaos Form (all attacks Dark, ATK+20%); ≤30% Soul Absorption (auto-Regen 5%/turn permanent) |
| Unique Boss Mechanic | Infernal Throne (once per battle): DEF+40% immune for 2T — plan around this window |

**Lore:** *"Nobody knows where the Abyss leads if you fall off the platforms. Researchers hired to find out have not returned with useful data. The Demon Lord has been there since before the hunters arrived, since before the Orcs built their volcano fortress, perhaps since before the world existed in its current configuration. It does not seem annoyed by the daily intrusions. It seems, if anything, entertained. That is somehow more alarming."*

**Art Direction:**
- Black and deep purple palette with void-blue accent lighting
- Floating platform terrain with visible abyss depth below (infinite dark with particle mist)
- Void crystal formations: translucent purple voxel clusters scattered across platforms
- Thunderbird storm effect: dramatic lightning flashes across the skybox; purple-white strikes
- Dragon visual cue: dark winged silhouette flies slowly across the background at large scale
- Abyssal Demon Lord arena: largest enclosed platform with throne architecture and soul-fire pillars

**Dev Notes:**
- Zone ID: `zone_abyss`
- Boss level: `Abyssal Demon Lord.Level = math.min(1000, 600 + 400)` — hard-capped at 1000 to match player max level
- Sky Sovereign event: `PlayerService:CheckSkyEventEligible(player)` → checks active roster for Stage 2+ Thunderbird + Storm weather; if eligible, adds 1% to each encounter roll independently
- Four species material drops from Abyssal Demon Lord are rolled INDEPENDENTLY — a single kill can yield multiple materials: `for _, mat in ipairs(boss_species_drops) do if math.random() < 0.15 then grant(mat) end end`
- Void Mist is always active as `sub_weather = "VoidMist"` regardless of the top-level weather state; Storm and Darkness are overlay conditions layered on top

---

### [006] Town / Hub

| Field | Value |
|---|---|
| **Zone ID** | `zone_hub` |
| **Zone Name** | Town / Hub |
| **Biome** | Bustling hunter's town; voxel market district, arena, guild quarter, hall of fame |
| **Level Range** | N/A (no combat; all levels welcome) |
| **Access** | Town Portal from any zone; always accessible |
| **Size** | Medium — fully walkable; distinct districts for each facility |
| **Wild Beast Level Range** | N/A |
| **Rarity Distribution** | N/A |
| **Hunt Energy per Encounter** | N/A |
| **Dungeons** | None |
| **Weather** | Always Clear (no weather mechanics) |
| **NPC Trainers** | None (trainers in field zones only) |
| **Wild Beast Encounter Rate** | N/A — no wild encounters |

**Hub Districts:**

| District | Location | Facilities |
|---|---|---|
| Market Square | Zone centre | Item Shop (Merchant Kaine), Pet Shop / Skill Shop (Beastmaster Yuna) |
| Bounty Hall | North of Market | Bounty Board (Bounty Master Rex) |
| Arena Quarter | East district | PvP Arena entrance (Arena Master Blake) |
| Guild Hall | West district | Guild formation, Guild War board, Guild Storage (post-launch) |
| Cosmetic Row | South district | Cosmetic Stylist Faye |
| Hall of Fame | Near Town Portal | Donor Hall of Fame billboard; weekly Most Tipped leaderboard |
| Leaderboard Plaza | Plaza outside Arena | Hub billboards: PvP rep, Pet Level, Dungeon Speed leaderboards |
| Spawn Plaza | Zone entry | Town Portals back to each field zone; new player arrival point |

**NPC Roster (Hub):**

| NPC | Type | Location | Function |
|---|---|---|---|
| Merchant Kaine | Shopkeeper | Market Square — Item Shop | Full GDD §11.1 inventory; sells consumables, traps, evolution materials |
| Beastmaster Yuna | Shopkeeper | Market Square — Pet + Skill Shop | Daily pet rotation (10 pets, 24h refresh); Skill Shop by active pet species |
| Bounty Master Rex | Quest Giver | Bounty Hall | 4 active bounties, 48h timers; server-wide completion |
| Arena Master Blake | Service | Arena Quarter | Open and directed PvP challenge; leaderboard view |
| Cosmetic Stylist Faye | Shopkeeper | Cosmetic Row | Weekly rotating Robux-only cosmetics; pet skins, outfits, accessories |

**Hub Features:**

| Feature | Description |
|---|---|
| Pet display | First 2 pets in `ActivePetIds` walk beside player — maximum visibility social feature |
| Leaderboard billboards | Large voxel screens showing top 10 per board; updated live via `LeaderboardService` |
| Donor Hall of Fame | Physical board listing top 10 cumulative donors (opt-in only; `ShowOnHallOfFame = true`) |
| NPC merchants | All visible as voxel characters with dialogue bubbles; interact to open shop UI |
| Social emotes | Players can use emote packs (Cosmetic Shop); visible to all nearby players |
| Weekly Most Tipped board | Adjacent to Hall of Fame; resets Monday 00:00 UTC |
| Badge Pin display | Player's equipped badge pins (rank crest, dungeon star, donor heart) visible on model |

**Hub Economy Functions:**

| Action | NPC | Cost |
|---|---|---|
| Buy HP/Stamina/Energy consumables | Merchant Kaine | Silver |
| Buy Traps (Basic through Legend) | Merchant Kaine | Silver / Gold |
| Buy Evolution Shard / Crystal / Re-imbue Stone | Merchant Kaine | Silver or Gold |
| Sell items (consumables, collectibles) | Merchant Kaine | Receive Silver or Gold |
| Buy pet from daily rotation | Beastmaster Yuna | Silver / Gold |
| Sell owned pet | Beastmaster Yuna | Receive Silver / Gold (30% buy price) |
| Buy species/element skill | Beastmaster Yuna (Skill Shop tab) | Silver / Gold by skill tier |
| Accept/complete bounty | Bounty Master Rex | Receive bounty reward on completion |
| Challenge PvP | Arena Master Blake | Free; PvP is cost-free |
| Buy cosmetic items | Cosmetic Stylist Faye | Robux only |

**Hub Social Layer:**

| Feature | Detail |
|---|---|
| Codex % above username | Format: `[username] \| 🐾 42%`; visible to all nearby players |
| Active title display | Appears above Codex % in chosen title colour/animation |
| Pet walking display | Stage 3 evolved pets have glow particle effect at Stage 3 |
| PvP rank crest badge | Auto-equips to badge pin slot; updates on rank change |
| Donor Heart badge | Shown if any donation ever made |

**Lore:** *"The Hunter's Hub predates the ranking system, the leaderboards, and the Cosmetic Stylist's shop by at least fifty years — it was originally a waystation for travellers who needed to sell what they'd caught before the long journey back to the capital. Merchant Kaine's family has run the Item Shop since the second generation. Beastmaster Yuna arrived recently, set up a pen behind the Market Square, and made more Silver in the first week than Kaine makes in a month. They are, reportedly, on good terms."*

**Art Direction:**
- Warm neutral palette; stone and wood voxel architecture; market stall awnings
- Cobblestone plaza centre with fountain (no function; purely atmospheric)
- Arena Quarter: taller architecture; crowd-stand voxel blocks around the arena ring
- Cosmetic Row: bright painted facades; outfit mannequin voxel displays outside Faye's shop
- Hall of Fame: grand entrance arch with gold trim; name plates in ascending size by donation tier
- No day/night cycle in Hub (always midday ambient light for visibility and social clarity)
- Hub soundtrack: upbeat town theme, distinct from zone ambient music

**Dev Notes:**
- Zone ID: `zone_hub`
- Hub is a separate place/server from field zones; accessed via `TeleportService:TeleportAsync` with `zone_hub` reserved server
- All shop transactions fire C→S RemoteEvents (`ShopBuy`, `ShopSell`) validated server-side before inventory/currency change
- Leaderboard billboards: `LeaderboardService` reads `OrderedDataStore` on `PlayerAdded` for initial display; updates pushed to hub clients via `RemoteEvent:FireAllClients("LeaderboardUpdate", board_id, data)` on data change
- Player-to-player tips handled via `MarketplaceService:PromptProductPurchase` in Arena Quarter social context; receipt processing logs sender+receiver server-side
- Pet walking render: `CosmeticService:ApplyActivePets(player)` spawns voxel pet models at offset from player `HumanoidRootPart`; Stage 3 pets add particle emitter `GlowEffect` to pet model
- Faye weekly stock reset: `FayeShopService:GenerateWeeklyStock()` fires at Monday 00:00 UTC via scheduled task

---

## Zone Data Reference

### Level and Encounter Overview

| Zone | Level Range | Avg Silver/Wild Fight | Best Silver Source | Dungeon Boss Silver |
|---|---|---|---|---|
| Starter Plains | 1–20 | 2–40 | Elder Maris (50–150) | N/A |
| Forest | 21–100 | 42–200 | Dungeon boss (3,850) | 3,850 |
| Mountain | 101–300 | 202–600 | Dungeon boss (13,450) | 13,450 |
| Volcano | 301–600 | 602–1,200 | Dungeon boss (31,850) | 31,850 |
| Abyss | 601–1000 | 1,202–2,000 | Dungeon boss (50,000) | 50,000 |
| Hub | — | N/A | NPC sales / bounties | N/A |

### Species Material Drop Sources by Zone

| Zone | Wild Drops (8% from Stage 2+) | Boss Drops (15%) |
|---|---|---|
| Starter Plains | None | N/A |
| Forest | Dire Pelt (Wolf), Fox Spirit Bead (Trickster Fox), Void Slime Core (3% Slime kill) | Goblin War Crown |
| Mountain | Shadow Fang (White Tiger), King's Mane Lock (Battle Lion), Tempest Quill (War Eagle), Ancient Shell Plate (Armored Turtle) | Lich's Phylactery, Treant Heartwood |
| Volcano | Phoenix Ash (Phoenix 10%), Dragon Scale (Dragon 10%) | Orc Warbrand Fragment + Phoenix Ash (3% bonus) |
| Abyss | Dragon Scale (Dragon 10%), Anaconda Venom Gem (King Anaconda 8%) | Abyss Essence, Petrified Eye, Spirit Orb, Blood Moon Stone |
| Hub | None | N/A |

### Dungeon Progression Reference

| Dungeon | Zone | Entry Lv | Boss | Boss Lv | Wave Lv Step | Daily Limit |
|---|---|---|---|---|---|---|
| Forest Cave | Forest | 15 | Goblin Warchief | 77 | +8 | 3 |
| Mountain Ruins | Mountain | 75 | Lich King | 269 | +24 | 3 |
| Dark Forest | Mountain | 75 | Elder Treant | 269 | +24 | 3 |
| Volcano Pit | Volcano | 250 | Orc Overlord | 637 | +48 | 3 |
| Abyss Rift | Abyss | 550 | Abyssal Demon Lord | 1000 | +80 | 3 |
