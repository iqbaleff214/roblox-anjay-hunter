-- src/shared/Config/SpeciesConfig.lua
-- Defines every playable pet species.
-- All 44 species from ZONE.md wild rosters plus GDD §6.2 catalogue.
--
-- Field contract:
--   Name            string               Display name
--   Element         string | nil         Natural element; nil = elementless (player imbues at Lv50+)
--   BaseStats       table                { HP, ATK, DEF, SPD, CRT } at level 1
--   StatGrowth      table                { HP, ATK, DEF, SPD, CRT } added per level (GDD §6.3)
--   EvolutionStages array of tables      { Level, ModelId } — ModelId is a key into Assets.Models.Pets
--   SkillPool       array of strings     All learnable skill IDs for this species (refs SkillConfig)
--   BaseCapture     number (0–1)         Species-level capture base rate fed to StatUtils formula
--   Rarity          string               "Common" | "Uncommon" | "Rare" | "Epic" | "Legendary"
--   Lore            string               Flavour text
--
-- Tier base stats (GDD §6.3):
--   Common    HP=100 ATK=15 DEF=10 SPD=10 / growth HP=5 ATK=2 DEF=1 SPD=1
--   Uncommon  HP=130 ATK=20 DEF=14 SPD=13 / growth HP=7 ATK=3 DEF=2 SPD=1
--   Rare      HP=170 ATK=27 DEF=19 SPD=17 / growth HP=10 ATK=4 DEF=3 SPD=2
--   Epic      HP=220 ATK=36 DEF=26 SPD=22 / growth HP=14 ATK=6 DEF=4 SPD=2
--   Legendary HP=300 ATK=50 DEF=36 SPD=30 / growth HP=20 ATK=9 DEF=6 SPD=3
--
-- Evolution level thresholds (GDD §6.6):
--   Common Stage2=Lv20 Stage3=Lv100 | Uncommon Stage2=Lv30 Stage3=Lv150
--   Rare   Stage2=Lv50 Stage3=Lv200 | Epic     Stage2=Lv75 Stage3=Lv300
--   Legendary Stage2=Lv100 Stage3=Lv500

