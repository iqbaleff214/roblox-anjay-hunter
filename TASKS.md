# Anjay Hunter — Script Task Board

> Implementation order: Phase 1 → Phase 5 → Phase 3 (S01–S02) → Phase 3 (S03–S04) → Phase 3 (S05–S18) → Phase 2 → Phase 4 (C01–C02) → Phase 4 (C03–C10)
>
> Each task must be completed and tested before tasks that depend on it begin.
> Format: `[ ]` = not started · `[~]` = in progress · `[x]` = done

---

## Phase 1 — Foundation & Config

All config files live in `src/shared/Config/`. They are pure data modules — no services, no RemoteEvents, no side effects. Every other script requires from these modules. Complete all 10 before writing any service or controller.

---

### F01 — Assets.lua
- [x] **File:** `src/shared/Config/Assets.lua`
- **Instruction:** Create a single return table with top-level keys: `Models`, `Images`, `Sounds`, `Animations`, `GamePasses`, `Products`, `Badges`. Under each key add sub-tables matching the categories defined in GDD §16.8. Every value is a placeholder integer `0` — no hardcoded live IDs. All other scripts must `require` this file and index into it; direct string/number asset IDs are forbidden everywhere else.
- **Output:** One file, no logic, no functions — pure nested table of constants.
- **Integration:** Required by every service, controller, and UI component that references a model, image, sound, animation, pass, product, or badge ID.
- **DoD:**
  - Keys present: `Models.Pets`, `Models.Monsters`, `Models.Npcs`, `Images.Elements`, `Images.Ranks`, `Images.Items`, `Images.UI`, `Sounds.Battle`, `Sounds.UI`, `Sounds.World`, `Sounds.Weather`, `Animations.Player`, `Animations.Pets`, `GamePasses` (all passes from GDD), `Products` (all products from GDD), `Badges` (all badges from GDD).
  - `require("Assets").GamePasses.hunters_vip` returns a number.
  - No other script in the codebase contains a bare numeric asset ID outside this file.

---

### F02 — GameConfig.lua
- [x] **File:** `src/shared/Config/GameConfig.lua`
- **Instruction:** Define all global gameplay tuning constants: `MAX_PARTY_SIZE`, `MAX_ACTIVE_PETS`, `PET_ROSTER_LIMIT`, `MAX_SKILL_SLOTS`, `ENERGY_MAX`, `ENERGY_REGEN_RATE_MINUTES`, `ENERGY_REGEN_AMOUNT`, `SILVER_PER_GOLD`, `EXPEDITION_SLOT_BASE`, `EXPEDITION_SLOT_VIP`, `DAILY_DUNGEON_LIMIT`, `DAILY_DUNGEON_LIMIT_VIP`, `CODEX_REWARD_SILVER`, `REPUTATION_PER_NPC_WIN`, `TITLE_UNLOCK_REPUTATION`. Values must match GDD §5–§8 and §14.
- **Output:** One flat return table; no nested tables (those belong in domain configs).
- **Integration:** Required by `PlayerService` for schema defaults, `EnergyService` for regen math, `BattleService` for party validation, `MarketplaceService` for pass-gated limits.
- **DoD:**
  - All constants enumerated above are present with correct GDD values.
  - `require("GameConfig").ENERGY_MAX` returns the correct integer.
  - Changing one value here propagates to all consuming services without touching service code.

---

### F03 — SpeciesConfig.lua
- [ ] **File:** `src/shared/Config/SpeciesConfig.lua`
- **Instruction:** Define every playable pet species as a keyed table `[species_id] = { ... }`. Each entry must include: `Name`, `Element` (string matching element IDs in ElementUtils), `BaseStats` (`HP`, `ATK`, `DEF`, `SPD`, `CRT`), `StatGrowth` (multipliers per level), `EvolutionStages` (array of stage tables each with `Level`, `ModelId` key referencing `Assets.Models.Pets`), `SkillPool` (array of skill IDs referencing SkillConfig), `BaseCapture` (number, 0–1), `Rarity` (string), `Lore` (string). Cross-reference BEAST.md and MONSTER.md for species that appear as both capturable and wild.
- **Output:** One file, all species populated with at least stat stubs; lore strings can be placeholder text initially.
- **Integration:** Required by `PetService` (evolution, leveling), `BattleService` (stat lookup), `CaptureService` (base rate), `CodexService` (entry generation), `HUDController`/`PetPanelController` (display).
- **DoD:**
  - Every species referenced in ZONE.md wild rosters has an entry.
  - `require("SpeciesConfig")[species_id].BaseStats.HP` returns a number > 0.
  - `EvolutionStages` arrays reference `Assets.Models.Pets.*` keys, not raw IDs.
  - Rarity string is one of: `"Common"`, `"Uncommon"`, `"Rare"`, `"Epic"`, `"Legendary"`.

---

### F04 — MonsterConfig.lua
- [ ] **File:** `src/shared/Config/MonsterConfig.lua`
- **Instruction:** Define every wild monster and boss from MONSTER.md as `[monster_id] = { ... }`. Fields: `Name`, `Element`, `IsBoss` (bool), `PhaseCount` (1–3), `BaseStats`, `PhaseThresholds` (HP % triggers, only if `IsBoss`), `PhaseStatMultipliers` (table indexed by phase), `AIBehavior` (`"aggressive"` / `"defensive"` / `"support"`), `AbilityPool` (array of skill IDs), `DropTable` (array of `{ ItemId, Chance, MinQty, MaxQty }`), `ExpReward`, `SilverReward`, `ModelId` (key into `Assets.Models.Monsters`). Boss entries must list all phase abilities separately.
- **Output:** One file; all 21 monsters + 5 bosses fully populated per MONSTER.md.
- **Integration:** Required by `BattleService` (stat resolution, phase transitions, AI), `LootService` (drop rolls), `ZoneService` (spawn validation), `QuestService` (kill tracking).
- **DoD:**
  - `require("MonsterConfig")["boss_orc_overlord"].PhaseCount == 3`.
  - Drop tables sum to ≤ 100% for mandatory drops; optional drops may stack beyond but each entry is evaluated independently.
  - `ModelId` values reference `Assets.Models.Monsters.*` keys.
  - `AIBehavior` is one of the three valid strings.

---

### F05 — ItemConfig.lua
- [ ] **File:** `src/shared/Config/ItemConfig.lua`
- **Instruction:** Define all 53 items from ITEM.md as `[item_id] = { ... }`. Fields: `Name`, `Category` (`"consumable"` / `"material"` / `"equipment"` / `"key_item"`), `SubCategory`, `StackMax`, `BuyPrice`, `SellPrice`, `Effects` (array of effect descriptors used by `ItemService`), `Acquisition` (array of source strings, informational), `IconId` (key into `Assets.Images.Items`), `Description`. For consumables, `Effects` must be structured data (not prose) so `ItemService` can execute them: `{ type="heal_hp", amount=0.3, target="self" }`.
- **Output:** One file; all 53 items populated.
- **Integration:** Required by `ItemService` (use/effect execution), `ShopService` (price lookup), `LootService` (item validation), `InventoryController` (display).
- **DoD:**
  - All 53 item IDs from ITEM.md present.
  - Every consumable has a machine-readable `Effects` array (no prose-only entries).
  - `require("ItemConfig")["item_potion_minor"].Effects[1].type` returns a string.
  - `IconId` values reference `Assets.Images.Items.*` keys.

---

