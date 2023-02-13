RaidBrowser.stats = {};

local raid_translations
if GetLocale() ~= "enUS" then
	raid_translations = LibStub("LibBabble-Zone-3.0")
end

local raid_achievements = {
	icc = {
		4531, -- Storming the Citadel 10-man
		4604, -- Storming the Citadel 25-man
		4628, -- Storming the Citadel 10-man HC
		4632, -- Storming the Citadel 25-man HC
		4528, -- The Plagueworks 10-man
		4605, -- The Plagueworks 25-man
		4629, -- The Plagueworks 10-man HC
		4633, -- The Plagueworks 25-man HC
		4529, -- The Crimson Hall 10-man
		4606, -- The Crimson Hall 25-man
		4630, -- The Crimson Hall 10-man HC
		4634, -- The Crimson Hall 25-man HC
		4527, -- The Frostwing Halls 10-man
		4607, -- The Frostwing Halls 25-man
		4631, -- The Frostwing Halls 10-man HC
		4635, -- The Frostwing Halls 25-man HC
		4530, -- The Frozen Throne (LK10 NM)
		4597, -- The Frozen Throne (LK25 NM)
		4583, -- Bane of the Fallen King (LK10 HC)
		4584, -- The Light of Dawn (LK25 HC)
	},

	toc = {
		3917, -- Call of the Crusade 10-man
		3916, -- Call of the Crusade 25-man
		3918, -- Call of the Grand Crusade (10 HC)
		3812, -- Call of the Grand Crusade (25 HC)
	},

	rs = {
		4817, -- The Twilight Destroyer 10
		4815, -- The Twilight Destroyer 25
		4818, -- The Twilight Destroyer 10 HC
		4816, -- The Twilight Destroyer 25 HC
	},
};

local full_spec_names = {
	-- Warrior
	WarriorArms = "Arms Warrior",
	WarriorFury = "Fury Warrior",
	WarriorProtection = "Protection Warrior",

	-- Paladin
	PaladinHoly = "Holy Paladin",
	PaladinProtection = "Protection Paladin",
	PaladinCombat = "Retribution Paladin",

	-- Hunter
	HunterBeastMastery = "Beastmaster Hunter",
	HunterMarksmanship = "Marksman Hunter",
	HunterSurvival = "Survival Hunter",

	-- Rogue
	RogueAssassination = "Assassination Rogue",
	RogueCombat = "Combat Rogue",
	RogueSubtlety = "Subtlety Rogue",

	-- Priest
	PriestDiscipline = "Discipline Priest",
	PriestHoly = "Holy Priest",
	PriestShadow = "Shadow Priest",

	-- DK
	DeathKnightBlood = "Blood DK",
	DeathKnightFrost = "Frost DK",
	DeathKnightUnholy = "Unholy DK",

	-- Shaman
	ShamanElementalCombat = "Elemental Shaman",
	ShamanEnhancement = "Enhancement Shaman",
	ShamanRestoration = "Restoration Shaman",

	-- Mage
	MageArcane = "Arcane Mage",
	MageFire = "Fire Mage",
	MageFrost = "Frost Mage",

	-- Warlock
	WarlockCurses = "Affliction Warlock",
	WarlockSummoning = "Demo Warlock",
	WarlockDestruction = "Destruction Warlock",

	-- Druid
	DruidBalance = "Balance Druid",
	DruidFeralCombat = "Feral Druid",
	DruidRestoration = "Restroration Druid"
}

---@param raid string The name of the achievement ids table
---@nodiscard
local function find_best_achievement(raid)
	local ids = raid_achievements[raid];
	if not ids then
		return nil;
	end

	local max_achievement = nil;

	-- Find the highest ranking completed achievement
	for i, id in ipairs(ids) do
		local _, _, _, completed = GetAchievementInfo(id);
		if completed and (not max_achievement or max_achievement[1] <= i) then
			max_achievement = { i, id };
		end
	end

	-- Find the highest ranking completed achievement criterion
	for i, id in ipairs(ids) do
		for j = 1, GetAchievementNumCriteria(id) do
			local _, _, completed = GetAchievementCriteriaInfo(id, j)
			if completed and (not max_achievement or max_achievement[1] <= i) then
				max_achievement = { i, id };
			end
		end
	end

	if max_achievement then
		return max_achievement[2];
	else
		return nil;
	end
end

