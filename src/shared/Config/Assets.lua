-- src/shared/Config/Assets.lua
-- Single source of truth for all Roblox asset IDs.
-- Every value is a placeholder (0) until a real ID is uploaded to Roblox.
-- No script outside this file may contain a bare numeric asset ID.

return {

	-- =========================================================================
	-- MODELS
	-- rbxassetid values for voxel model assets (MeshId / InsertService)
	-- =========================================================================

	Models = {

		-- Pet species models, keyed as {species}_stage{n}.
		-- Stage 1 = base form, Stage 2 = first evolution, Stage 3 = final evolution.
		Pets = {

			-- Starter Plains species
			dog_stage1       = 0,  -- Dog
			dog_stage2       = 0,  -- Wolf
			dog_stage3       = 0,  -- Dire Wolf

			cat_stage1       = 0,
			cat_stage2       = 0,
			cat_stage3       = 0,

			pig_stage1       = 0,
			pig_stage2       = 0,
			pig_stage3       = 0,

			horse_stage1     = 0,
			horse_stage2     = 0,
			horse_stage3     = 0,

			rabbit_stage1    = 0,
			rabbit_stage2    = 0,
			rabbit_stage3    = 0,

			slime_stage1     = 0,
			slime_stage2     = 0,
			slime_stage3     = 0,

			duck_stage1      = 0,
			duck_stage2      = 0,
			duck_stage3      = 0,

			goat_stage1      = 0,
			goat_stage2      = 0,
			goat_stage3      = 0,

			-- Forest species
			goblin_stage1    = 0,  -- Goblin (capturable from Forest Cave too)
			goblin_stage2    = 0,
			goblin_stage3    = 0,

			fox_stage1       = 0,
			fox_stage2       = 0,  -- Trickster Fox
			fox_stage3       = 0,

			sparrow_stage1   = 0,
			sparrow_stage2   = 0,
			sparrow_stage3   = 0,

			frog_stage1      = 0,
			frog_stage2      = 0,
			frog_stage3      = 0,

			hedgehog_stage1  = 0,
			hedgehog_stage2  = 0,
			hedgehog_stage3  = 0,

			beaver_stage1    = 0,
			beaver_stage2    = 0,
			beaver_stage3    = 0,

			parrot_stage1    = 0,
			parrot_stage2    = 0,
			parrot_stage3    = 0,

			wolf_stage1      = 0,  -- Wild Wolf (independent species; not the Dog evolution)
			wolf_stage2      = 0,
			wolf_stage3      = 0,

			wolverine_stage1 = 0,
			wolverine_stage2 = 0,
			wolverine_stage3 = 0,

			koi_stage1       = 0,
			koi_stage2       = 0,
			koi_stage3       = 0,

			hawk_stage1      = 0,
			hawk_stage2      = 0,
			hawk_stage3      = 0,

			eagle_stage1     = 0,
			eagle_stage2     = 0,  -- War Eagle
			eagle_stage3     = 0,

			bat_stage1       = 0,
			bat_stage2       = 0,
			bat_stage3       = 0,

			-- Mountain species
			skeleton_stage1  = 0,
			skeleton_stage2  = 0,
			skeleton_stage3  = 0,

			ghost_stage1     = 0,
			ghost_stage2     = 0,
			ghost_stage3     = 0,

			tiger_stage1     = 0,
			tiger_stage2     = 0,  -- White Tiger
			tiger_stage3     = 0,

			lion_stage1      = 0,
			lion_stage2      = 0,  -- Battle Lion
			lion_stage3      = 0,

			bear_stage1      = 0,
			bear_stage2      = 0,  -- Grizzly
			bear_stage3      = 0,

			turtle_stage1    = 0,
			turtle_stage2    = 0,  -- Armored Turtle
			turtle_stage3    = 0,

			gorilla_stage1   = 0,
			gorilla_stage2   = 0,  -- Silverback
			gorilla_stage3   = 0,

			anaconda_stage1  = 0,
			anaconda_stage2  = 0,  -- King Anaconda
			anaconda_stage3  = 0,

			-- Volcano species
			orc_stage1       = 0,
			orc_stage2       = 0,
			orc_stage3       = 0,

			troll_stage1     = 0,
			troll_stage2     = 0,
			troll_stage3     = 0,

			manticore_stage1 = 0,
			manticore_stage2 = 0,  -- Blood Manticore
			manticore_stage3 = 0,

			kitsune_stage1   = 0,
			kitsune_stage2   = 0,  -- Nine-Tail Kitsune
			kitsune_stage3   = 0,  -- Celestial Kitsune

			werewolf_stage1  = 0,
			werewolf_stage2  = 0,  -- Alpha Werewolf
			werewolf_stage3  = 0,  -- Lunar Werewolf

			basilisk_stage1  = 0,
			basilisk_stage2  = 0,
			basilisk_stage3  = 0,  -- Gorgon

			phoenix_stage1   = 0,
			phoenix_stage2   = 0,
			phoenix_stage3   = 0,

			-- Abyss species
			dragon_stage1    = 0,
			dragon_stage2    = 0,
			dragon_stage3    = 0,

			thunderbird_stage1 = 0,
			thunderbird_stage2 = 0,  -- Storm Lord
			thunderbird_stage3 = 0,

			specter_stage1   = 0,
			specter_stage2   = 0,
			specter_stage3   = 0,

			dark_troll_stage1 = 0,
			dark_troll_stage2 = 0,
			dark_troll_stage3 = 0,
		},

		-- Dungeon-only monster models (keyed by monster_id from MonsterConfig).
		-- Wild-beast versions of shared species use Models.Pets keys instead.
		Monsters = {
			goblin           = 0,
			slime            = 0,
			goblin_warchief  = 0,  -- Forest Cave boss
			bat              = 0,
			hobgoblin        = 0,
			skeleton         = 0,
			ghost            = 0,
			vampire          = 0,
			lich_king        = 0,  -- Mountain Ruins boss
			hostile_fairy    = 0,
			treant           = 0,
			elf_archer       = 0,
			elder_treant     = 0,  -- Dark Forest boss
			orc              = 0,
			troll            = 0,
			ogre             = 0,
			orc_overlord     = 0,  -- Volcano Pit boss (3 phases)
			demon            = 0,
			specter          = 0,
			dark_troll       = 0,
			abyssal_demon_lord = 0,  -- Abyss Rift boss (3 phases)
		},

		-- NPC character models (keyed by npc_id from NpcConfig).
		Npcs = {
			elder_maris           = 0,  -- Tutorial / Trainer, Starter Plains
			forest_warden_tobias  = 0,  -- Trainer, Forest
			knight_commander_vessa = 0, -- Trainer, Mountain
			flamecaller_grimtusk  = 0,  -- Trainer, Volcano
			void_seeker_nyx       = 0,  -- Trainer, Abyss
			merchant_kaine        = 0,  -- Shopkeeper, Hub
			beastmaster_yuna      = 0,  -- Shopkeeper (Pet/Skill), Hub
			bounty_master_rex     = 0,  -- Quest Giver, Hub
			arena_master_blake    = 0,  -- Service (PvP Arena), Hub
			cosmetic_stylist_faye = 0,  -- Shopkeeper (Cosmetics), Hub
		},
	},

	-- =========================================================================
	-- IMAGES
	-- rbxassetid values for 2D image assets (Decal / ImageLabel ContentId)
	-- =========================================================================

	Images = {

		-- Element type badge icons (10 elements from ELEMENT.md)
		Elements = {
			fire     = 0,
			water    = 0,
			nature   = 0,
			earth    = 0,
			electric = 0,
			ice      = 0,
			metal    = 0,
			dark     = 0,
			light    = 0,
			wind     = 0,
		},

		-- Rank tier badge icons (8 tiers from GDD §13)
		Ranks = {
			copper    = 0,
			iron      = 0,
			silver    = 0,
			gold      = 0,
			platinum  = 0,
			mithril   = 0,
			orichalcum = 0,
			adamantite = 0,
		},

		-- Item icons for all 53 items (keyed by item_id from ITEM.md)
		Items = {
			hp_potion_small    = 0,  -- 001
			hp_potion_large    = 0,  -- 002
			stamina_potion     = 0,  -- 003
			energy_drink       = 0,  -- 004
			basic_trap         = 0,  -- 005
			iron_trap          = 0,  -- 006
			gold_trap          = 0,  -- 007
			legend_trap        = 0,  -- 008
			evolution_shard    = 0,  -- 009
			evolution_crystal  = 0,  -- 010
			reimibue_stone     = 0,  -- 011
			treant_heartwood   = 0,  -- 012
			goblin_war_crown   = 0,  -- 013
			lichs_phylactery   = 0,  -- 014
			orc_warbrand_frag  = 0,  -- 015
			abyss_essence      = 0,  -- 016
			petrified_eye      = 0,  -- 017
			spirit_orb         = 0,  -- 018
			blood_moon_stone   = 0,  -- 019
			storm_feather      = 0,  -- 020
			xp_boost_crystal   = 0,  -- 021
			capture_booster    = 0,  -- 022
			dungeon_key        = 0,  -- 023
			goblin_chiefs_trophy   = 0,  -- 024
			ancient_bone_relic     = 0,  -- 025
			enchanted_bark_rune    = 0,  -- 026
			volcanic_forge_shard   = 0,  -- 027
			void_crystal       = 0,  -- 028
			dragon_scale       = 0,  -- 029
			phoenix_ash        = 0,  -- 030
			shadow_fang        = 0,  -- 031
			kings_mane_lock    = 0,  -- 032
			tempest_quill      = 0,  -- 033
			void_slime_core    = 0,  -- 034
			ancient_shell_plate = 0, -- 035
			fox_spirit_bead    = 0,  -- 036
			dire_pelt          = 0,  -- 037
			anaconda_venom_gem = 0,  -- 038
			antidote           = 0,  -- 039
			remedy             = 0,  -- 040
			warming_herb       = 0,  -- 041
			full_cure          = 0,  -- 042
			power_herb         = 0,  -- 043
			guard_stone        = 0,  -- 044
			swift_root         = 0,  -- 045
			revive_seed        = 0,  -- 046
			beast_lure         = 0,  -- 047
			repellent          = 0,  -- 048
			festival_coin      = 0,  -- 049
			lucky_charm        = 0,  -- 050
			shiny_scale        = 0,  -- 051
			emerald_feather    = 0,  -- 052
			void_shard         = 0,  -- 053
		},

		-- General UI chrome and icon assets
		UI = {
			-- Currency icons
			icon_silver        = 0,
			icon_gold          = 0,
			icon_energy        = 0,
			icon_robux         = 0,

			-- Rarity badge overlays (used on pet/item cards)
			rarity_common      = 0,
			rarity_uncommon    = 0,
			rarity_rare        = 0,
			rarity_epic        = 0,
			rarity_legendary   = 0,

			-- HUD nav bar icons
			nav_pets           = 0,
			nav_inventory      = 0,
			nav_quests         = 0,
			nav_codex          = 0,
			nav_map            = 0,

			-- Panel and button chrome
			button_default     = 0,
			button_hover       = 0,
			button_disabled    = 0,
			panel_background   = 0,
			panel_header       = 0,
			panel_close        = 0,

			-- Battle UI
			battle_hp_bar_fill = 0,
			battle_hp_bar_bg   = 0,
			battle_skill_slot  = 0,
			battle_capture_btn = 0,
			battle_flee_btn    = 0,
			status_burn        = 0,
			status_poison      = 0,
			status_bleed       = 0,
			status_freeze      = 0,
			status_bind        = 0,
			status_shock       = 0,
			status_armor_break = 0,
			status_blind       = 0,
			status_regen       = 0,
			status_taunt       = 0,

			-- Weather condition icons (shown in HUD)
			weather_clear      = 0,
			weather_rain       = 0,
			weather_storm      = 0,
			weather_fog        = 0,
			weather_blizzard   = 0,
			weather_heat_wave  = 0,
			weather_void_mist  = 0,
			weather_darkness   = 0,

			-- Misc chrome
			star_filled        = 0,
			star_empty         = 0,
			checkmark          = 0,
			lock_icon          = 0,
			silhouette_unknown = 0,  -- Codex undiscovered species
		},
	},

	-- =========================================================================
	-- SOUNDS
	-- rbxassetid values for SoundId properties
	-- =========================================================================

	Sounds = {

		Battle = {
			-- Hit feedback
			attack_hit         = 0,
			element_strong     = 0,  -- super-effective hit
			element_weak       = 0,  -- not-very-effective hit

			-- Skill and ability
			skill_fire         = 0,  -- generic skill activation
			skill_heal         = 0,
			skill_status       = 0,  -- status effect applied

			-- Status effect ticks
			status_burn_tick   = 0,
			status_poison_tick = 0,
			status_bleed_tick  = 0,

			-- Capture
			capture_success    = 0,
			capture_fail       = 0,

			-- Battle events
			pet_faint          = 0,
			flee_success       = 0,
			boss_phase_change  = 0,

			-- Progression
			level_up           = 0,
			evolve             = 0,

			-- Background music per battle type
			music_wild         = 0,
			music_dungeon      = 0,
			music_boss         = 0,
			music_pvp          = 0,
			music_npc          = 0,
		},

		UI = {
			button_click       = 0,
			menu_open          = 0,
			menu_close         = 0,
			purchase_success   = 0,
			notification       = 0,
			achievement_unlock = 0,
			quest_complete     = 0,
			codex_entry        = 0,
		},

		-- Ambient music / sounds per zone
		World = {
			zone_starter_ambient  = 0,
			zone_forest_ambient   = 0,
			zone_mountain_ambient = 0,
			zone_volcano_ambient  = 0,
			zone_abyss_ambient    = 0,
			zone_hub_music        = 0,
		},

		-- Weather sound effects per weather type (from ZONE.md)
		Weather = {
			rain      = 0,
			storm     = 0,
			thunder   = 0,
			fog       = 0,
			blizzard  = 0,
			heat_wave = 0,
			void_mist = 0,
		},
	},

	-- =========================================================================
	-- ANIMATIONS
	-- rbxassetid values for AnimationId properties
	-- =========================================================================

	Animations = {

		Player = {
			idle       = 0,
			walk       = 0,
			emote_wave = 0,
		},

		Pets = {
			idle    = 0,
			walk    = 0,
			attack  = 0,
			faint   = 0,
		},
	},

	-- =========================================================================
	-- GAME PASSES
	-- Numeric Roblox Game Pass IDs (MarketplaceService:UserOwnsGamePassAsync)
	-- =========================================================================

	GamePasses = {
		hunters_vip       = 0,  -- VIP: +energy cap, +25% NPC/dungeon Silver/Gold rewards
		pet_whisperer     = 0,  -- +20% capture rate on all beasts
		double_xp         = 0,  -- 2× XP from all sources
		expedition_master = 0,  -- +1 expedition slot
		dungeon_veteran   = 0,  -- +1 daily dungeon run per dungeon
		battle_tactician  = 0,  -- Free item use in PvP (no turn cost)
		slot_booster      = 0,  -- +1 active pet slot (stacks up to game cap)
	},

	-- =========================================================================
	-- DEVELOPER PRODUCTS
	-- Numeric Roblox Developer Product IDs (MarketplaceService:PromptProductPurchase)
	-- =========================================================================

	Products = {
		-- Gold bundles
		gold_100          = 0,
		gold_500          = 0,
		gold_2000         = 0,
		gold_5000         = 0,

		-- Convenience products
		energy_refill     = 0,  -- Instantly restore Hunt Energy to max
		dungeon_key       = 0,  -- +1 dungeon run (bypasses daily limit)
		capture_boost     = 0,  -- +50% capture rate for 1 hour
		xp_boost_1h       = 0,  -- 2× XP for 1 hour

		-- Donation tiers (cosmetic reward only; zero gameplay advantage)
		donate_supporter    = 0,
		donate_patron       = 0,
		donate_benefactor   = 0,
		donate_grand_patron = 0,
		donate_legend       = 0,

		-- Player-to-player tips
		tip_small  = 0,
		tip_medium = 0,
		tip_big    = 0,
		tip_mega   = 0,
	},

	-- =========================================================================
	-- BADGES
	-- Numeric Roblox Badge IDs (BadgeService:AwardBadge)
	-- =========================================================================

	Badges = {
		first_steps       = 0,  -- Complete first battle
		beast_slayer      = 0,  -- Defeat 100 wild beasts
		dungeon_diver     = 0,  -- Complete any dungeon
		boss_hunter       = 0,  -- Defeat all 5 dungeon bosses
		pvp_champion      = 0,  -- Win 10 PvP matches
		adamantite_legend = 0,  -- Reach Adamantite rank
		codex_complete    = 0,  -- Discover all species in the Codex
		true_supporter    = 0,  -- Reach donate_legend tier
	},
}