### F06 — SkillConfig.lua
- [ ] **File:** `src/shared/Config/SkillConfig.lua`
- **Instruction:** Define every skill referenced in MONSTER.md ability pools, NPC.md pet teams, BEAST.md, and BATTLE.md as `[skill_id] = { ... }`. Fields: `Name`, `Element`, `Type` (`"physical"` / `"elemental"` / `"status"` / `"heal"` / `"passive"`), `PowerBase` (damage coefficient used in FormulaUtils), `AccuracyBase` (0–1), `CritBonus` (flat addition to CRT), `StatusEffect` (optional, `{ id, duration, chance }`), `Priority` (0 = always-first, 1 = normal), `Hits` (integer, for multi-hit skills), `IsIgnoreDef` (bool), `IsIgnoreEvasion` (bool), `IsAoE` (bool), `HealRatio` (for heal type), `Description`.
- **Output:** One file; complete skill roster for all species and monsters.
- **Integration:** Required by `BattleService` (execution), `FormulaUtils` (damage calc), `ElementUtils` (element check), `PetService` (equip validation), `HUDController` (skill button labels).
- **DoD:**
  - Every skill ID referenced in SpeciesConfig.SkillPool and MonsterConfig.AbilityPool exists here.
  - `Priority=0` skills are correctly flagged (they fire before SPD order).
  - `Hits > 1` only on multi-hit skills per BATTLE.md.
  - `Type` is one of the five valid strings.

---

### F07 — ZoneConfig.lua
- [ ] **File:** `src/shared/Config/ZoneConfig.lua`
- **Instruction:** Define all 6 zones from ZONE.md as `[zone_id] = { ... }`. Fields: `Name`, `LevelRange` (`{ min, max }`), `WeatherPool` (array of weather IDs with weights), `WildRoster` (array of `{ SpeciesId, RarityWeight, MinLevel, MaxLevel }`), `Dungeons` (array of dungeon IDs), `AmbientSoundId` (key into `Assets.Sounds.World`), `EntryRequirement` (level or nil), `LoreText`. For each dungeon referenced, add a `Dungeons` sub-config in the same file: `[dungeon_id] = { ZoneId, Waves, MinLevel, WaveScalingStep, BossId, TimeLimit, DropTable }`.
- **Output:** One file covering zones and dungeons.
- **Integration:** Required by `ZoneService` (weather, roster, spawn), `DungeonService` (wave config, boss lookup), `TeleportService` (reserved server routing), `QuestService` (zone-specific quests), `MapController` (zone display).
- **DoD:**
  - All 6 zone IDs from ZONE.md present.
  - All 5 dungeon IDs from ZONE.md present.
  - `WildRoster` weights sum to 100 per zone.
  - `BossId` references a key in MonsterConfig where `IsBoss == true`.

---

### F08 — NpcConfig.lua
- [ ] **File:** `src/shared/Config/NpcConfig.lua`
- **Instruction:** Define all 10 NPCs from NPC.md as `[npc_id] = { ... }`. Fields: `Name`, `Role` (`"trainer"` / `"shopkeeper"` / `"quest_giver"` / `"service"`), `ZoneId`, `DialogueLines` (keyed table: `"idle"`, `"pre_battle"`, `"win"`, `"lose"`, `"shop_open"`), `PetTeam` (array of `{ SpeciesId, Level, EquippedSkills }` — trainers only), `BattleRules` (`{ AllowCapture, Rounds, RewardSilver, ReputationGain }` — trainers only), `ShopInventory` (array of item IDs with stock/restock — shopkeepers only), `ModelId` (key into `Assets.Models.Npcs`), `QuestIds` (array — quest giver only).
- **Output:** One file; all 10 NPCs fully populated per NPC.md.
- **Integration:** Required by `NpcService` (battle trigger, shop), `ShopService` (inventory source), `QuestService` (quest provider lookup), `DialogueController` (dialogue fetch).
- **DoD:**
  - All 10 NPC IDs from NPC.md present with correct roles.
  - Trainer pet teams reference valid SpeciesConfig keys.
  - Shopkeeper inventories reference valid ItemConfig keys.
  - `ModelId` values reference `Assets.Models.Npcs.*` keys.

---

### F09 — Types.lua
- [ ] **File:** `src/shared/Types.lua`
- **Instruction:** Define shared type aliases as documentation-only Lua comments and table shapes (Luau type annotations if project uses strict mode). Types to define: `PlayerData`, `PetData`, `BattleState`, `BattleCombatant`, `ActiveEffect`, `DropResult`, `QuestProgress`, `ExpeditionSlot`. These mirror the schemas in GDD §4 and BATTLE.md. The file returns a table of constructor functions (`Types.newPetData()`, `Types.newPlayerData()`) that return zero-valued instances — used by `PlayerService` for schema initialization.
- **Output:** One file; constructor functions return default-valued tables matching GDD schema exactly.
- **Integration:** Required by `PlayerService` (new player setup), `PetService` (new pet creation), `BattleService` (state init), `SaveService` (schema migration check).
- **DoD:**
  - `Types.newPlayerData()` returns a table with all keys from GDD §4 PlayerData schema.
  - `Types.newPetData()` returns a table with all keys from GDD §4 PetData schema.
  - No key from the GDD schemas is missing.
  - Adding a new key here is the only change needed to propagate a schema field.

---

### F10 — Remotes.lua
- [ ] **File:** `src/shared/Remotes.lua`
- **Instruction:** Create and return all RemoteEvents and RemoteFunctions used between server and client. Organize into sub-tables: `Battle` (`StartBattle`, `ActionSelected`, `BattleUpdate`, `BattleEnd`), `Pet` (`PetUpdated`, `EquipPet`, `UnequipPet`, `LearnSkill`), `Player` (`DataLoaded`, `StatUpdated`, `CurrencyUpdated`), `Shop` (`OpenShop`, `PurchaseItem`, `SellItem`), `Quest` (`QuestUpdated`, `QuestComplete`), `Zone` (`WeatherChanged`, `EnterZone`), `UI` (`OpenPanel`, `ClosePanel`, `Notification`), `Dungeon` (`JoinDungeon`, `WaveUpdate`, `DungeonEnd`), `Capture` (`AttemptCapture`, `CaptureResult`), `Energy` (`EnergyUpdated`). Server creates instances; clients read them. This file must run on both sides — use `ReplicatedStorage` as parent.
- **Output:** One file that creates remotes on server init and provides typed accessors on both sides.
- **Integration:** All services fire events through this module. All controllers listen through this module. No script may create a RemoteEvent outside this file.
- **DoD:**
  - All remote names listed above exist.
  - Running `require("Remotes").Battle.StartBattle` returns the RemoteEvent instance.
  - No RemoteEvent or RemoteFunction is created outside this file.
  - Names are consistent between what services fire and what controllers listen on.

---

## Phase 5 — Shared Utilities

Live in `src/shared/Utils/`. Pure functions only — no state, no yields, no service calls. Complete before Phase 3 services, as services import these.

---

### U01 — StatUtils.lua
- [ ] **File:** `src/shared/Utils/StatUtils.lua`
- **Instruction:** Implement stat computation functions used by BattleService and PetService:
  - `ComputeStat(base, level, growth)` — returns final stat value using GDD's level scaling formula.
  - `ApplyModifier(stat, modifier)` — applies ATK/DEF stage modifier table from BATTLE.md (−6 to +6 stages).
  - `GetModifierMultiplier(stage)` — returns the multiplier for a given modifier stage per BATTLE.md table.
  - `ComputeCaptureChance(baseRate, currentHp, maxHp, rarityModifier)` — returns 0–1 using BATTLE.md capture formula.
- **Output:** Module returning a table of pure functions.
- **Integration:** Required by `BattleService`, `PetService`, `CaptureService`.
- **DoD:**
  - `ComputeCaptureChance(0.5, 10, 100, 1)` returns a higher value than `ComputeCaptureChance(0.5, 90, 100, 1)`.
  - `GetModifierMultiplier(0)` returns 1.0.
  - All four functions pass basic unit-level smoke tests (call without error, return a number).

---