-- Function wrapper around GetTalentTabInfo
---@param i integer
---@return integer
---@nodiscard
local function GetTalentTabPoints(i)
	local _, _, pts = GetTalentTabInfo(i)
	return pts;
end

function RaidBrowser.stats.active_spec_index()
	local indices = std.algorithm.transform({ 1, 2, 3 }, GetTalentTabPoints)
	local i, _ = std.algorithm.max_of(indices);
	return i;
end

---@return string
---@nodiscard
function RaidBrowser.stats.active_spec()
	local active_tab = RaidBrowser.stats.active_spec_index()
	local _, _, _, spec_name = GetTalentTabInfo(active_tab);

	-- If we're a feral druid, then we need to distinguish between tank and cat feral.
	if spec_name == 'DruidFeralCombat' then
		local protector_of_pack_talent = 22;
		local _, _, _, _, points = GetTalentInfo(active_tab, protector_of_pack_talent)
		if points > 0 then
			return 'Feral Druid (Bear)'
		else
			return 'Feral Druid (Cat)'
		end
	end

	return full_spec_names[spec_name] or spec_name;
end

---Return if the given raid is locked, and if so its reset time left (in seconds)
---@param raid_info any
---@return boolean, integer | nil
---@nodiscard
function RaidBrowser.stats.raid_lock_info(raid_info)
	local instance_name = raid_info.instance_name
	if raid_translations then
		instance_name = raid_translations:GetUnstrictLookupTable()[raid_info.instance_name] or raid_info.instance_name
	end

	if instance_name == nil or raid_info.size == nil then return false, nil end
	for i = 1, GetNumSavedInstances() do
		local saved_name, _, reset, _, locked, _, _, _, saved_size = GetSavedInstanceInfo(i);
		if saved_name ~= nil then
			-- @napnapnap lockout fix (c8207076730d04f41b881dea3dd9f6ca32655372)
			if string.lower(saved_name) == string.lower(instance_name) and saved_size == raid_info.size and locked then
				return true, reset;
			end
		end
	end

	return false, nil;
end

---Returns for the currently active raidset, the spec name and its gearscore.
---@return string, integer
---@nodiscard
function RaidBrowser.stats.get_active_raidset()
	local spec = nil;
	local gs = nil;

	-- Retrieve gearscore if GearScoreLite is installed
	if GearScore_GetScore then
		gs = GearScore_GetScore(UnitName('player'), 'player');
	end

	spec = RaidBrowser.stats.active_spec();
	return spec, gs;
end

---@param set 'Primary'|'Secondary'
---@return string?, integer?
---@nodiscard
function RaidBrowser.stats.get_raidset(set)
	local raidset = RaidBrowserCharacterRaidsets[set];
	if not raidset then return end
	return raidset.spec, raidset.gs;
end

---@return string?, integer?
function RaidBrowser.stats.current_raidset()
	local x = 0
	if RaidBrowserCharacterCurrentRaidset == 'Active' then
		return RaidBrowser.stats.get_active_raidset();
	end

	---@diagnostic disable-next-line: param-type-mismatch
	return RaidBrowser.stats.get_raidset(RaidBrowserCharacterCurrentRaidset);
end

---@param set 'Active' | 'Primary' | 'Secondary'
function RaidBrowser.stats.select_current_raidset(set)
	RaidBrowserCharacterCurrentRaidset = set;
end

function RaidBrowser.stats.save_primary_raidset()
	local spec, gs = RaidBrowser.stats.get_active_raidset();
	RaidBrowserCharacterRaidsets['Primary'] = { spec = spec, gs = gs };
end

function RaidBrowser.stats.save_secondary_raidset()
	local spec, gs = RaidBrowser.stats.get_active_raidset();
	RaidBrowserCharacterRaidsets['Secondary'] = { spec = spec, gs = gs };
end

---Returns join message string
---@param raid_name string
---@return string
---@nodiscard
function RaidBrowser.stats.build_join_message(raid_name)
	local spec, gs = RaidBrowser.stats.current_raidset();

	-- local message = 'inv ' .. gs .. 'gs ' .. spec;
	local message = 'inv for ' .. raid_name .. " - " .. gs .. 'gs ' .. spec;

	-- Remove difficulty and raid_name size from the string
	raid_name = RaidBrowser.get_short_raid_name(raid_name)

	-- Find the best possible achievement for the given raid_name.
	local achieve_id = find_best_achievement(raid_name);
	if achieve_id then
		message = message .. ' ' .. GetAchievementLink(achieve_id);
	end

	return message;
end
