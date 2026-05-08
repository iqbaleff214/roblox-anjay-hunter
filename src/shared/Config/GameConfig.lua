-- src/shared/Config/GameConfig.lua
-- Global gameplay tuning constants. One flat table — no nested tables.
-- Change a value here; all consuming services pick it up without code edits.
-- GDD references are cited per constant for traceability.

return {

	-- =========================================================================
	-- BATTLE / PARTY  (GDD §8)
	-- =========================================================================

	-- Maximum human players per co-op dungeon instance. GDD §7.2.
	MAX_PARTY_SIZE              = 2,

	-- Maximum pets in ActivePetIds (walk alongside player + fight). GDD §6.1, §16.1.
	MAX_ACTIVE_PETS             = 2,

	-- =========================================================================
	-- PET ROSTER  (GDD §6.1)
	-- =========================================================================

	-- Starting pet slots awarded to every new player. GDD §6.1 ("Default slots: 2"), §16.1.
	PET_SLOTS_DEFAULT           = 2,

	-- Starting pet slots with Slot Booster game pass. GDD §15.2.
	PET_SLOTS_SLOT_BOOSTER      = 10,

	-- Absolute ceiling on PetSlots regardless of upgrades. GDD §6.1 ("Maximum slots: 500").
	PET_ROSTER_LIMIT            = 500,

	-- =========================================================================
	-- SKILL SLOTS  (GDD §6.7)
	-- =========================================================================

	-- Default equipped skill slots on a freshly created pet. GDD §16.1 (PetData.SkillSlots).
	SKILL_SLOTS_DEFAULT         = 2,

	-- Hard cap on purchasable skill slots per pet. GDD §6.7 (last explicit tier: Slot 6+).
	MAX_SKILL_SLOTS             = 6,

	-- =========================================================================
	-- HUNT ENERGY  (GDD §5.4)
	-- =========================================================================

	-- Maximum HuntEnergy a player can hold. GDD §5.4 ("Max: 100"), §16.1.
	ENERGY_MAX                  = 100,

	-- Minutes between each regen tick. 10 energy/hour → 1 energy per 6 minutes. GDD §5.4.
	ENERGY_REGEN_RATE_MINUTES   = 6,

	-- Energy units restored per regen tick. GDD §5.4 ("10 per hour" → 1 per 6 min).
	ENERGY_REGEN_AMOUNT         = 1,

	-- Energy deducted on wild beast encounter initiation. GDD §5.4.
	ENERGY_COST_WILD            = 10,

	-- Energy deducted on dungeon run entry. GDD §7.2 ("Hunt Energy cost per run: 25").
	ENERGY_COST_DUNGEON         = 25,

	-- =========================================================================
	-- CURRENCY  (GDD §5.3, §13)
	-- =========================================================================

	-- Reference conversion for display / pricing helpers (not a live exchange). GDD §5.3.
	SILVER_PER_GOLD             = 100,

	-- =========================================================================
	-- PET LEVELS & PROGRESSION  (GDD §6.4)
	-- =========================================================================

	-- Global level cap for all pets. GDD §6.4 ("Max level: 1,000").
	PET_MAX_LEVEL               = 1000,

	-- Level at which pets become eligible for element imbuing. GDD §6.4, §6.5.
	ELEMENT_UNLOCK_LEVEL        = 50,

	-- =========================================================================
	-- EXPEDITIONS  (GDD §9.4, §15.2)
	-- =========================================================================

	-- Default expedition slots for new players. GDD §9.4 ("slots default to 1").
	EXPEDITION_SLOT_BASE        = 1,

	-- Expedition slots with Expedition Master game pass. GDD §15.2 ("1 → 3").
	EXPEDITION_SLOT_VIP         = 3,

	-- Duration in seconds for each expedition tier. GDD §9.4.
	EXPEDITION_DURATION_SHORT   = 3600,    -- 1 hour
	EXPEDITION_DURATION_MEDIUM  = 14400,   -- 4 hours
	EXPEDITION_DURATION_LONG    = 43200,   -- 12 hours

	-- =========================================================================
	-- DUNGEONS  (GDD §7.2, §15.2)
	-- =========================================================================

	-- Daily run limit per dungeon for non-VIP players. GDD §7.2 ("3 runs, resets midnight UTC").
	DAILY_DUNGEON_LIMIT         = 3,

	-- Daily run limit with Dungeon Veteran game pass (+1 run). GDD §15.2.
	DAILY_DUNGEON_LIMIT_VIP     = 4,

	-- Maximum human players in a single dungeon instance. GDD §7.2 ("1–2 players").
	MAX_PLAYERS_DUNGEON         = 2,

	-- =========================================================================
	-- DAILY QUESTS  (GDD §9.1, §15.2)
	-- =========================================================================

	-- Quests assigned per day for standard players. GDD §9.1 ("5 quests per day").
	DAILY_QUEST_COUNT           = 5,

	-- Quests assigned per day with Hunter's VIP pass (+1 slot). GDD §9.1, §15.2.
	DAILY_QUEST_COUNT_VIP       = 6,

	-- Bonus Gold awarded for completing all daily quests. GDD §9.1.
	DAILY_QUEST_BONUS_GOLD      = 50,

	-- =========================================================================
	-- CODEX  (GDD §6.8)
	-- =========================================================================

	-- Silver awarded on first codex entry for any species. GDD §6.8 (first-capture unlock).
	CODEX_REWARD_SILVER         = 100,

	-- =========================================================================
	-- REPUTATION & TITLES  (GDD §5.1, §9.7)
	-- =========================================================================

	-- Base reputation awarded per NPC trainer win. GDD §5.1, §9.7.
	REPUTATION_PER_NPC_WIN      = 10,

	-- Reputation floor for the first rank title unlock (Iron rank). GDD §5.1.
	TITLE_UNLOCK_REPUTATION     = 500,

	-- PvP reputation change constants. GDD §5.1.
	REP_WIN_VS_LOWER            = 15,
	REP_WIN_VS_SAME             = 25,
	REP_WIN_VS_HIGHER           = 40,
	REP_LOSE_VS_LOWER           = -25,
	REP_LOSE_VS_SAME            = -15,
	REP_LOSE_VS_HIGHER          = -5,

	-- =========================================================================
	-- SERVER CAPACITY  (GDD §1)
	-- =========================================================================

	-- Max players per hub/overworld server. GDD §1.
	MAX_PLAYERS_HUB             = 20,
}