### U02 — FormulaUtils.lua
- [ ] **File:** `src/shared/Utils/FormulaUtils.lua`
- **Instruction:** Implement all damage and heal formulas from BATTLE.md:
  - `PhysicalDamage(attackerATK, defenderDEF, power)` — standard formula.
  - `SkillDamage(attackerATK, defenderDEF, power, elementMultiplier)` — elemental variant.
  - `DefIgnoreDamage(attackerATK, power)` — skips DEF.
  - `MultiHitDamage(attackerATK, defenderDEF, power, hits)` — returns total after all hits.
  - `HealAmount(targetMaxHP, healRatio)` — returns flat HP restored.
  - `DotTick(attackerATK, dotCoefficient)` — damage per DOT tick.
  - `CritCheck(critStat)` — returns bool, probability derived from CRT stat.
  - `AccuracyCheck(accuracyBase, targetEvasion)` — returns bool.
- **Output:** Module returning a table of pure functions.
- **Integration:** Required by `BattleService` exclusively. Keeps battle logic readable.
- **DoD:**
  - `PhysicalDamage(100, 50, 1.0)` returns a positive number.
  - `MultiHitDamage` returns a value greater than single-hit equivalent (same power, hits=3).
  - `HealAmount(1000, 0.3)` returns 300.
  - All functions are deterministic except `CritCheck` and `AccuracyCheck` (which use `math.random`).

---

### U03 — ElementUtils.lua
- [ ] **File:** `src/shared/Utils/ElementUtils.lua`
- **Instruction:** Implement element matchup logic from ELEMENT.md:
  - `GetMultiplier(attackElement, defenderElement)` — returns 1.5 (strong), 0.5 (weak), or 1.0 (neutral) per the full 10×10 matrix.
  - `GetInnateEffect(element)` — returns the innate passive trait descriptor for the element (string ID referencing SkillConfig or a descriptor table).
  - `GetSynergies(elementA, elementB)` — returns synergy descriptor if the pair has one, else nil.
  - Hard-code the full matchup matrix as a nested table inside this file — do not load from config.
- **Output:** Module with three exported functions.
- **Integration:** Required by `BattleService` (damage calc), `FormulaUtils` (element multiplier input), `HUDController` (element badge color), `CodexService` (element display).
- **DoD:**
  - Matrix covers all 10 elements × 10 elements (100 entries).
  - `GetMultiplier("fire", "grass")` returns 1.5.
  - `GetMultiplier("water", "fire")` returns 1.5.
  - `GetMultiplier("fire", "fire")` returns 1.0 (or the correct neutral value per ELEMENT.md).
  - `GetSynergies` returns non-nil for at least one valid pair from ELEMENT.md.

---

### U04 — RarityUtils.lua
- [ ] **File:** `src/shared/Utils/RarityUtils.lua`
- **Instruction:** Implement rarity helpers:
  - `GetRarityModifier(rarity)` — returns capture rate divisor per BATTLE.md rarity table (`Common=1`, `Uncommon=1.5`, `Rare=2.5`, `Epic=5`, `Legendary=15`).
  - `GetRarityColor(rarity)` — returns `Color3` value for UI badge rendering.
  - `GetRarityWeight(rarity, weatherBonus)` — returns adjusted spawn weight given optional weather modifier from ZoneConfig.
  - `RollRarity(weightTable)` — given a weight table `{ Common=N, ... }`, returns one rarity string via weighted random.
- **Output:** Module with four exported functions.
- **Integration:** Required by `CaptureService`, `LootService`, `ZoneService`, `HUDController`.
- **DoD:**
  - `GetRarityModifier("Legendary")` returns 15.
  - `RollRarity` returns one of the 5 valid rarity strings every call.
  - `GetRarityColor` returns a `Color3` (not nil) for all 5 rarities.

---

### U05 — TimeUtils.lua
- [ ] **File:** `src/shared/Utils/TimeUtils.lua`
- **Instruction:** Implement time helpers for lazy energy regen and daily reset:
  - `SecondsSince(unixTimestamp)` — returns elapsed seconds.
  - `ComputeEnergyRegen(lastTime, currentTime, regenRateMinutes, regenAmount, maxEnergy, currentEnergy)` — returns units of energy regenerated since `lastTime`, capped at `maxEnergy - currentEnergy`.
  - `IsSameDay(timestampA, timestampB)` — returns bool (UTC day comparison).
  - `SecondsToDailyReset(currentTimestamp)` — returns seconds until next UTC midnight.
- **Output:** Module with four exported functions.
- **Integration:** Required by `EnergyService` (regen on login and before spend), `QuestService` (daily reset), `DungeonService` (daily run limit reset).
- **DoD:**
  - `ComputeEnergyRegen` with a large time gap returns `maxEnergy - currentEnergy` (capped).
  - `ComputeEnergyRegen` with zero elapsed time returns 0.
  - `IsSameDay` returns true for two timestamps in the same UTC day and false across midnight.
  - `SecondsToDailyReset` returns a value between 0 and 86400.

---

## Phase 3 — Server Services

Live in `src/server/Services/`. Each is a Knit Service. Initialize in dependency order: SaveService → PlayerService → EnergyService → ItemService → PetService → SkillService → CaptureService → ZoneService → BattleService → LootService → QuestService → AchievementService → CodexService → NpcService → ShopService → DungeonService → LeaderboardService → MarketplaceService.

---

### S01 — SaveService.lua
- [ ] **File:** `src/server/Services/SaveService.lua`
- **Instruction:** Wrap ProfileService to manage per-player DataStore profiles. On `PlayerAdded`: load profile, lock session, yield until loaded, fire `OnProfileLoaded` signal. On `PlayerRemoving`: release lock, save. Expose `GetProfile(player)` returning the live profile object. Handle failed loads by kicking the player with a clear message. Store the default player schema using `Types.newPlayerData()` as the profile template. Implement `MigrateSchema(data)` to add missing keys from current Types without wiping existing data.
- **Output:** Knit Service with `GetProfile`, `OnProfileLoaded` signal, automatic save on remove, schema migration.
- **Integration:** All other services call `SaveService.GetProfile(player)` to read/write persistent data. Must be initialized first.
- **DoD:**
  - Player joins → profile loads within 10s or player is kicked.
  - Player leaves → profile saves (verify via Studio output).
  - Adding a new key to `Types.newPlayerData()` and rejoining a player with old data does not error; new key appears with default value.
  - Two players cannot hold the same profile lock simultaneously (ProfileService guarantees this, verify no double-load).

---

### S02 — PlayerService.lua
- [ ] **File:** `src/server/Services/PlayerService.lua`
- **Instruction:** Provide server-side player state access. Expose: `GetData(player)` (returns profile.Data), `SetStat(player, key, value)` (validates, sets, fires `Remotes.Player.StatUpdated`), `AddSilver(player, amount)`, `RemoveSilver(player, amount)` (returns false if insufficient), `AddGold(player, amount)`, `RemoveGold(player, amount)`, `GetActivePets(player)` (returns array of PetData from ActivePetIds), `GetRosterPets(player)` (full roster). On player data loaded, fire `Remotes.Player.DataLoaded` to client with full data snapshot. Subscribe to `SaveService.OnProfileLoaded`.
- **Output:** Knit Service exposing player data read/write API used by all other services.
- **Integration:** Depends on SaveService, Types. Used by BattleService, EnergyService, PetService, ItemService, ShopService, MarketplaceService.
- **DoD:**
  - `AddSilver` and `RemoveSilver` correctly modify profile.Data.Silver.
  - `RemoveSilver` when balance insufficient returns false and does not modify data.
  - Client receives `DataLoaded` with a data snapshot within 5 seconds of join.
  - `GetActivePets` returns at most `GameConfig.MAX_ACTIVE_PETS` entries.

---