return {

	-- =========================================================================
	-- STARTER PLAINS  (zone_starter)
	-- =========================================================================

	dog = {
		Name    = "Dog",
		Element = nil,  -- elementless; player imbues at Lv50+
		BaseStats  = { HP = 100, ATK = 15, DEF = 10, SPD = 12, CRT = 0.05 },
		StatGrowth = { HP = 5,   ATK = 2,  DEF = 1,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "dog_stage1" },  -- Dog
			{ Level = 20,  ModelId = "dog_stage2" },  -- Wolf
			{ Level = 100, ModelId = "dog_stage3" },  -- Dire Wolf
		},
		SkillPool   = { "basic_attack", "growl", "tackle", "bite", "howl", "fang_strike" },
		BaseCapture = 0.50,
		Rarity      = "Common",
		Lore        = "The most loyal companion in the Starter Plains. Grows into a fearsome Dire Wolf that veterans still respect.",
	},

	cat = {
		Name    = "Cat",
		Element = nil,
		BaseStats  = { HP = 90, ATK = 16, DEF = 9,  SPD = 14, CRT = 0.08 },
		StatGrowth = { HP = 4,  ATK = 2,  DEF = 1,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "cat_stage1" },
			{ Level = 20,  ModelId = "cat_stage2" },
			{ Level = 100, ModelId = "cat_stage3" },
		},
		SkillPool   = { "basic_attack", "scratch", "shadow_step", "pounce", "hiss", "claw_swipe" },
		BaseCapture = 0.50,
		Rarity      = "Common",
		Lore        = "Agile and aloof. Its natural evasion makes it surprisingly hard to land a clean hit on.",
	},

	pig = {
		Name    = "Pig",
		Element = "earth",
		BaseStats  = { HP = 125, ATK = 13, DEF = 13, SPD = 8,  CRT = 0.03 },
		StatGrowth = { HP = 7,   ATK = 2,  DEF = 1,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "pig_stage1" },
			{ Level = 20,  ModelId = "pig_stage2" },
			{ Level = 100, ModelId = "pig_stage3" },
		},
		SkillPool   = { "basic_attack", "tackle", "mud_fling", "iron_skin", "earthquake_stomp" },
		BaseCapture = 0.50,
		Rarity      = "Common",
		Lore        = "Built like a small boulder. Slow and stubborn, but takes punishment no other starter species can match.",
	},

	horse = {
		Name    = "Horse",
		Element = nil,  -- dual Light/Wind affinity; player picks
		BaseStats  = { HP = 105, ATK = 16, DEF = 10, SPD = 14, CRT = 0.05 },
		StatGrowth = { HP = 5,   ATK = 2,  DEF = 1,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "horse_stage1" },
			{ Level = 20,  ModelId = "horse_stage2" },  -- Cavalry Charge always-first unlocked
			{ Level = 100, ModelId = "horse_stage3" },
		},
		SkillPool   = { "basic_attack", "hoof_kick", "cavalry_charge", "swift_gallop", "trample", "battle_cry" },
		BaseCapture = 0.50,
		Rarity      = "Common",
		Lore        = "Among the fastest of the starter beasts. Its Stage 2 always strikes first — a lesson many hunters learn the hard way.",
	},

	rabbit = {
		Name    = "Rabbit",
		Element = "wind",
		BaseStats  = { HP = 85,  ATK = 14, DEF = 8,  SPD = 16, CRT = 0.07 },
		StatGrowth = { HP = 4,   ATK = 2,  DEF = 1,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "rabbit_stage1" },
			{ Level = 20,  ModelId = "rabbit_stage2" },
			{ Level = 100, ModelId = "rabbit_stage3" },
		},
		SkillPool   = { "basic_attack", "quick_jab", "evasive_hop", "wind_burst", "double_kick", "gale_kick" },
		BaseCapture = 0.50,
		Rarity      = "Common",
		Lore        = "Blinks around the battlefield so quickly that new hunters often miss it with Basic Trap on the first try.",
	},

	slime = {
		Name    = "Slime",
		Element = "water",
		BaseStats  = { HP = 120, ATK = 12, DEF = 12, SPD = 8,  CRT = 0.03 },
		StatGrowth = { HP = 6,   ATK = 2,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "slime_stage1" },   -- Slime
			{ Level = 20,  ModelId = "slime_stage2" },   -- Slime King
			{ Level = 100, ModelId = "slime_stage3" },   -- Slime Titan
		},
		SkillPool   = { "slime_spit", "split_defense", "absorb", "ooze_coat", "sticky_touch", "void_slime_surge" },
		BaseCapture = 0.50,
		Rarity      = "Common",
		Lore        = "Found in the ponds of Starter Plains and the halls of Forest Cave. Immune to Poison and Bleed by body composition alone.",
	},

	duck = {
		Name    = "Duck",
		Element = "water",
		BaseStats  = { HP = 95,  ATK = 14, DEF = 10, SPD = 11, CRT = 0.05 },
		StatGrowth = { HP = 5,   ATK = 2,  DEF = 1,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "duck_stage1" },
			{ Level = 20,  ModelId = "duck_stage2" },
			{ Level = 100, ModelId = "duck_stage3" },
		},
		SkillPool   = { "basic_attack", "water_jet", "wing_flap", "rain_dance", "quack_blast", "feathered_shield" },
		BaseCapture = 0.50,
		Rarity      = "Common",
		Lore        = "Congregates near the southern ponds. Deceptively tough — those webbed feet hit harder than they look.",
	},

	goat = {
		Name    = "Goat",
		Element = "earth",
		BaseStats  = { HP = 105, ATK = 15, DEF = 14, SPD = 9,  CRT = 0.04 },
		StatGrowth = { HP = 5,   ATK = 2,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "goat_stage1" },
			{ Level = 20,  ModelId = "goat_stage2" },
			{ Level = 100, ModelId = "goat_stage3" },
		},
		SkillPool   = { "basic_attack", "ram", "stubborn_stance", "earth_stomp", "headbutt", "stone_hide" },
		BaseCapture = 0.50,
		Rarity      = "Common",
		Lore        = "Immune to Taunt by sheer stubbornness. Will not be moved, redirected, or intimidated by any skill that tries.",
	},

	-- =========================================================================
	-- FOREST  (zone_forest)
	-- =========================================================================

	goblin = {
		Name    = "Goblin",
		Element = "nature",
		BaseStats  = { HP = 130, ATK = 20, DEF = 14, SPD = 14, CRT = 0.06 },
		StatGrowth = { HP = 7,   ATK = 3,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "goblin_stage1" },  -- Goblin
			{ Level = 30,  ModelId = "goblin_stage2" },  -- Hobgoblin
			{ Level = 150, ModelId = "goblin_stage3" },  -- Goblin Warchief
		},
		SkillPool   = { "shiv", "group_tactics", "pickpocket", "basic_attack", "war_cry", "goblin_rush" },
		BaseCapture = 0.35,
		Rarity      = "Uncommon",
		Lore        = "Capturable from the Forest Cave dungeon with an Iron Trap or better. Individually weak; evolves into a warchief who commands armies.",
	},

	fox = {
		Name    = "Fox",
		Element = "fire",
		BaseStats  = { HP = 120, ATK = 22, DEF = 12, SPD = 16, CRT = 0.09 },
		StatGrowth = { HP = 6,   ATK = 3,  DEF = 2,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "fox_stage1" },
			{ Level = 30,  ModelId = "fox_stage2" },  -- Trickster Fox; drops Fox Spirit Bead at Lv2+
			{ Level = 150, ModelId = "fox_stage3" },
		},
		SkillPool   = { "shadow_strike", "quick_step", "fox_fire", "feint", "ember_nip", "cunning_blaze" },
		BaseCapture = 0.35,
		Rarity      = "Uncommon",
		Lore        = "A natural trickster. Its Trickster Fox form drops Fox Spirit Bead, a key Stage 3 evolution material.",
	},

	sparrow = {
		Name    = "Sparrow",
		Element = "wind",
		BaseStats  = { HP = 80,  ATK = 14, DEF = 7,  SPD = 15, CRT = 0.07 },
		StatGrowth = { HP = 4,   ATK = 2,  DEF = 1,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "sparrow_stage1" },
			{ Level = 20,  ModelId = "sparrow_stage2" },
			{ Level = 100, ModelId = "sparrow_stage3" },
		},
		SkillPool   = { "basic_attack", "peck", "feather_veil", "wind_gust", "aerial_dash", "gale_peck" },
		BaseCapture = 0.45,
		Rarity      = "Common",
		Lore        = "Feather Veil reflects Blind back at the caster. A frustrating opponent if you rely on Dark-element openers.",
	},

	frog = {
		Name    = "Frog",
		Element = "water",
		BaseStats  = { HP = 105, ATK = 14, DEF = 10, SPD = 11, CRT = 0.05 },
		StatGrowth = { HP = 5,   ATK = 2,  DEF = 1,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "frog_stage1" },
			{ Level = 20,  ModelId = "frog_stage2" },
			{ Level = 100, ModelId = "frog_stage3" },
		},
		SkillPool   = { "basic_attack", "tongue_lash", "acid_skin", "rain_dance", "mud_slide", "toxic_spray" },
		BaseCapture = 0.45,
		Rarity      = "Common",
		Lore        = "Rain Dance and Acid Skin is a combo that has ended many promising careers. Stands in the stream and waits for you to approach.",
	},

	hedgehog = {
		Name    = "Hedgehog",
		Element = "earth",
		BaseStats  = { HP = 100, ATK = 14, DEF = 16, SPD = 9,  CRT = 0.04 },
		StatGrowth = { HP = 5,   ATK = 2,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "hedgehog_stage1" },
			{ Level = 20,  ModelId = "hedgehog_stage2" },
			{ Level = 100, ModelId = "hedgehog_stage3" },
		},
		SkillPool   = { "basic_attack", "iron_quill_strike", "curl_up", "quill_barrage", "earth_shield", "spine_counter" },
		BaseCapture = 0.45,
		Rarity      = "Common",
		Lore        = "Iron Quill Strike adds DEF to ATK for its damage calculation. Stacking its DEF makes its attacks genuinely threatening.",
	},

	beaver = {
		Name    = "Beaver",
		Element = "water",
		BaseStats  = { HP = 110, ATK = 13, DEF = 14, SPD = 9,  CRT = 0.03 },
		StatGrowth = { HP = 6,   ATK = 2,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "beaver_stage1" },
			{ Level = 20,  ModelId = "beaver_stage2" },
			{ Level = 100, ModelId = "beaver_stage3" },
		},
		SkillPool   = { "basic_attack", "chomp", "grand_levee", "dam_wall", "water_slap", "log_roll" },
		BaseCapture = 0.45,
		Rarity      = "Common",
		Lore        = "Grand Levee is a self-modifier buff that cannot be cleansed. Once it starts stacking, the fight shifts decisively.",
	},

	parrot = {
		Name    = "Parrot",
		Element = "wind",
		BaseStats  = { HP = 120, ATK = 19, DEF = 13, SPD = 14, CRT = 0.06 },
		StatGrowth = { HP = 6,   ATK = 3,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "parrot_stage1" },
			{ Level = 30,  ModelId = "parrot_stage2" },
			{ Level = 150, ModelId = "parrot_stage3" },
		},
		SkillPool   = { "basic_attack", "mimicry", "wing_slash", "wind_screech", "copy_cat", "gale_talon" },
		BaseCapture = 0.35,
		Rarity      = "Uncommon",
		Lore        = "Mimicry copies the last skill used by any combatant on either side. In the wrong hands, it is an oversight; in the right hands, it is a weapon.",
	},

	wolf = {
		Name    = "Wolf",
		Element = "dark",
		BaseStats  = { HP = 130, ATK = 22, DEF = 13, SPD = 15, CRT = 0.08 },
		StatGrowth = { HP = 7,   ATK = 3,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "wolf_stage1" },
			{ Level = 30,  ModelId = "wolf_stage2" },
			{ Level = 150, ModelId = "wolf_stage3" },
		},
		SkillPool   = { "fang_strike", "howl", "pack_leader", "alpha_mark", "dark_bite", "shadow_howl" },
		BaseCapture = 0.35,
		Rarity      = "Uncommon",
		Lore        = "Pack Leader stacks +15% ATK each time a kill blow is landed. Late-game Wolves become exponentially more lethal as the battle goes on.",
	},

	wolverine = {
		Name    = "Wolverine",
		Element = "nature",
		BaseStats  = { HP = 140, ATK = 21, DEF = 14, SPD = 13, CRT = 0.06 },
		StatGrowth = { HP = 7,   ATK = 3,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "wolverine_stage1" },
			{ Level = 30,  ModelId = "wolverine_stage2" },
			{ Level = 150, ModelId = "wolverine_stage3" },
		},
		SkillPool   = { "basic_attack", "undying_grit", "feral_slash", "regenerate", "nature_rage", "primal_fury" },
		BaseCapture = 0.35,
		Rarity      = "Uncommon",
		Lore        = "Undying Grit triggers once per battle: the Wolverine survives at 1 HP instead of fainting. Nocturnal — more common during night cycles.",
	},

	koi = {
		Name    = "Koi",
		Element = "water",
		BaseStats  = { HP = 125, ATK = 18, DEF = 15, SPD = 13, CRT = 0.06 },
		StatGrowth = { HP = 7,   ATK = 3,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "koi_stage1" },
			{ Level = 30,  ModelId = "koi_stage2" },
			{ Level = 150, ModelId = "koi_stage3" },
		},
		SkillPool   = { "basic_attack", "fortune_scales", "water_pulse", "lucky_splash", "aqua_veil", "fortune_tide" },
		BaseCapture = 0.35,
		Rarity      = "Uncommon",
		Lore        = "Fortune Scales has a 20% chance each turn to randomly heal, deal damage, or cleanse a status. Chaotic in the best possible way.",
	},

	hawk = {
		Name    = "Hawk",
		Element = "wind",
		BaseStats  = { HP = 120, ATK = 21, DEF = 12, SPD = 16, CRT = 0.07 },
		StatGrowth = { HP = 6,   ATK = 3,  DEF = 2,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "hawk_stage1" },
			{ Level = 30,  ModelId = "hawk_stage2" },
			{ Level = 150, ModelId = "hawk_stage3" },
		},
		SkillPool   = { "basic_attack", "aerial_predator", "talon_dive", "wind_shear", "precision_strike", "storm_talon" },
		BaseCapture = 0.35,
		Rarity      = "Uncommon",
		Lore        = "Aerial Predator overrides turn order on the first turn — it always attacks before any other combatant regardless of Speed.",
	},

	eagle = {
		Name    = "Eagle",
		Element = "wind",
		BaseStats  = { HP = 170, ATK = 28, DEF = 19, SPD = 18, CRT = 0.07 },
		StatGrowth = { HP = 10,  ATK = 4,  DEF = 3,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "eagle_stage1" },
			{ Level = 50,  ModelId = "eagle_stage2" },  -- War Eagle; drops Tempest Quill at Stage 2+
			{ Level = 200, ModelId = "eagle_stage3" },
		},
		SkillPool   = { "talon_strike", "wind_dive", "aerial_predator", "gale_wing", "razor_feather", "sky_sovereign_dive" },
		BaseCapture = 0.20,
		Rarity      = "Rare",
		Lore        = "The War Eagle form is a prized mount. Its Tempest Quill is a Stage 3 evolution material for the Thunderbird line.",
	},

	bat = {
		Name    = "Bat",
		Element = "dark",
		BaseStats  = { HP = 125, ATK = 20, DEF = 12, SPD = 15, CRT = 0.07 },
		StatGrowth = { HP = 6,   ATK = 3,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "bat_stage1" },
			{ Level = 30,  ModelId = "bat_stage2" },
			{ Level = 150, ModelId = "bat_stage3" },
		},
		SkillPool   = { "basic_attack", "screech", "echolocation", "sonic_wave", "dark_wing", "supersonic_barrage" },
		BaseCapture = 0.35,
		Rarity      = "Uncommon",
		Lore        = "Nocturnal; spawns more often at night. Echolocation passively suppresses all dodge chances — including the Ghost's Incorporeal form.",
	},

	-- =========================================================================
	-- MOUNTAIN  (zone_mountain)
	-- =========================================================================

	skeleton = {
		Name    = "Skeleton",
		Element = "dark",
		BaseStats  = { HP = 125, ATK = 20, DEF = 13, SPD = 13, CRT = 0.06 },
		StatGrowth = { HP = 7,   ATK = 3,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "skeleton_stage1" },
			{ Level = 30,  ModelId = "skeleton_stage2" },  -- drops Lich's Phylactery at Stage 2+
			{ Level = 150, ModelId = "skeleton_stage3" },
		},
		SkillPool   = { "basic_attack", "bone_throw", "dark_clatter", "rattle_curse", "undead_rise", "lichform" },
		BaseCapture = 0.35,
		Rarity      = "Uncommon",
		Lore        = "Wild variant found in the Mountain ruins. Stage 2+ drops Lich's Phylactery, one of the rarer evolution materials.",
	},

	ghost = {
		Name    = "Ghost",
		Element = "dark",
		BaseStats  = { HP = 120, ATK = 20, DEF = 10, SPD = 14, CRT = 0.07 },
		StatGrowth = { HP = 6,   ATK = 3,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "ghost_stage1" },
			{ Level = 30,  ModelId = "ghost_stage2" },
			{ Level = 150, ModelId = "ghost_stage3" },
		},
		SkillPool   = { "basic_attack", "incorporeal", "haunt", "shadow_pulse", "chill_touch", "spectral_wail" },
		BaseCapture = 0.35,
		Rarity      = "Uncommon",
		Lore        = "Incorporeal form grants 30% dodge against Physical attacks only. Spawn rate increases during Fog weather.",
	},

	tiger = {
		Name    = "Tiger",
		Element = "light",
		BaseStats  = { HP = 165, ATK = 30, DEF = 18, SPD = 20, CRT = 0.10 },
		StatGrowth = { HP = 9,   ATK = 5,  DEF = 3,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "tiger_stage1" },
			{ Level = 50,  ModelId = "tiger_stage2" },  -- White Tiger; drops Shadow Fang at Stage 2+
			{ Level = 200, ModelId = "tiger_stage3" },  -- Shadow Tiger
		},
		SkillPool   = { "pounce", "tiger_slash", "light_fang", "shadow_pounce", "tiger_roar", "radiant_strike" },
		BaseCapture = 0.20,
		Rarity      = "Rare",
		Lore        = "Its Pounce is a priority skill — it always fires before any normal-speed move. Knight Commander Vessa uses one to open every fight.",
	},

	lion = {
		Name    = "Lion",
		Element = "light",
		BaseStats  = { HP = 170, ATK = 27, DEF = 22, SPD = 17, CRT = 0.07 },
		StatGrowth = { HP = 10,  ATK = 4,  DEF = 3,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "lion_stage1" },
			{ Level = 50,  ModelId = "lion_stage2" },  -- Battle Lion; drops King's Mane Lock at Stage 2+
			{ Level = 200, ModelId = "lion_stage3" },
		},
		SkillPool   = { "mauling_paw", "pride_roar", "pride", "king_roar", "radiant_claw", "solar_mauling" },
		BaseCapture = 0.20,
		Rarity      = "Rare",
		Lore        = "Pride passive boosts ATK when its own ATK exceeds the opponent's. Debuffing its ATK with Alpha Mark is the correct counter-play.",
	},

	bear = {
		Name    = "Bear",
		Element = "earth",
		BaseStats  = { HP = 185, ATK = 26, DEF = 24, SPD = 13, CRT = 0.04 },
		StatGrowth = { HP = 11,  ATK = 4,  DEF = 4,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "bear_stage1" },
			{ Level = 50,  ModelId = "bear_stage2" },  -- Grizzly
			{ Level = 200, ModelId = "bear_stage3" },
		},
		SkillPool   = { "crushing_bite", "primal_strength", "earth_slam", "bear_hug", "armor_hide", "seismic_maul" },
		BaseCapture = 0.20,
		Rarity      = "Rare",
		Lore        = "Deep DEF tank. Requires Armor Break or DEF-ignore skills to deal meaningful damage. Vessa's Bear is designed to out-last your resources.",
	},

	turtle = {
		Name    = "Turtle",
		Element = "earth",
		BaseStats  = { HP = 115, ATK = 12, DEF = 16, SPD = 7,  CRT = 0.03 },
		StatGrowth = { HP = 6,   ATK = 2,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "turtle_stage1" },
			{ Level = 20,  ModelId = "turtle_stage2" },  -- Armored Turtle; drops Ancient Shell Plate at Stage 2+
			{ Level = 100, ModelId = "turtle_stage3" },
		},
		SkillPool   = { "basic_attack", "shell_bash", "withdraw", "stone_wall", "ancient_shell", "tectonic_slam" },
		BaseCapture = 0.45,
		Rarity      = "Common",
		Lore        = "The slowest Common species. Its Armored Turtle form drops Ancient Shell Plate, a sought-after Stage 3 material.",
	},

	gorilla = {
		Name    = "Gorilla",
		Element = "earth",
		BaseStats  = { HP = 175, ATK = 28, DEF = 21, SPD = 15, CRT = 0.06 },
		StatGrowth = { HP = 10,  ATK = 4,  DEF = 3,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "gorilla_stage1" },
			{ Level = 50,  ModelId = "gorilla_stage2" },  -- Silverback
			{ Level = 200, ModelId = "gorilla_stage3" },
		},
		SkillPool   = { "ground_pound", "primal_roar", "silverback_charge", "knuckle_guard", "earth_shatter", "alpha_slam" },
		BaseCapture = 0.20,
		Rarity      = "Rare",
		Lore        = "Knuckle Guard counters 25% of incoming Physical hits. Avoid Physical multi-hit skills against it — each hit can trigger another counter.",
	},

	anaconda = {
		Name    = "Anaconda",
		Element = "water",
		BaseStats  = { HP = 175, ATK = 26, DEF = 20, SPD = 14, CRT = 0.06 },
		StatGrowth = { HP = 10,  ATK = 4,  DEF = 3,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "anaconda_stage1" },
			{ Level = 50,  ModelId = "anaconda_stage2" },  -- King Anaconda
			{ Level = 200, ModelId = "anaconda_stage3" },
		},
		SkillPool   = { "constrictor", "venom_bite", "coil", "aqua_crush", "dark_swallow", "abyss_venom" },
		BaseCapture = 0.20,
		Rarity      = "Rare",
		Lore        = "Constrictor aura reduces the opponent's SPD passively. Found across Mountain, Volcano, and Abyss zones as it ranges into harsher terrain.",
	},

	-- =========================================================================
	-- DARK FOREST SUB-REGION  (zone_mountain northeast)
	-- =========================================================================

	treant = {
		Name    = "Treant",
		Element = "nature",
		BaseStats  = { HP = 180, ATK = 25, DEF = 22, SPD = 13, CRT = 0.04 },
		StatGrowth = { HP = 10,  ATK = 4,  DEF = 3,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "treant_stage1" },
			{ Level = 50,  ModelId = "treant_stage2" },
			{ Level = 200, ModelId = "treant_stage3" },
		},
		SkillPool   = { "branch_slam", "root_bind", "bark_armor", "nature_pulse", "overgrowth", "ancient_wrath" },
		BaseCapture = 0.20,
		Rarity      = "Rare",
		Lore        = "Wild variant of the Elder Treant dungeon boss line. Found exclusively in the Dark Forest sub-region of the Mountain zone.",
	},

	hostile_fairy = {
		Name    = "Hostile Fairy",
		Element = "wind",
		BaseStats  = { HP = 85,  ATK = 15, DEF = 8,  SPD = 16, CRT = 0.08 },
		StatGrowth = { HP = 4,   ATK = 2,  DEF = 1,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "hostile_fairy_stage1" },
			{ Level = 20,  ModelId = "hostile_fairy_stage2" },
			{ Level = 100, ModelId = "hostile_fairy_stage3" },
		},
		SkillPool   = { "basic_attack", "pixie_dust", "wind_swirl", "fairy_hex", "illusion_veil", "wild_magic" },
		BaseCapture = 0.45,
		Rarity      = "Common",
		Lore        = "The blue glow of the Hostile Fairy is the only light source in the Dark Forest. Do not mistake its beauty for friendliness.",
	},

	dark_elf = {
		Name    = "Dark Elf",
		Element = "dark",
		BaseStats  = { HP = 225, ATK = 37, DEF = 26, SPD = 23, CRT = 0.08 },
		StatGrowth = { HP = 14,  ATK = 6,  DEF = 4,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "dark_elf_stage1" },
			{ Level = 75,  ModelId = "dark_elf_stage2" },
			{ Level = 300, ModelId = "dark_elf_stage3" },
		},
		SkillPool   = { "shadow_arrow", "dark_step", "shadow_volley", "umbra_strike", "void_arrow", "nightfall_barrage" },
		BaseCapture = 0.10,
		Rarity      = "Epic",
		Lore        = "The apex predator of the Dark Forest sub-region. Hunters who enter the northeast seeking easy captures are rarely seen again.",
	},

	-- =========================================================================
	-- VOLCANO  (zone_volcano)
	-- =========================================================================

	orc = {
		Name    = "Orc",
		Element = "fire",
		BaseStats  = { HP = 170, ATK = 28, DEF = 21, SPD = 15, CRT = 0.05 },
		StatGrowth = { HP = 10,  ATK = 4,  DEF = 3,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "orc_stage1" },
			{ Level = 50,  ModelId = "orc_stage2" },
			{ Level = 200, ModelId = "orc_stage3" },
		},
		SkillPool   = { "basic_attack", "war_axe", "battle_cry", "berserk_charge", "fire_slash", "warlord_frenzy" },
		BaseCapture = 0.20,
		Rarity      = "Rare",
		Lore        = "Spawns commonly in the Volcano zone's overworld but is Rare by species tier. The Orc Overlord dungeon boss is its ultimate evolved form.",
	},

	troll = {
		Name    = "Troll",
		Element = "earth",
		BaseStats  = { HP = 230, ATK = 35, DEF = 28, SPD = 18, CRT = 0.05 },
		StatGrowth = { HP = 14,  ATK = 6,  DEF = 4,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "troll_stage1" },
			{ Level = 75,  ModelId = "troll_stage2" },
			{ Level = 300, ModelId = "troll_stage3" },
		},
		SkillPool   = { "rock_throw", "troll_regeneration", "ground_smash", "boulder_toss", "earth_tremor", "primal_rampage" },
		BaseCapture = 0.10,
		Rarity      = "Epic",
		Lore        = "Troll Regeneration heals 3% max HP each turn. Burn or Poison are the counters — the regen cannot heal faster than continuous DoT.",
	},

	manticore = {
		Name    = "Manticore",
		Element = "fire",
		BaseStats  = { HP = 175, ATK = 30, DEF = 18, SPD = 18, CRT = 0.08 },
		StatGrowth = { HP = 10,  ATK = 5,  DEF = 3,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "manticore_stage1" },
			{ Level = 50,  ModelId = "manticore_stage2" },  -- Blood Manticore
			{ Level = 200, ModelId = "manticore_stage3" },
		},
		SkillPool   = { "lion_mauling", "scorpion_tail", "manic_frenzy", "volcanic_spine", "flame_claw", "chaos_manifestation" },
		BaseCapture = 0.18,
		Rarity      = "Rare",
		Lore        = "Legendary-adjacent difficulty for a Rare species. Volcanic Spine passive triggers a Fire counter on every hit received.",
	},

	kitsune = {
		Name    = "Kitsune",
		Element = "fire",
		BaseStats  = { HP = 220, ATK = 38, DEF = 25, SPD = 25, CRT = 0.10 },
		StatGrowth = { HP = 14,  ATK = 6,  DEF = 4,  SPD = 3,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "kitsune_stage1" },
			{ Level = 75,  ModelId = "kitsune_stage2" },  -- Nine-Tail Kitsune
			{ Level = 300, ModelId = "kitsune_stage3" },  -- Celestial Kitsune (Nyx's endgame pet)
		},
		SkillPool   = { "spirit_flame", "illusion_strike", "phantom_step", "celestial_fox_flame", "fox_fire", "void_spirit_flame" },
		BaseCapture = 0.10,
		Rarity      = "Epic",
		Lore        = "Fox Fire marks accumulate on the target. When marks reach a threshold, Celestial Fox Flame detonates them all at once.",
	},

	werewolf = {
		Name    = "Werewolf",
		Element = "dark",
		BaseStats  = { HP = 225, ATK = 40, DEF = 24, SPD = 22, CRT = 0.09 },
		StatGrowth = { HP = 14,  ATK = 7,  DEF = 4,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "werewolf_stage1" },
			{ Level = 75,  ModelId = "werewolf_stage2" },   -- Alpha Werewolf
			{ Level = 300, ModelId = "werewolf_stage3" },   -- Lunar Werewolf (Nyx's endgame pet)
		},
		SkillPool   = { "claw_rend", "moon_howl", "full_moon_rampage", "lycan_transformation", "lunar_rage", "blood_frenzy" },
		BaseCapture = 0.10,
		Rarity      = "Epic",
		Lore        = "Lunar Rage amplifies ATK exponentially under certain conditions. The Lunar Werewolf form is among the most feared in endgame PvP.",
	},

	basilisk = {
		Name    = "Basilisk",
		Element = "dark",
		BaseStats  = { HP = 170, ATK = 26, DEF = 22, SPD = 15, CRT = 0.06 },
		StatGrowth = { HP = 10,  ATK = 4,  DEF = 3,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "basilisk_stage1" },
			{ Level = 50,  ModelId = "basilisk_stage2" },
			{ Level = 200, ModelId = "basilisk_stage3" },  -- Gorgon
		},
		SkillPool   = { "petrifying_gaze", "stone_scales", "dark_lunge", "petrify", "venom_gaze", "medusa_gaze" },
		BaseCapture = 0.18,
		Rarity      = "Rare",
		Lore        = "Petrifying Gaze has a chance to inflict Freeze (skip turn). Found in both Volcano and Abyss zones — the Abyss Rift boss drops Petrified Eye for its Stage 3 line.",
	},

	phoenix = {
		Name    = "Phoenix",
		Element = "fire",
		BaseStats  = { HP = 300, ATK = 52, DEF = 36, SPD = 32, CRT = 0.08 },
		StatGrowth = { HP = 20,  ATK = 9,  DEF = 6,  SPD = 3,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "phoenix_stage1" },
			{ Level = 100, ModelId = "phoenix_stage2" },
			{ Level = 500, ModelId = "phoenix_stage3" },
		},
		SkillPool   = { "ember_strike", "flame_wing", "rebirth", "solar_flare", "inferno_dive", "eternal_flame" },
		BaseCapture = 0.05,
		Rarity      = "Legendary",
		Lore        = "Only appears in the Volcano zone during Heat Wave weather. First capture always drops Phoenix Ash. Its Rebirth passive makes every battle a two-phase encounter.",
	},

	-- =========================================================================
	-- ABYSS  (zone_abyss)
	-- =========================================================================

	dragon = {
		Name    = "Dragon",
		Element = "fire",
		BaseStats  = { HP = 320, ATK = 55, DEF = 40, SPD = 28, CRT = 0.09 },
		StatGrowth = { HP = 20,  ATK = 9,  DEF = 7,  SPD = 3,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "dragon_stage1" },   -- Whelp
			{ Level = 100, ModelId = "dragon_stage2" },   -- Drake
			{ Level = 500, ModelId = "dragon_stage3" },   -- Elder Dragon
		},
		SkillPool   = { "dragon_breath", "wing_gust", "dragon_claw", "inferno_roar", "ancient_fire", "elder_dragon_rage" },
		BaseCapture = 0.05,
		Rarity      = "Legendary",
		Lore        = "2% spawn chance per encounter regardless of weather; 4% during Storm. First capture always drops Dragon Scale. Its silhouette flies across the Abyss skybox as a sighting cue.",
	},

	thunderbird = {
		Name    = "Thunderbird",
		Element = "electric",
		BaseStats  = { HP = 305, ATK = 50, DEF = 37, SPD = 34, CRT = 0.08 },
		StatGrowth = { HP = 20,  ATK = 9,  DEF = 6,  SPD = 4,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "thunderbird_stage1" },
			{ Level = 100, ModelId = "thunderbird_stage2" },  -- Storm Lord (Nyx's endgame pet)
			{ Level = 500, ModelId = "thunderbird_stage3" },
		},
		SkillPool   = { "thunder_talons", "gale_wing", "storm_surge", "lightning_dive", "tempest_cry", "sky_sovereign_strike" },
		BaseCapture = 0.05,
		Rarity      = "Legendary",
		Lore        = "Only appears during Storm weather in Abyss. Stage 2+ Thunderbirds in your active roster can trigger the Sky Sovereign world event.",
	},

	specter = {
		Name    = "Specter",
		Element = "dark",
		BaseStats  = { HP = 125, ATK = 20, DEF = 11, SPD = 14, CRT = 0.07 },
		StatGrowth = { HP = 7,   ATK = 3,  DEF = 2,  SPD = 1,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "specter_stage1" },
			{ Level = 30,  ModelId = "specter_stage2" },
			{ Level = 150, ModelId = "specter_stage3" },
		},
		SkillPool   = { "basic_attack", "ethereal_form", "void_touch", "phantom_drain", "darkness_shroud", "oblivion_wail" },
		BaseCapture = 0.35,
		Rarity      = "Uncommon",
		Lore        = "Ethereal Form grants 30% dodge against both Physical AND Elemental attacks — unlike the Ghost which only dodges Physical. Spawn rate spikes during Darkness weather overlay.",
	},

	dark_troll = {
		Name    = "Dark Troll",
		Element = "dark",
		BaseStats  = { HP = 180, ATK = 26, DEF = 22, SPD = 15, CRT = 0.05 },
		StatGrowth = { HP = 10,  ATK = 4,  DEF = 3,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "dark_troll_stage1" },
			{ Level = 50,  ModelId = "dark_troll_stage2" },
			{ Level = 200, ModelId = "dark_troll_stage3" },
		},
		SkillPool   = { "dark_regeneration", "shadow_slam", "void_strike", "darkness_pulse", "dark_rampage", "abyss_crush" },
		BaseCapture = 0.18,
		Rarity      = "Rare",
		Lore        = "Dark Regeneration heals 4% max HP per turn, exceeding standard Troll Regeneration. Widely considered the hardest non-boss enemy in the game.",
	},

	-- =========================================================================
	-- GDD §6.2 EXPLICIT — not in zone wild rosters (seasonal events / special)
	-- =========================================================================

	vampire = {
		Name    = "Vampire",
		Element = "dark",
		BaseStats  = { HP = 225, ATK = 38, DEF = 24, SPD = 24, CRT = 0.09 },
		StatGrowth = { HP = 14,  ATK = 6,  DEF = 4,  SPD = 2,  CRT = 0    },
		EvolutionStages = {
			{ Level = 1,   ModelId = "vampire_stage1" },
			{ Level = 75,  ModelId = "vampire_stage2" },   -- Elder Vampire
			{ Level = 300, ModelId = "vampire_stage3" },   -- Vampire Lord
		},
		SkillPool   = { "blood_drain", "bat_swarm", "dark_embrace", "hypnotic_gaze", "crimson_slash", "eternal_night" },
		BaseCapture = 0.10,
		Rarity      = "Epic",
		Lore        = "A creature of darkness and seasonal events. The Mountain Ruins dungeon contains its kin, but wild Vampires only surface under special conditions.",
	},
}
