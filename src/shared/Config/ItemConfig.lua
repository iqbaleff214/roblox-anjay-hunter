-- src/shared/Config/ItemConfig.lua
-- All 53 items from ITEM.md. Each entry keyed by item_id.
-- BuyPrice / SellPrice: { Silver = N } | { Gold = N } | { Silver = N, Gold = N } | nil (cannot buy/sell).
-- Effects: machine-readable array consumed by ItemService. Empty table {} for collectibles.
-- IconId: key into Assets.Images.Items.

return {

	-- =========================================================================
	-- CONSUMABLE — RECOVERY
	-- =========================================================================

	hp_potion_small = {
		Name        = "HP Potion (Small)",
		Category    = "consumable",
		SubCategory = "recovery",
		StackMax    = 999,
		BuyPrice    = { Silver = 30 },
		SellPrice   = { Silver = 3 },
		Effects     = { { type = "heal_hp", amount = 0.30, target = "pet" } },
		Acquisition = { "item_shop_hub", "wild_beast_drop_10pct", "dungeon_monster_drop_8pct", "expedition_medium" },
		IconId      = "hp_potion_small",
		Description = "Restores 30% of the target pet's Max HP.",
	},

	hp_potion_large = {
		Name        = "HP Potion (Large)",
		Category    = "consumable",
		SubCategory = "recovery",
		StackMax    = 999,
		BuyPrice    = { Silver = 150 },
		SellPrice   = { Silver = 15 },
		Effects     = { { type = "heal_hp", amount = 1.00, target = "pet" } },
		Acquisition = { "item_shop_hub", "dungeon_monster_drop_3pct", "expedition_long" },
		IconId      = "hp_potion_large",
		Description = "Restores 100% of the target pet's Max HP.",
	},

	stamina_potion = {
		Name        = "Stamina Potion",
		Category    = "consumable",
		SubCategory = "recovery",
		StackMax    = 999,
		BuyPrice    = { Silver = 50 },
		SellPrice   = { Silver = 5 },
		Effects     = { { type = "restore_stamina", amount = 0.50, target = "pet" } },
		Acquisition = { "item_shop_hub", "dungeon_monster_drop_5pct" },
		IconId      = "stamina_potion",
		Description = "Restores 50% of the target pet's Max Stamina.",
	},

	energy_drink = {
		Name        = "Energy Drink",
		Category    = "consumable",
		SubCategory = "recovery",
		StackMax    = 999,
		BuyPrice    = { Silver = 500 },
		SellPrice   = { Silver = 50 },
		Effects     = { { type = "restore_energy", amount = 1.00, target = "player" } },
		Acquisition = { "item_shop_hub", "dungeon_monster_drop_3pct", "roblox_premium_daily" },
		IconId      = "energy_drink",
		Description = "Instantly fills Hunt Energy to maximum (100).",
	},

	-- =========================================================================
	-- CONSUMABLE — CAPTURE
	-- =========================================================================

	basic_trap = {
		Name        = "Basic Trap",
		Category    = "consumable",
		SubCategory = "capture",
		StackMax    = 999,
		BuyPrice    = { Silver = 50 },
		SellPrice   = { Silver = 5 },
		Effects     = { { type = "capture_attempt", base_rate = 0.30, target = "enemy", tier = "basic" } },
		Acquisition = { "item_shop_hub", "achievement_first_capture_x5", "wild_beast_drop_10pct", "expedition_short" },
		IconId      = "basic_trap",
		Description = "30% base capture rate. Cannot be used in dungeons.",
	},

	iron_trap = {
		Name        = "Iron Trap",
		Category    = "consumable",
		SubCategory = "capture",
		StackMax    = 999,
		BuyPrice    = { Silver = 200 },
		SellPrice   = { Silver = 20 },
		Effects     = { { type = "capture_attempt", base_rate = 0.50, target = "enemy", tier = "iron" } },
		Acquisition = { "item_shop_hub", "daily_quest_capture_reward_x3", "expedition_medium" },
		IconId      = "iron_trap",
		Description = "50% base capture rate. Minimum tier for dungeon captures.",
	},

	gold_trap = {
		Name        = "Gold Trap",
		Category    = "consumable",
		SubCategory = "capture",
		StackMax    = 999,
		BuyPrice    = { Gold = 50 },
		SellPrice   = { Gold = 5 },
		Effects     = { { type = "capture_attempt", base_rate = 0.70, target = "enemy", tier = "gold" } },
		Acquisition = { "item_shop_hub", "expedition_long_rare", "event_shop" },
		IconId      = "gold_trap",
		Description = "70% base capture rate. Recommended for Rare rarity beasts.",
	},

	legend_trap = {
		Name        = "Legend Trap",
		Category    = "consumable",
		SubCategory = "capture",
		StackMax    = 999,
		BuyPrice    = { Gold = 300 },
		SellPrice   = { Gold = 30 },
		Effects     = { { type = "capture_attempt", base_rate = 0.90, target = "enemy", tier = "legend" } },
		Acquisition = { "item_shop_hub", "dungeon_boss_drop_5pct", "bounty_lich_king_x1", "abyss_first_clear" },
		IconId      = "legend_trap",
		Description = "90% base capture rate. Best option for Legendary rarity beasts.",
	},

	-- =========================================================================
	-- CONSUMABLE — EVOLUTION MATERIAL
	-- =========================================================================

	evolution_shard = {
		Name        = "Evolution Shard",
		Category    = "consumable",
		SubCategory = "evolution_material",
		StackMax    = 999,
		BuyPrice    = { Silver = 500, Gold = 10 },
		SellPrice   = { Silver = 50 },
		Effects     = { { type = "evolution_material_stage2", target = "pet" } },
		Acquisition = { "item_shop_hub", "dungeon_boss_drop_60pct", "daily_quest_x1", "bounty_x2", "achievement_pet_lv100_x1" },
		IconId      = "evolution_shard",
		Description = "Required (×1) for Base → Stage 2 evolution. Also costs 500 Silver.",
	},

	evolution_crystal = {
		Name        = "Evolution Crystal",
		Category    = "consumable",
		SubCategory = "evolution_material",
		StackMax    = 999,
		BuyPrice    = { Gold = 100 },
		SellPrice   = { Gold = 10 },
		Effects     = { { type = "evolution_material_stage3", target = "pet" } },
		Acquisition = { "item_shop_hub", "dungeon_boss_drop_20pct" },
		IconId      = "evolution_crystal",
		Description = "Required (×1) for Stage 2 → Stage 3 evolution alongside the species material. Also costs 300 Gold.",
	},

	reimibue_stone = {
		Name        = "Re-imbue Stone",
		Category    = "consumable",
		SubCategory = "evolution_material",
		StackMax    = 999,
		BuyPrice    = { Gold = 200 },
		SellPrice   = { Gold = 20 },
		Effects     = { { type = "reimbue_element", target = "pet" } },
		Acquisition = { "item_shop_hub" },
		IconId      = "reimibue_stone",
		Description = "Removes a pet's element at level 50+, allowing a new element to be selected.",
	},

	-- =========================================================================
	-- CONSUMABLE — SPECIES MATERIAL  (012–020, 029–038)
	-- =========================================================================

	treant_heartwood = {
		Name        = "Treant Heartwood",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 200 },
		Effects     = { { type = "species_material_stage3", species = "treant", target = "pet" } },
		Acquisition = { "elder_treant_boss_15pct", "treant_dungeon_monster_2pct" },
		IconId      = "treant_heartwood",
		Description = "Required for Treant → Ancient Treant (Stage 3) evolution.",
	},

	goblin_war_crown = {
		Name        = "Goblin War Crown",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 50 },
		Effects     = { { type = "species_material_stage3", species = "goblin", target = "pet" } },
		Acquisition = { "goblin_warchief_boss_15pct" },
		IconId      = "goblin_war_crown",
		Description = "Required for Goblin → Goblin Warchief (Stage 3) evolution.",
	},

	lichs_phylactery = {
		Name        = "Lich's Phylactery",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 75 },
		Effects     = { { type = "species_material_stage3", species = "skeleton", target = "pet" } },
		Acquisition = { "lich_king_boss_15pct" },
		IconId      = "lichs_phylactery",
		Description = "Required for Skeleton → Lich (Stage 3) evolution.",
	},

	orc_warbrand_frag = {
		Name        = "Orc Warbrand Fragment",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 150 },
		Effects     = { { type = "species_material_stage3", species = "orc", target = "pet" } },
		Acquisition = { "orc_overlord_boss_15pct" },
		IconId      = "orc_warbrand_frag",
		Description = "Required for Orc → Orc Overlord (Stage 3) evolution.",
	},

	abyss_essence = {
		Name        = "Abyss Essence",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 300 },
		Effects     = { { type = "species_material_stage3", species = "demon", target = "pet" } },
		Acquisition = { "abyssal_demon_lord_boss_15pct" },
		IconId      = "abyss_essence",
		Description = "Required for Demon → Abyssal Demon (Stage 3) evolution.",
	},

	petrified_eye = {
		Name        = "Petrified Eye",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 300 },
		Effects     = { { type = "species_material_stage3", species = "basilisk", target = "pet" } },
		Acquisition = { "abyssal_demon_lord_boss_15pct" },
		IconId      = "petrified_eye",
		Description = "Required for Basilisk → Gorgon (Stage 3) evolution.",
	},

	spirit_orb = {
		Name        = "Spirit Orb",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 300 },
		Effects     = { { type = "species_material_stage3", species = "kitsune", target = "pet" } },
		Acquisition = { "abyssal_demon_lord_boss_15pct" },
		IconId      = "spirit_orb",
		Description = "Required for Kitsune → Celestial Kitsune (Stage 3) evolution.",
	},

	blood_moon_stone = {
		Name        = "Blood Moon Stone",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 300 },
		Effects     = { { type = "species_material_stage3", species = "werewolf", target = "pet" } },
		Acquisition = { "abyssal_demon_lord_boss_15pct" },
		IconId      = "blood_moon_stone",
		Description = "Required for Werewolf → Lycan Lord (Stage 3) evolution.",
	},

	storm_feather = {
		Name        = "Storm Feather",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 500 },
		Effects     = { { type = "species_material_stage3", species = "thunderbird", target = "pet" } },
		Acquisition = { "sky_sovereign_world_boss_5pct", "seasonal_event_chest_3pct" },
		IconId      = "storm_feather",
		Description = "Required for Thunderbird → Sky Sovereign (Stage 3) evolution. Rarest species material.",
	},

	-- =========================================================================
	-- CONSUMABLE — BOOST
	-- =========================================================================

	xp_boost_crystal = {
		Name        = "XP Boost Crystal",
		Category    = "consumable",
		SubCategory = "boost",
		StackMax    = 99,
		BuyPrice    = nil,  -- Robux product only; no Silver/Gold price
		SellPrice   = nil,
		Effects     = { { type = "xp_boost", multiplier = 3, duration_seconds = 3600, target = "player" } },
		Acquisition = { "robux_product_49r" },
		IconId      = "xp_boost_crystal",
		Description = "All pets earn 3× XP for 1 real-time hour.",
	},

	capture_booster = {
		Name        = "Capture Booster",
		Category    = "consumable",
		SubCategory = "boost",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = nil,
		Effects     = { { type = "capture_boost", bonus_rate = 0.20, charges = 5, target = "player" } },
		Acquisition = { "robux_product_19r" },
		IconId      = "capture_booster",
		Description = "+20% base capture rate for the next 5 capture attempts.",
	},

	dungeon_key = {
		Name        = "Dungeon Key",
		Category    = "consumable",
		SubCategory = "boost",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = nil,
		Effects     = { { type = "dungeon_run_extra", count = 1, target = "player" } },
		Acquisition = { "robux_product_39r" },
		IconId      = "dungeon_key",
		Description = "Grants +1 dungeon run today for any dungeon, bypassing the daily cap.",
	},

	-- =========================================================================
	-- COLLECTIBLE — BOSS TROPHIES  (024–028)
	-- =========================================================================

	goblin_chiefs_trophy = {
		Name        = "Goblin Chief's Trophy",
		Category    = "collectible",
		SubCategory = "trophy",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Silver = 500 },
		Effects     = {},
		Acquisition = { "goblin_warchief_boss_40pct" },
		IconId      = "goblin_chiefs_trophy",
		Description = "A crude war banner from the Goblin Warchief. Sell for 500 Silver.",
	},

	ancient_bone_relic = {
		Name        = "Ancient Bone Relic",
		Category    = "collectible",
		SubCategory = "trophy",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Silver = 1500 },
		Effects     = {},
		Acquisition = { "lich_king_boss_40pct" },
		IconId      = "ancient_bone_relic",
		Description = "A carved bone relic from the Lich King. Sell for 1,500 Silver.",
	},

	enchanted_bark_rune = {
		Name        = "Enchanted Bark Rune",
		Category    = "collectible",
		SubCategory = "trophy",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Silver = 2000 },
		Effects     = {},
		Acquisition = { "elder_treant_boss_40pct" },
		IconId      = "enchanted_bark_rune",
		Description = "A druidic bark disc from the Elder Treant. Sell for 2,000 Silver.",
	},

	volcanic_forge_shard = {
		Name        = "Volcanic Forge Shard",
		Category    = "collectible",
		SubCategory = "trophy",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Silver = 5000 },
		Effects     = {},
		Acquisition = { "orc_overlord_boss_40pct" },
		IconId      = "volcanic_forge_shard",
		Description = "Magma-forged metal from the Orc Overlord. Sell for 5,000 Silver.",
	},

	void_crystal = {
		Name        = "Void Crystal",
		Category    = "collectible",
		SubCategory = "trophy",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Silver = 15000 },
		Effects     = {},
		Acquisition = { "abyssal_demon_lord_boss_40pct" },
		IconId      = "void_crystal",
		Description = "A pitch-black crystal from the Abyssal Demon Lord. Sell for 15,000 Silver.",
	},

	-- =========================================================================
	-- CONSUMABLE — SPECIES MATERIAL  (029–038 continued)
	-- =========================================================================

	dragon_scale = {
		Name        = "Dragon Scale",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 400 },
		Effects     = { { type = "species_material_stage3", species = "dragon", target = "pet" } },
		Acquisition = { "wild_dragon_battle_10pct", "first_dragon_capture_guaranteed" },
		IconId      = "dragon_scale",
		Description = "Required for Dragon → Elder Dragon (Stage 3) evolution.",
	},

	phoenix_ash = {
		Name        = "Phoenix Ash",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 400 },
		Effects     = { { type = "species_material_stage3", species = "phoenix", target = "pet" } },
		Acquisition = { "wild_phoenix_battle_10pct", "first_phoenix_capture_guaranteed", "orc_overlord_boss_3pct" },
		IconId      = "phoenix_ash",
		Description = "Required for Phoenix → Eternal Phoenix (Stage 3) evolution.",
	},

	shadow_fang = {
		Name        = "Shadow Fang",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 150 },
		Effects     = { { type = "species_material_stage3", species = "tiger", target = "pet" } },
		Acquisition = { "wild_white_tiger_stage2_8pct", "lich_king_boss_5pct" },
		IconId      = "shadow_fang",
		Description = "Required for Tiger → Shadow Tiger (Stage 3) evolution.",
	},

	kings_mane_lock = {
		Name        = "King's Mane Lock",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 150 },
		Effects     = { { type = "species_material_stage3", species = "lion", target = "pet" } },
		Acquisition = { "wild_battle_lion_stage2_8pct", "elder_treant_boss_5pct" },
		IconId      = "kings_mane_lock",
		Description = "Required for Lion → Pride Sovereign (Stage 3) evolution.",
	},

	tempest_quill = {
		Name        = "Tempest Quill",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 100 },
		Effects     = { { type = "species_material_stage3", species = "eagle", target = "pet" } },
		Acquisition = { "wild_war_eagle_stage2_8pct", "seasonal_sky_event_chest" },
		IconId      = "tempest_quill",
		Description = "Required for Eagle → Tempest Eagle (Stage 3) evolution.",
	},

	void_slime_core = {
		Name        = "Void Slime Core",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 30 },
		Effects     = { { type = "species_material_stage3", species = "slime", target = "pet" } },
		Acquisition = { "forest_cave_slime_kill_3pct", "goblin_warchief_first_clear_guaranteed" },
		IconId      = "void_slime_core",
		Description = "Required for Slime → Slime Titan (Stage 3) evolution.",
	},

	ancient_shell_plate = {
		Name        = "Ancient Shell Plate",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 100 },
		Effects     = { { type = "species_material_stage3", species = "turtle", target = "pet" } },
		Acquisition = { "wild_armored_turtle_stage2_8pct", "mountain_ruins_skeleton_kill_2pct" },
		IconId      = "ancient_shell_plate",
		Description = "Required for Turtle → Titan Turtle (Stage 3) evolution.",
	},

	fox_spirit_bead = {
		Name        = "Fox Spirit Bead",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 50 },
		Effects     = { { type = "species_material_stage3", species = "fox", target = "pet" } },
		Acquisition = { "wild_trickster_fox_stage2_8pct", "hostile_fairy_kill_2pct" },
		IconId      = "fox_spirit_bead",
		Description = "Required for Fox → Spirit Fox (Stage 3) evolution.",
	},

	dire_pelt = {
		Name        = "Dire Pelt",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 50 },
		Effects     = { { type = "species_material_stage3", species = "dog", target = "pet" } },
		Acquisition = { "wild_wolf_stage2_8pct", "goblin_kill_2pct" },
		IconId      = "dire_pelt",
		Description = "Required for Dog → Dire Wolf (Stage 3) evolution.",
	},

	anaconda_venom_gem = {
		Name        = "Anaconda Venom Gem",
		Category    = "consumable",
		SubCategory = "species_material",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Gold = 200 },
		Effects     = { { type = "species_material_stage3", species = "anaconda", target = "pet" } },
		Acquisition = { "wild_king_anaconda_stage2_8pct", "abyss_demon_kill_3pct" },
		IconId      = "anaconda_venom_gem",
		Description = "Required for Anaconda → Leviathan Serpent (Stage 3) evolution.",
	},

	-- =========================================================================
	-- CONSUMABLE — STATUS CURE
	-- =========================================================================

	antidote = {
		Name        = "Antidote",
		Category    = "consumable",
		SubCategory = "status_cure",
		StackMax    = 999,
		BuyPrice    = { Silver = 100 },
		SellPrice   = { Silver = 10 },
		Effects     = { { type = "cure_status", statuses = { "Poison", "Burn" }, target = "pet" } },
		Acquisition = { "item_shop_hub", "wild_beast_drop_5pct", "dungeon_monster_drop_4pct" },
		IconId      = "antidote",
		Description = "Removes all Poison and Burn from the target pet.",
	},

	remedy = {
		Name        = "Remedy",
		Category    = "consumable",
		SubCategory = "status_cure",
		StackMax    = 999,
		BuyPrice    = { Silver = 150 },
		SellPrice   = { Silver = 15 },
		Effects     = { { type = "cure_status", statuses = { "Blind", "Shock" }, target = "pet" } },
		Acquisition = { "item_shop_hub", "dungeon_monster_drop_3pct" },
		IconId      = "remedy",
		Description = "Removes all Blind and Shock from the target pet.",
	},

	warming_herb = {
		Name        = "Warming Herb",
		Category    = "consumable",
		SubCategory = "status_cure",
		StackMax    = 999,
		BuyPrice    = { Silver = 100 },
		SellPrice   = { Silver = 10 },
		Effects     = { { type = "cure_status", statuses = { "Freeze", "Bind" }, target = "pet" } },
		Acquisition = { "item_shop_hub", "wild_beast_drop_5pct", "dungeon_monster_drop_3pct" },
		IconId      = "warming_herb",
		Description = "Removes Freeze and Bind from the target pet. In-battle use only.",
	},

	full_cure = {
		Name        = "Full Cure",
		Category    = "consumable",
		SubCategory = "status_cure",
		StackMax    = 999,
		BuyPrice    = { Silver = 500, Gold = 5 },
		SellPrice   = { Silver = 50 },
		Effects     = { { type = "cure_status_all", target = "pet" } },
		Acquisition = { "item_shop_hub", "dungeon_boss_drop_10pct", "rare_bounty_reward" },
		IconId      = "full_cure",
		Description = "Removes all negative status effects (Poison, Burn, Freeze, Bind, Blind, Shock, Armor Break, Taunt).",
	},

	-- =========================================================================
	-- CONSUMABLE — STAT BOOSTER
	-- =========================================================================

	power_herb = {
		Name        = "Power Herb",
		Category    = "consumable",
		SubCategory = "stat_booster",
		StackMax    = 999,
		BuyPrice    = { Silver = 200 },
		SellPrice   = { Silver = 20 },
		Effects     = { { type = "stat_buff", stat = "ATK", amount = 0.25, duration_turns = 3, target = "pet" } },
		Acquisition = { "item_shop_hub", "dungeon_monster_drop_3pct", "expedition_medium" },
		IconId      = "power_herb",
		Description = "+25% ATK for 3 turns. Stacks additively.",
	},

	guard_stone = {
		Name        = "Guard Stone",
		Category    = "consumable",
		SubCategory = "stat_booster",
		StackMax    = 999,
		BuyPrice    = { Silver = 200 },
		SellPrice   = { Silver = 20 },
		Effects     = { { type = "stat_buff", stat = "DEF", amount = 0.25, duration_turns = 3, target = "pet" } },
		Acquisition = { "item_shop_hub", "dungeon_monster_drop_3pct", "expedition_medium" },
		IconId      = "guard_stone",
		Description = "+25% DEF for 3 turns. Stacks additively.",
	},

	swift_root = {
		Name        = "Swift Root",
		Category    = "consumable",
		SubCategory = "stat_booster",
		StackMax    = 999,
		BuyPrice    = { Silver = 200 },
		SellPrice   = { Silver = 20 },
		Effects     = { { type = "stat_buff", stat = "SPD", amount = 0.25, duration_turns = 3, target = "pet" } },
		Acquisition = { "item_shop_hub", "dungeon_monster_drop_3pct", "expedition_medium" },
		IconId      = "swift_root",
		Description = "+25% SPD for 3 turns. Applied at next TURN_START sort.",
	},

	-- =========================================================================
	-- CONSUMABLE — REVIVAL
	-- =========================================================================

	revive_seed = {
		Name        = "Revive Seed",
		Category    = "consumable",
		SubCategory = "revival",
		StackMax    = 99,
		BuyPrice    = { Gold = 30 },
		SellPrice   = { Gold = 5 },
		Effects     = { { type = "revive", heal_ratio = 0.50, target = "pet" } },
		Acquisition = { "item_shop_hub", "dungeon_boss_drop_8pct", "expedition_long_rare" },
		IconId      = "revive_seed",
		Description = "Revives a fainted pet at 50% Max HP. Costs a turn in all battle types.",
	},

	-- =========================================================================
	-- CONSUMABLE — OVERWORLD UTILITY
	-- =========================================================================

	beast_lure = {
		Name        = "Beast Lure",
		Category    = "consumable",
		SubCategory = "overworld_utility",
		StackMax    = 99,
		BuyPrice    = { Silver = 300 },
		SellPrice   = { Silver = 30 },
		Effects     = {
			{
				type             = "lure_active",
				duration_seconds = 1800,
				uncommon_mult    = 1.5,
				rare_mult        = 2.0,
				epic_mult        = 1.5,
				target           = "player",
			},
		},
		Acquisition = { "item_shop_hub", "expedition_long_rare", "seasonal_event_shop" },
		IconId      = "beast_lure",
		Description = "For 30 minutes: Uncommon ×1.5, Rare ×2.0, Epic ×1.5 spawn weight. Mutually exclusive with Beast Repellent.",
	},

	repellent = {
		Name        = "Beast Repellent",
		Category    = "consumable",
		SubCategory = "overworld_utility",
		StackMax    = 99,
		BuyPrice    = { Silver = 200 },
		SellPrice   = { Silver = 20 },
		Effects     = {
			{
				type                  = "repellent_active",
				duration_seconds      = 1800,
				encounter_reduction   = 0.50,
				target                = "player",
			},
		},
		Acquisition = { "item_shop_hub" },
		IconId      = "repellent",
		Description = "For 30 minutes: wild beast encounter probability reduced by 50%. Mutually exclusive with Beast Lure.",
	},

	-- =========================================================================
	-- COLLECTIBLE — EVENT CURRENCY
	-- =========================================================================

	festival_coin = {
		Name        = "Festival Coin",
		Category    = "collectible",
		SubCategory = "event_currency",
		StackMax    = 9999,
		BuyPrice    = nil,
		SellPrice   = nil,
		Effects     = {},
		Acquisition = { "all_battle_types_during_event", "event_daily_quests", "seasonal_battle_pass" },
		IconId      = "festival_coin",
		Description = "Seasonal event currency. Spent at the event shop NPC. Zeroed at event end.",
	},

	-- =========================================================================
	-- CONSUMABLE — BOOST (continued)
	-- =========================================================================

	lucky_charm = {
		Name        = "Lucky Charm",
		Category    = "consumable",
		SubCategory = "boost",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = nil,
		Effects     = { { type = "lucky_charm_active", duration_seconds = 3600, drop_multiplier = 1.10, target = "player" } },
		Acquisition = { "robux_product_29r", "battle_pass_paid_tier_20" },
		IconId      = "lucky_charm",
		Description = "For 1 hour: all drop rates ×1.10 multiplicatively.",
	},

	-- =========================================================================
	-- COLLECTIBLE — WORLD DROPS  (051–053)
	-- =========================================================================

	shiny_scale = {
		Name        = "Shiny Scale",
		Category    = "collectible",
		SubCategory = "trophy",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Silver = 200 },
		Effects     = {},
		Acquisition = { "wild_scaled_species_battle_victory_2pct" },
		IconId      = "shiny_scale",
		Description = "Drops from scaled beast species (Snake, Turtle, Dragon, Koi, Anaconda) on victory. Sell for 200 Silver.",
	},

	emerald_feather = {
		Name        = "Emerald Feather",
		Category    = "collectible",
		SubCategory = "trophy",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Silver = 500 },
		Effects     = {},
		Acquisition = { "wild_wind_or_nature_beast_2pct", "wild_avian_species_3pct" },
		IconId      = "emerald_feather",
		Description = "Drops from Wind/Nature beasts (2%) or avian species (3%) on victory. Sell for 500 Silver.",
	},

	void_shard = {
		Name        = "Void Shard",
		Category    = "collectible",
		SubCategory = "trophy",
		StackMax    = 99,
		BuyPrice    = nil,
		SellPrice   = { Silver = 3000 },
		Effects     = {},
		Acquisition = { "abyss_zone_wild_beast_3pct", "abyss_zone_dark_element_beast_5pct" },
		IconId      = "void_shard",
		Description = "Drops from any Abyss zone beast (3%) or Dark element Abyss beast (5%). Sell for 3,000 Silver.",
	},
}