### S03 — EnergyService.lua
- [ ] **File:** `src/server/Services/EnergyService.lua`
- **Instruction:** Implement lazy energy regen — never a polling loop. On `GetEnergy(player)`: compute regen via `TimeUtils.ComputeEnergyRegen` using `profile.Data.LastEnergyTime`, apply to `profile.Data.HuntEnergy`, update `LastEnergyTime`, return current value. On `SpendEnergy(player, amount)`: call `GetEnergy` first (to apply regen), then deduct if sufficient, fire `Remotes.Energy.EnergyUpdated` to client. `RestoreEnergy(player, amount)`: add up to max, fire update. VIP pass holders get `ENERGY_MAX_VIP` from GameConfig.
- **Output:** Knit Service with `GetEnergy`, `SpendEnergy`, `RestoreEnergy`, `GetMaxEnergy`.
- **Integration:** Depends on PlayerService, TimeUtils, GameConfig, MarketplaceService (for VIP check). Called by BattleService before wild hunts, ItemService for energy items.
- **DoD:**
  - Spending energy when at 0 returns false; data unchanged.
  - After simulating 1 hour elapsed (mock `LastEnergyTime`), `GetEnergy` returns capped max.
  - `EnergyUpdated` remote fires after every spend or restore.
  - VIP player cap is higher than non-VIP.

---

### S04 — ItemService.lua
- [ ] **File:** `src/server/Services/ItemService.lua`
- **Instruction:** Implement inventory CRUD and item use. `AddItem(player, itemId, qty)`: adds to `profile.Data.Inventory`, respects `StackMax`. `RemoveItem(player, itemId, qty)`: deducts, errors if insufficient. `UseItem(player, itemId, targetPetId)`: validates item exists in inventory, looks up `ItemConfig[itemId].Effects`, executes each effect (heal HP → call BattleService if in battle, restore energy → EnergyService, XP boost → PetService, etc.), removes one use, fires `StatUpdated`. `GetInventory(player)`: returns current inventory snapshot.
- **Output:** Knit Service with CRUD and use execution.
- **Integration:** Depends on PlayerService, ItemConfig, EnergyService, PetService (XP), BattleService (in-battle heals). Called by ShopService (post-purchase), LootService (reward delivery), QuestService (reward delivery).
- **DoD:**
  - `AddItem` up to `StackMax` then further add splits into next stack slot correctly.
  - `UseItem` on a consumable with `type="heal_hp"` modifies target pet HP (in or out of battle).
  - `UseItem` on non-existent item in inventory returns an error string.
  - `RemoveItem` below 0 quantity does not produce negative inventory.

---

### S05 — PetService.lua
- [ ] **File:** `src/server/Services/PetService.lua`
- **Instruction:** Manage pet lifecycle. `CreatePet(player, speciesId, level)` → returns new PetData via `Types.newPetData()`, appends to `profile.Data.PetRosterIds`. `AddXP(player, petId, amount)` → adds XP, checks level-up via SpeciesConfig.StatGrowth, triggers `CheckEvolution`. `CheckEvolution(player, petId)` → if level ≥ next stage threshold, auto-evolve, update `EvolutionStage`, update ModelId reference in PetData. `EquipPet(player, petId)` → validates against `MAX_ACTIVE_PETS`, moves petId to `ActivePetIds`. `UnequipPet(player, petId)`. `LearnSkill(player, petId, skillId)` → validates `SkillSlots`, adds to `EquippedSkills`. `GetPetData(player, petId)` → returns PetData. `ComputeStats(petData)` → calls StatUtils for final stats at current level.
- **Output:** Knit Service with full pet lifecycle management.
- **Integration:** Depends on PlayerService, SpeciesConfig, SkillConfig, StatUtils, Types. Called by BattleService (stat reads), CaptureService (create on capture), LootService (pet rewards), QuestService (pet-related quests).
- **DoD:**
  - `CreatePet` → `AddXP` → level up correctly increments `Level` and updates `XP` to remainder.
  - Evolution triggers at correct level threshold and updates `EvolutionStage`.
  - `EquipPet` when `ActivePetIds` is at cap returns an error without modifying data.
  - `ComputeStats` returns higher ATK for a level-20 pet than level-1 same species.

---

### S06 — SkillService.lua
- [ ] **File:** `src/server/Services/SkillService.lua`
- **Instruction:** Provide skill data access and validation for BattleService. `GetSkillData(skillId)` → returns SkillConfig entry. `ValidateEquip(petData, skillId)` → checks skill is in species SkillPool and slot limit not exceeded. `GetEquippedSkills(petData)` → returns array of SkillConfig entries for equipped skill IDs. `BuildTurnQueue(combatants)` → sorts combatants by SPD, inserts `priority=0` entries before all others per BATTLE.md always-first rules.
- **Output:** Knit Service focused on skill lookup and turn-order logic.
- **Integration:** Depends on SkillConfig, SpeciesConfig. Used exclusively by BattleService for turn resolution. PetService calls `ValidateEquip`.
- **DoD:**
  - `BuildTurnQueue` with a mix of priority-0 and normal skills places all priority-0 entries first.
  - Two combatants with same SPD are ordered deterministically (e.g., attacker first or random-seeded).
  - `GetEquippedSkills` returns exactly the skills stored in `petData.EquippedSkills`.

---

### S07 — CaptureService.lua
- [ ] **File:** `src/server/Services/CaptureService.lua`
- **Instruction:** Handle capture attempts. `AttemptCapture(player, wildMonsterState)` (called by BattleService at ACTION_RESOLVE when action type is capture): compute chance via `StatUtils.ComputeCaptureChance(speciesBaseCapture, currentHp, maxHp, rarityModifier)`. Roll `math.random()`. On success: call `PetService.CreatePet`, add to roster, fire `Remotes.Capture.CaptureResult` with `{ success=true, petId }`. On fail: fire result with `{ success=false }`. Check roster cap before creating; fire error if full. Only valid during Wild Hunt and Dungeon battles.
- **Output:** Knit Service with `AttemptCapture` returning bool and optional petId.
- **Integration:** Depends on PetService, StatUtils, RarityUtils, SpeciesConfig, GameConfig. Called only by BattleService.
- **DoD:**
  - At 1 HP, capture chance is significantly higher than at full HP (verify with logged values).
  - Legendary species at low HP still has lower chance than Common at same HP ratio.
  - Full roster prevents capture and fires appropriate remote with error message.
  - Client receives `CaptureResult` remote in both success and fail cases.

---

### S08 — ZoneService.lua
- [ ] **File:** `src/server/Services/ZoneService.lua`
- **Instruction:** Manage zone state and weather. On server start: initialize weather state per zone using ZoneConfig.WeatherPool weighted random. `TickWeather()` — called on an interval (e.g., every 5 minutes real time) to re-roll weather per zone and fire `Remotes.Zone.WeatherChanged`. `GetCurrentWeather(zoneId)` — returns current weather string. `GetWildEncounter(zoneId, playerLevel)` — selects a species from ZoneConfig.WildRoster weighted by rarity, level-filtered, returns `{ speciesId, level, element }`. `ValidateZoneAccess(player, zoneId)` — checks `ZoneConfig[zoneId].EntryRequirement` against player level.
- **Output:** Knit Service with weather loop, encounter roll, and access validation.
- **Integration:** Depends on ZoneConfig, RarityUtils, GameConfig. Called by BattleService (trigger wild encounter), DungeonService (zone validation), client map interaction through remote.
- **DoD:**
  - Weather re-rolls every 5 minutes without memory leak (no growing table of connections).
  - `GetWildEncounter` never returns a species outside the zone's roster.
  - `GetWildEncounter` respects level range (no level-50 monster in a starter zone level-1 roster).
  - `ValidateZoneAccess` blocks underpowered players for zones with entry requirements.

---

### S09 — BattleService.lua
- [ ] **File:** `src/server/Services/BattleService.lua`
- **Instruction:** Implement the full battle state machine (IDLE → INIT → TURN_START → ACTION_SELECT → ACTION_RESOLVE → CHECK_END → BATTLE_END). Server-authoritative — clients send action requests, server validates and resolves. Store active battles in a module-level table keyed by `battleId`. `StartBattle(player, battleType, opponentId)` → creates BattleState, assigns combatants, fires `Remotes.Battle.StartBattle` with initial state. On `ActionSelected` remote from client: validate it's this player's turn, resolve action (damage via FormulaUtils, status via effect system, capture via CaptureService, flee check). After resolution fire `Remotes.Battle.BattleUpdate`. On battle end fire `Remotes.Battle.BattleEnd` with rewards. Handle all 4 battle types: Wild Hunt (capture possible), Dungeon Run (wave progression), NPC Battle (reputation on win), PvP (player vs player). Implement boss phase transitions per MonsterConfig.PhaseThresholds.
- **Output:** Knit Service implementing complete battle loop.
- **Integration:** Depends on SkillService, FormulaUtils, ElementUtils, StatUtils, CaptureService, LootService, PlayerService, PetService, EnergyService, MonsterConfig, SkillConfig, Remotes. Central dependency for PvP, Dungeon, NPC, and Wild flows.
- **DoD:**
  - Wild Hunt: battle starts, player selects skill, damage resolves correctly, battle ends with loot on monster defeat.
  - Boss with 2 phases transitions at correct HP% threshold and updates stats per PhaseStatMultipliers.
  - Priority-0 skill always fires before normal skills regardless of SPD.
  - A client sending an action when it is not their turn is rejected silently (no state change).
  - Status effects (Burn DOT) tick correctly each turn for the specified duration.

---

### S10 — LootService.lua
- [ ] **File:** `src/server/Services/LootService.lua`
- **Instruction:** Roll and distribute rewards after battle. `RollDrops(monsterId)` → iterates MonsterConfig.DropTable, rolls each entry independently by chance, returns array of `{ itemId, qty }`. `DistributeRewards(player, battleResult)` → calls `RollDrops` for each defeated monster, calls `ItemService.AddItem` for each drop, adds `ExpReward` and `SilverReward` to player via PlayerService, calls `PetService.AddXP` for each active pet, returns full reward summary. `RollDungeonChest(dungeonId)` → uses ZoneConfig dungeon DropTable.
- **Output:** Knit Service with drop rolling and reward distribution.
- **Integration:** Depends on MonsterConfig, ZoneConfig, ItemService, PlayerService, PetService, RarityUtils. Called by BattleService on `BATTLE_END`.
- **DoD:**
  - `RollDrops` for a monster with a 100% drop always returns that item.
  - `RollDrops` for a monster with a 0% drop never returns that item.
  - `DistributeRewards` correctly adds silver and XP to all active pets.
  - Dungeon chest uses dungeon-specific drop table, not monster drop table.

---

### S11 — QuestService.lua
- [ ] **File:** `src/server/Services/QuestService.lua`
- **Instruction:** Manage quest state. Define quest data inline or in a QuestConfig module (your choice). `AssignDailyQuests(player)` — on login or daily reset (check via TimeUtils.IsSameDay), assign 3 random daily quests to `profile.Data.DailyQuestIds`, reset `QuestProgress`. `IncrementProgress(player, eventType, amount)` — on events like `monster_defeated`, `pet_captured`, `dungeon_completed`, find matching quests and increment progress. `CheckCompletion(player, questId)` — if progress meets requirement, call `LootService.DistributeRewards` with quest rewards, fire `Remotes.Quest.QuestComplete`. `GetActiveQuests(player)` → returns current quests with progress.
- **Output:** Knit Service managing daily quest assignment, progress tracking, and completion.
- **Integration:** Depends on PlayerService, LootService, ItemService, TimeUtils. `IncrementProgress` called by BattleService (monster defeated), CaptureService (capture), DungeonService (dungeon complete).
- **DoD:**
  - On login after midnight, quests reset and 3 new quests are assigned.
  - Completing a quest fires `QuestComplete` remote exactly once.
  - Progress does not increment beyond the quest's requirement.
  - Quest rewards (silver, items) are delivered via LootService/ItemService.

---

### S12 — AchievementService.lua
- [ ] **File:** `src/server/Services/AchievementService.lua`
- **Instruction:** Track lifetime achievements. Define achievement conditions inline (e.g., `first_steps` = complete first battle, `beast_slayer` = defeat 100 monsters). `CheckAchievements(player, eventType, metadata)` — evaluate all unearned achievements against current `profile.Data.AchievementsCompleted`. On unlock: append to `AchievementsCompleted`, award badge via `BadgeService:AwardBadge` using `Assets.Badges[achievementId]`, fire `Remotes.UI.Notification` with achievement message. `GetUnlocked(player)` → returns array of earned IDs.
- **Output:** Knit Service with event-driven achievement checking and badge award.
- **Integration:** Depends on PlayerService, Assets. Called by BattleService, CaptureService, QuestService, DungeonService. Requires Roblox `BadgeService` (server API).
- **DoD:**
  - `first_steps` achievement unlocks exactly once even if `CheckAchievements` called multiple times.
  - Badge award uses ID from `Assets.Badges`, not a hardcoded number.
  - Notification remote fires on client immediately after achievement unlock.
  - `AchievementsCompleted` in profile grows monotonically (never shrinks).

---

### S13 — CodexService.lua
- [ ] **File:** `src/server/Services/CodexService.lua`
- **Instruction:** Manage the species codex. `RecordEntry(player, speciesId)` — if not already in `profile.Data.CodexEntries`, add entry with `{ firstSeen=os.time(), capturedCount=0 }`, award `GameConfig.CODEX_REWARD_SILVER` via PlayerService, fire `Remotes.UI.Notification`. `IncrementCapture(player, speciesId)` — increment `capturedCount`. `GetCodex(player)` → returns full codex table. `GetCompletion(player)` → returns `{ count, total }` where total is count of all species in SpeciesConfig.
- **Output:** Knit Service with record, increment, and query functions.
- **Integration:** Depends on PlayerService, SpeciesConfig, GameConfig. Called by CaptureService on successful capture.
- **DoD:**
  - First encounter with a species fires notification and awards silver exactly once.
  - Subsequent captures of same species increment `capturedCount` without re-awarding silver.
  - `GetCompletion` total matches the number of entries in SpeciesConfig.

---

### S14 — NpcService.lua
- [ ] **File:** `src/server/Services/NpcService.lua`
- **Instruction:** Handle NPC interactions. `TalkToNpc(player, npcId)` → returns NPC dialogue for current context (`idle` if no prior interaction, specific lines if quest active). `StartNpcBattle(player, npcId)` → validates NpcConfig.Role == "trainer", builds opponent combatants from NpcConfig.PetTeam, calls `BattleService.StartBattle` with `battleType="npc"`. On battle end award reputation via PlayerService. `CanRechallenge(player, npcId)` → checks GDD recharge rules (one win per npc per session or as specified in NPC.md). `GetNpcShop(npcId)` → returns ShopInventory (for routing to ShopService).
- **Output:** Knit Service for NPC dialogue, battle initiation, and shop routing.
- **Integration:** Depends on NpcConfig, BattleService, ShopService, PlayerService. Called by client proximity-trigger events (via remote).
- **DoD:**
  - `StartNpcBattle` correctly initializes combatants from NpcConfig.PetTeam stats.
  - Winning NPC battle awards correct reputation amount from NpcConfig.BattleRules.
  - Trainer with `AllowCapture=false` cannot be captured (BattleService enforces via NPC battle type).
  - `TalkToNpc` returns distinct dialogue line for each context key.

---

### S15 — ShopService.lua
- [ ] **File:** `src/server/Services/ShopService.lua`
- **Instruction:** Handle shop purchases and sells. `GetShopInventory(npcId)` → returns NpcConfig.ShopInventory with current stock. `PurchaseItem(player, npcId, itemId, qty)` → validate stock, validate player has enough silver/gold per ItemConfig prices, deduct currency via PlayerService, call `ItemService.AddItem`, decrement stock. `SellItem(player, itemId, qty)` → validate player has item, call `ItemService.RemoveItem`, add silver = `ItemConfig[itemId].SellPrice × qty` via PlayerService. Restock on server restart (stock resets to default from NpcConfig).
- **Output:** Knit Service handling buy/sell transactions.
- **Integration:** Depends on NpcConfig, ItemConfig, ItemService, PlayerService. Called by `ShopController` via Remotes.
- **DoD:**
  - Purchasing with insufficient currency returns error; no items given, no currency deducted.
  - Selling an item not in inventory returns error.
  - Stock decrements on purchase and resets on server restart.
  - Correct currency type (silver vs gold) is used per ItemConfig.BuyPrice structure.

---

### S16 — DungeonService.lua
- [ ] **File:** `src/server/Services/DungeonService.lua`
- **Instruction:** Manage dungeon runs. `StartDungeon(player, dungeonId)` → validate `DungeonRunsToday < DAILY_DUNGEON_LIMIT` (or VIP limit), validate zone access, reserve server via `TeleportService:ReserveServer`, teleport player via `TeleportService:TeleportToPrivateServer`. Within dungeon session (server-side per wave): `SpawnWave(dungeonId, waveNumber)` → compute monster levels using `zone_entry_level + (wave-1) × WaveScalingStep` from ZoneConfig. After final wave trigger boss via BattleService. On dungeon complete: award chest via `LootService.RollDungeonChest`, increment `DungeonRunsToday`, fire `Remotes.Dungeon.DungeonEnd`.
- **Output:** Knit Service handling dungeon entry gating, wave progression, and completion rewards.
- **Integration:** Depends on ZoneConfig, GameConfig, BattleService, LootService, PlayerService, TimeUtils, MarketplaceService (VIP limit). Uses Roblox TeleportService.
- **DoD:**
  - Non-VIP player blocked after `DAILY_DUNGEON_LIMIT` runs; VIP gets higher limit.
  - Wave monster levels scale correctly using the ZoneConfig formula.
  - Boss spawns only on final wave.
  - `DungeonRunsToday` resets to 0 on daily reset (next UTC day).

---

### S17 — LeaderboardService.lua
- [ ] **File:** `src/server/Services/LeaderboardService.lua`
- **Instruction:** Maintain OrderedDataStore leaderboards. `UpdateScore(player, category, value)` — categories: `"TotalXP"`, `"MonstersDefeated"`, `"DungeonsCompleted"`. Write to OrderedDataStore only on significant events (not every battle tick). `GetTopN(category, n)` → returns top N entries as `{ rank, userId, value }` array. Called by client leaderboard panel on open. Implement debounce: don't write more than once per 60 seconds per player per category.
- **Output:** Knit Service with write-on-event pattern and top-N query.
- **Integration:** Depends on PlayerService. `UpdateScore` called by BattleService (XP, defeats), DungeonService (dungeon count). Read by `LeaderboardController`.
- **DoD:**
  - Top-N query returns results sorted descending by value.
  - Writing twice within 60 seconds for same player+category only writes once.
  - `GetTopN(10)` never errors even if DataStore has fewer than 10 entries.

---

### S18 — MarketplaceService.lua
- [ ] **File:** `src/server/Services/MarketplaceService.lua`
- **Instruction:** Handle Game Pass and Developer Product purchases. `CheckPass(player, passKey)` → uses `MarketplaceService:UserOwnsGamePassAsync` with ID from `Assets.GamePasses[passKey]`, caches result in session. `GrantProduct(player, productKey, receiptInfo)` → executed inside `ProcessReceipt` callback; use `receiptInfo.PurchaseId` stored in `profile.Data` to implement idempotency (do not grant twice). Products: gold packs add gold via PlayerService, energy restore calls EnergyService, pet slot expand increments `PetSlots`. Register `ProcessReceipt` on service init. `GetOwnedPasses(player)` → returns table of owned pass keys.
- **Output:** Knit Service with pass checking, product granting, and idempotent receipt processing.
- **Integration:** Depends on PlayerService, EnergyService, GameConfig, Assets. Checked by EnergyService, DungeonService, PetService for VIP-gated features.
- **DoD:**
  - `ProcessReceipt` called twice with same `PurchaseId` grants reward exactly once.
  - `CheckPass` result is cached — second call does not hit the network.
  - Gold product correctly maps `productKey` to `Assets.Products[productKey]` ID.
  - Pet slot expansion increments `profile.Data.PetSlots` and does not exceed a defined maximum.

---

## Phase 2 — Cross-Platform UI Foundation

Live in `src/client/`. UIConfig and UIController must be complete before any Panel controllers. All UI must handle touch, mouse, and gamepad input paths.

---

### C00a — UIConfig.lua
- [ ] **File:** `src/shared/Config/UIConfig.lua`
- **Instruction:** Define all UI layout constants: `BREAKPOINTS` table (`{ MOBILE=480, TABLET=768, DESKTOP=1024 }`), `SCALE_TABLE` (`{ [480]=0.85, [768]=1.0, [1023]=1.1, [1024]=1.25 }`), `MIN_TAP_SIZE` (44 pixels), `SAFE_AREA_PADDING` (12 pixels), `PANEL_WIDTHS` (`{ MOBILE="100%", TABLET="60%", DESKTOP="380px" }`), `Z_INDEX` layers (`Background=1, Panel=10, Modal=20, Tooltip=30, Notification=40`), `ANIMATION_DURATION` (`{ Fast=0.1, Normal=0.2, Slow=0.4 }`), `COLORS` (palette table with named Color3 values for rarity, element, UI chrome).
- **Output:** One shared config file; no logic.
- **Integration:** Required by UIController, Button, Window, ScrollList, and all panel controllers.
- **DoD:**
  - All keys listed above are present.
  - `COLORS` has entries for all 5 rarities and all 10 elements.
  - `require("UIConfig").BREAKPOINTS.TABLET` returns 768.

---

### C00b — UIController.lua
- [ ] **File:** `src/client/Controllers/UIController.lua`
- **Instruction:** Central client UI orchestrator. `Init()`: detect platform via `UserInputService` flags, set `Platform` table (`IsMobile`, `IsTablet`, `IsDesktop`, `IsGamepad`). Apply `UIScale` to ScreenGui root based on `UIConfig.SCALE_TABLE` and `workspace.CurrentCamera.ViewportSize`. Apply safe area padding via `GuiService:GetGuiInset()`. `OpenPanel(panelName, data)`: show panel, hide conflicting panels (only one primary panel at a time). `ClosePanel(panelName)`. `ShowNotification(message, duration)`: tween in/out a notification frame. `BindInputs()`: use `ContextActionService:BindAction` for gamepad confirm/cancel mapped to UI confirm/cancel. Listen on `Remotes.UI.OpenPanel`, `Remotes.UI.ClosePanel`, `Remotes.UI.Notification`.
- **Output:** Knit Controller managing all panel lifecycle and platform scale.
- **Integration:** Depends on UIConfig, all panel controllers. All panels are opened/closed only through this controller.
- **DoD:**
  - On mobile viewport (`ViewportSize.X < 480`), `UIScale.Scale` is 0.85.
  - `OpenPanel("HUD")` shows HUD frame; calling `OpenPanel("Shop")` while HUD is showing does not break layout.
  - Notification appears for `duration` seconds then hides.
  - Gamepad confirm (A button) triggers the focused UI element's primary action.

---

### C00c — Button.lua
- [ ] **File:** `src/client/Components/Button.lua`
- **Instruction:** Reusable button component factory. `Button.new(frame, config)` → wraps a Frame/TextButton: binds `MouseButton1Click` and `TouchTap`, applies `MIN_TAP_SIZE` as minimum size constraint, handles hover state (desktop only), handles press animation (scale tween). `config` fields: `OnClick` (callback), `Label` (string), `Icon` (optional image key into Assets.Images.UI), `Disabled` (bool). `Button:SetDisabled(bool)` → dims the button, blocks clicks. `Button:Destroy()` → disconnects all connections.
- **Output:** Component module; not a Knit controller.
- **Integration:** Used by all panel controllers to create interactive buttons. Depends on UIConfig (min tap size, animation duration).
- **DoD:**
  - Button created with `MIN_TAP_SIZE` enforcement never renders smaller than 44×44 pixels.
  - `OnClick` fires on both mouse click and touch tap.
  - Disabled button does not fire `OnClick`.
  - `Button:Destroy()` leaves no leaked connections (test by creating and destroying 100 buttons).

---

### C00d — Window.lua
- [ ] **File:** `src/client/Components/Window.lua`
- **Instruction:** Reusable panel/window wrapper. `Window.new(screenGui, config)` → creates a Frame with title bar, close button, optional back button, and content area. Config: `Title`, `Width` (from UIConfig.PANEL_WIDTHS based on platform), `OnClose` callback, `ZIndex`. `Window:SetContent(instance)` → parents instance into content area. `Window:Show()` / `Window:Hide()` → tween in/out per UIConfig.ANIMATION_DURATION.Normal. On mobile, window fills screen width. On desktop, window is fixed width centered or right-anchored.
- **Output:** Component module.
- **Integration:** Used by HUDController, ShopController, PetPanelController, BattleController, etc. All panels that are multi-element UIs use Window as their shell.
- **DoD:**
  - Window renders at correct width per platform (mobile=full, desktop=fixed).
  - Close button fires `OnClose` and `Window:Hide()`.
  - Tween in/out completes within `ANIMATION_DURATION.Normal` seconds.
  - Multiple windows can coexist without ZIndex conflicts (each gets its configured ZIndex).

---

### C00e — ScrollList.lua
- [ ] **File:** `src/client/Components/ScrollList.lua`
- **Instruction:** Reusable scrollable list component. `ScrollList.new(parent, config)` → creates a ScrollingFrame with UIListLayout. Config: `ItemHeight`, `Padding`, `OnItemSelect` callback. `ScrollList:SetItems(items)` → clears existing children, creates one row frame per item (item must have `Id`, `Label`, `Subtitle`, optional `Icon`). `ScrollList:Clear()`. Rows must meet `MIN_TAP_SIZE` height. On touch, `ScrollInputEnded` should not misfire as a tap if scroll distance > 10 pixels (swipe vs tap discrimination).
- **Output:** Component module.
- **Integration:** Used by InventoryController (item list), ShopController (shop items), CodexController (species list), LeaderboardController (rank list).
- **DoD:**
  - Populating 50 items renders without frame rate drop (use `task.wait()` chunked if needed).
  - Scrolling does not misfire `OnItemSelect`.
  - `ScrollList:Clear()` removes all children and resets scroll position.
  - Row height is never below `MIN_TAP_SIZE`.

---

## Phase 4 — Client Controllers

Live in `src/client/Controllers/`. Each is a Knit Controller. They receive state from server via Remotes, render UI, and send action requests. No game logic — validation is server-side only.

---

### C01 — HUDController.lua
- [ ] **File:** `src/client/Controllers/HUDController.lua`
- **Instruction:** Render always-visible HUD: player currency (Silver, Gold), energy bar, active pet health bars (up to `MAX_ACTIVE_PETS` slots), minimap zone label, and bottom navigation bar with buttons for Pets, Inventory, Quests, Codex, Map. Use Button component for nav buttons. Listen on `Remotes.Player.StatUpdated` to refresh currency. Listen on `Remotes.Energy.EnergyUpdated` to refresh energy bar. Listen on `Remotes.Player.DataLoaded` for initial render. On mobile: nav bar is bottom strip. On desktop: nav bar is left sidebar icons.
- **Output:** Knit Controller managing the persistent HUD ScreenGui.
- **Integration:** Depends on UIController, UIConfig, Button, Assets, Remotes. Calls `UIController.OpenPanel` on nav button click.
- **DoD:**
  - Currency updates within one frame of receiving `StatUpdated` remote.
  - Energy bar displays correct fill ratio (current/max).
  - Nav buttons are at least `MIN_TAP_SIZE` on all platforms.
  - Desktop shows left sidebar; mobile shows bottom bar (test by mocking viewport size).

---

### C02 — BattleController.lua
- [ ] **File:** `src/client/Controllers/BattleController.lua`
- **Instruction:** Render battle UI and send player actions. Listen on `Remotes.Battle.StartBattle` → show battle panel with combatant frames (sprite from Assets, HP bar, status icons). Listen on `Remotes.Battle.BattleUpdate` → update HP bars, apply damage number tween, show status effect icons. Listen on `Remotes.Battle.BattleEnd` → show reward summary, then close panel after 3 seconds. During `ACTION_SELECT` phase: render 4 skill buttons (from player's equipped skills), Capture button (if wild hunt), Flee button. Pressing a skill fires `Remotes.Battle.ActionSelected` with `{ type="skill", skillId }`. On mobile: skill buttons are in a 2×2 grid at bottom. On desktop: skill buttons are in a right panel.
- **Output:** Knit Controller for battle rendering and input relay.
- **Integration:** Depends on UIController, Window, Button, UIConfig, Assets, Remotes. Does NOT compute damage — all state comes from server.
- **DoD:**
  - HP bar updates smoothly (tween) when `BattleUpdate` arrives.
  - Pressing a skill button fires exactly one remote per press.
  - Skill buttons are disabled after pressing until next `BattleUpdate` with `ACTION_SELECT` phase.
  - `BattleEnd` reward summary displays silver, XP, and item icons.

---

### C03 — PetPanelController.lua
- [ ] **File:** `src/client/Controllers/PetPanelController.lua`
- **Instruction:** Render pet roster and management UI. Opened via HUD nav. Fetch pet data from `Remotes.Player.DataLoaded` snapshot. Show roster as ScrollList of pet cards (species sprite, level, HP bar, element badge). Selecting a pet shows detail view: stats (from SpeciesConfig growth, displayed computed), equipped skills, accessory slots, rename input, equip/unequip button. Equip sends `Remotes.Pet.EquipPet`. Unequip sends `Remotes.Pet.UnequipPet`. Skill equip opens a sub-panel with learnable skills; selecting sends `Remotes.Pet.LearnSkill`.
- **Output:** Knit Controller for full pet management UI.
- **Integration:** Depends on UIController, Window, ScrollList, Button, UIConfig, Assets, Remotes, SpeciesConfig (client-accessible for display only).
- **DoD:**
  - Roster loads on panel open without additional server round-trip (uses DataLoaded snapshot).
  - Equipping a pet updates HUD active pet bar within one `StatUpdated` cycle.
  - Detail view shows correctly computed stats (level × growth, not raw base).
  - Skill equip sub-panel shows only skills in the species' SkillPool.

---

### C04 — InventoryController.lua
- [ ] **File:** `src/client/Controllers/InventoryController.lua`
- **Instruction:** Render inventory UI. Opened via HUD nav. Display items as ScrollList grouped by category (tabs: All, Consumables, Materials, Equipment, Key Items). Each row: item icon (Assets.Images.Items key), name, quantity, use button (for consumables only). Pressing use: if in battle, fires `Remotes.Battle.ActionSelected` with `{ type="item", itemId }`; if out of battle, fires a dedicated `UseItem` remote. Show item detail tooltip on long-press (mobile) or hover (desktop) with description from ItemConfig. Filter/sort by category tab.
- **Output:** Knit Controller for inventory browsing and item use.
- **Integration:** Depends on UIController, Window, ScrollList, Button, UIConfig, Assets, Remotes, ItemConfig.
- **DoD:**
  - Category tabs correctly filter items.
  - Use button only appears for `"consumable"` category items.
  - Tooltip appears on hover (desktop) and does not appear on tap without long-press (mobile).
  - Quantity updates immediately after use (optimistic update, corrected by `StatUpdated`).

---

### C05 — ShopController.lua
- [ ] **File:** `src/client/Controllers/ShopController.lua`
- **Instruction:** Render NPC shop UI. Opened when `UIController.OpenPanel("Shop", { npcId })` is called. Fetch inventory from `Remotes.Shop.OpenShop` (server returns current stock). Display as ScrollList: item icon, name, price (show silver or gold icon), stock count, buy button. Pressing buy: show confirm dialog with total cost, on confirm fire `Remotes.Shop.PurchaseItem`. Sell tab: show player inventory with sell prices; pressing sell fires `Remotes.Shop.SellItem`. Disable buy button if player cannot afford or stock is 0.
- **Output:** Knit Controller for shop buy/sell UI.
- **Integration:** Depends on UIController, Window, ScrollList, Button, UIConfig, Assets, Remotes, ItemConfig.
- **DoD:**
  - Buy button disabled when player silver/gold < item price.
  - Confirm dialog appears before purchase executes.
  - Selling an item updates inventory display after `StatUpdated` remote.
  - Stock count reflects server response; does not allow buying 0-stock items.

---

### C06 — QuestController.lua
- [ ] **File:** `src/client/Controllers/QuestController.lua`
- **Instruction:** Render quest log UI. Opened via HUD nav. Display active daily quests with: title, description, progress bar (`current/required`), reward preview (silver, items). Listen on `Remotes.Quest.QuestUpdated` to refresh progress bars. Listen on `Remotes.Quest.QuestComplete` to show completion animation and remove quest from active list. Show empty state message when no quests active. Include a "Completed Today" section showing finished quests.
- **Output:** Knit Controller for quest log display.
- **Integration:** Depends on UIController, Window, ScrollList, UIConfig, Remotes.
- **DoD:**
  - Progress bar updates on `QuestUpdated` without reopening the panel.
  - Completion animation plays and quest moves to "Completed Today" section.
  - Reward preview matches the actual quest reward config.
  - Empty state renders correctly when `DailyQuestIds` is empty.

---

### C07 — CodexController.lua
- [ ] **File:** `src/client/Controllers/CodexController.lua`
- **Instruction:** Render species codex. Opened via HUD nav. Display as grid (2-col mobile, 3-col tablet, 4-col desktop) of species cards: sprite, name, rarity badge, element badge. Undiscovered species show silhouette and "???" name. On card select: show detail view with stats (from SpeciesConfig), lore text, capture count, skills list. Show completion counter at top: "X / Y species discovered". Listen on `Remotes.Player.DataLoaded` for initial codex data.
- **Output:** Knit Controller for codex display.
- **Integration:** Depends on UIController, Window, ScrollList, UIConfig, Assets, Remotes, SpeciesConfig, RarityUtils (color).
- **DoD:**
  - Undiscovered species render as silhouette without revealing name or stats.
  - Completion counter matches `CodexService.GetCompletion` output.
  - Grid layout changes column count per platform breakpoint.
  - Element badge color matches `UIConfig.COLORS` element entries.

---

### C08 — MapController.lua
- [ ] **File:** `src/client/Controllers/MapController.lua`
- **Instruction:** Render world map panel. Opened via HUD nav. Display zone cards with: zone name, level range, current weather icon (listen on `Remotes.Zone.WeatherChanged`), lock state (greyed if entry requirement not met). Selecting an available zone: show zone detail with dungeon list. Selecting a dungeon: show dungeon info (waves, boss, rewards) and "Enter" button. Enter button fires a server remote to call `DungeonService.StartDungeon`. Show `DungeonRunsToday / DAILY_DUNGEON_LIMIT` counter per dungeon.
- **Output:** Knit Controller for world map and zone/dungeon navigation.
- **Integration:** Depends on UIController, Window, Button, UIConfig, Assets, Remotes, ZoneConfig, GameConfig.
- **DoD:**
  - Weather icon updates when `WeatherChanged` remote fires.
  - Locked zones render as greyed with level requirement tooltip.
  - Dungeon counter updates after each dungeon run.
  - "Enter" button is disabled after daily limit is reached.

---

### C09 — LeaderboardController.lua
- [ ] **File:** `src/client/Controllers/LeaderboardController.lua`
- **Instruction:** Render leaderboard panel. Three tabs: Total XP, Monsters Defeated, Dungeons Completed. On tab open: fire a `GetLeaderboard` remote (or use a RemoteFunction) to fetch top 10 from `LeaderboardService.GetTopN`. Display as ranked list: rank number, player display name, score. Highlight local player's row. Show loading spinner while awaiting response. Handle empty or error state gracefully.
- **Output:** Knit Controller for leaderboard display.
- **Integration:** Depends on UIController, Window, ScrollList, UIConfig, Remotes, LeaderboardService (via RemoteFunction).
- **DoD:**
  - Tab switch re-fetches from server (no stale cache shown for wrong category).
  - Local player row is visually distinct (background color or bold text).
  - Loading spinner shows during fetch and hides on data arrival.
  - Error state (DataStore timeout) shows friendly message, not a Lua error.

---

### C10 — MarketplaceController.lua
- [ ] **File:** `src/client/Controllers/MarketplaceController.lua`
- **Instruction:** Render the in-game shop for Game Passes and Developer Products. Show pass cards: name, description, price (robux), owned badge if already purchased. Pressing buy calls `MarketplaceService:PromptGamePassPurchase` (client-side Roblox API) or `PromptProductPurchase` for products. Listen on `Remotes.Player.StatUpdated` to refresh owned pass badges after purchase. Show product packs: gold bundles, energy restore. Group into tabs: Passes, Gold, Energy, Support.
- **Output:** Knit Controller for Robux shop UI.
- **Integration:** Depends on UIController, Window, Button, UIConfig, Assets, Remotes. Uses client-side Roblox MarketplaceService for prompts; actual grant is server-side via S18.
- **DoD:**
  - Owned passes show "Owned" badge and buy button is hidden.
  - `PromptGamePassPurchase` is called with the correct ID from `Assets.GamePasses`.
  - `PromptProductPurchase` is called with correct ID from `Assets.Products`.
  - After server grants product, `StatUpdated` triggers UI refresh.

---

## Integration Checklist

These cross-cutting concerns must be verified after all phases are complete.

- [ ] **Asset ID Centralization**: `grep -r "[0-9]\{6,\}" src/` returns zero results outside `Assets.lua`. No hardcoded numeric IDs anywhere else.
- [ ] **Remote Discipline**: `grep -r "RemoteEvent.new\|RemoteFunction.new" src/` returns zero results outside `Remotes.lua`.
- [ ] **Server Authority**: No damage, XP, or currency calculation exists in any client Controller. Controllers only relay actions and render state.
- [ ] **Cross-Platform Coverage**: HUD, Battle, PetPanel, Shop, Inventory, Codex, Map panels all tested on mobile (< 480px), tablet (768px), and desktop (> 1024px) viewport sizes in Studio.
- [ ] **Energy Regen (Lazy)**: No server loop polling energy. Regen applied only in `EnergyService.GetEnergy` and `SpendEnergy`.
- [ ] **Daily Reset Chain**: `QuestService.AssignDailyQuests` and `DungeonService` both use `TimeUtils.IsSameDay` and reset correctly after midnight.
- [ ] **Idempotent Receipts**: `MarketplaceService.ProcessReceipt` verified to not double-grant by simulating duplicate `PurchaseId`.
- [ ] **Leaderboard Write Rate**: Verified `LeaderboardService` debounce prevents more than 1 write per 60s per player per category.
- [ ] **Schema Migration**: Adding a new key to `Types.newPlayerData()` does not error on existing profiles with old data.
- [ ] **Boss Phase Transitions**: 2-phase and 3-phase bosses both transition correctly at configured HP thresholds.
