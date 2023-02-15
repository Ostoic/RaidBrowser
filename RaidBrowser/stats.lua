RaidBrowser.stats = {};

local raid_translations
if GetLocale() ~= "enUS" then
	raid_translations = LibStub("LibBabble-Zone-3.0")
end

local raid_achievements = {
	
	rs = {
		4817, -- The Twilight Destroyer 10
		4815, -- The Twilight Destroyer 25
		4818, -- The Twilight Destroyer 10 HC
		4816, -- The Twilight Destroyer 25 HC
	},

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
		4532, -- Fall of the Lich King (10 NM)
		4597, -- The Frozen Throne (LK25 NM)
		4608, -- Fall of the Lich King (25 NM)
		4583, -- Bane of the Fallen King (LK10 HC)
		4636, -- Heroic: Fall of the Lich King (10 HC)
		4602, -- Glory of the Icecrown Raider 10
		4584, -- The Light of Dawn (LK25 HC)
		4637, -- Heroic: Fall of the Lich King (25 HC)
		4603, -- Glory of the Icecrown Raider 25
		4576, -- Realm First! Fall of the Lich King (25 HC)
	},

	toc = {
		3917, -- Call of the Crusade 10-man
		3916, -- Call of the Crusade 25-man
		3918, -- Call of the Grand Crusade (10 HC)
		3810, -- A Tribute to Insanity (10 HC)
		3812, -- Call of the Grand Crusade (25 HC)
		3819, -- A Tribute to Insanity (25 HC)
		4080, -- A Tribute to Dedicated Insanity (10 HC)
		4079, -- A Tribute to Immortality (25 HC Horde)
		4156, -- A Tribute to Immortality (25 HC Alliance)
		4078, -- Realm First! Grand Crusader
	},
	
	ulduar = {
		2894, -- The Secrets of Ulduar 10
		2895, -- The Secrets of Ulduar 25
		3036, -- Observed 10
		3037, -- Observed 25
		3141, -- Two Lights in the Darkness 10
		3158, -- One Light in the Darkness 10
		3159, -- Alone in the Darkness 10
		3162, -- Two Lights in the Darkness 25
		3163, -- One Light in the Darkness 25
		3004, -- He Feeds on your Tears 10
		3005, -- He Feeds on your Tears 25
		2957, -- Glory of the Ulduar Raider 10
		3316, -- Herald of the Titans
		3164, -- Alone in the Darkness 25
		2958, -- Glory of the Ulduar Raider 25
		3259, -- Realm First! Celestial Defender
		3117, -- Realm First! Death's Demise
	},
	
	eoe = {
		622, -- Spellweaver 10
		1874, -- You don't have an eternity 10
		623, -- Spellweaver 25
		1875, -- You don't have an eternity 25
		1400, -- Realm First! Magic Seeker
	},
	
	os = {
		1876, -- Besting the Black Dragonflight 10
		2049, -- Twilight Assist 10
		2050, -- Twilight Duo 10
		625, -- Besting the Black Dragonflight 25
		2052, -- Twilight Assist 25
		2051, -- Twilight Zone 10
		2053, -- Twilight Duo 25
		2054, -- Twilight Zone 25
		456, -- Realm First! Obsidian Slayer
	},
	
	naxx = {
		574, -- Kel'Thuzad's Defeat 10
		575, -- Kel'Thuzad's Defeat 25
		576, -- The Fall of Naxxramas 10
		577, -- The Fall of Naxxramas 25
		578, -- The Dedicated Few 10
		579, -- The Dedicated Few 25
		2187, -- The Undying 10
		2186, -- The Immortal 25
		2137, -- Glory of the Raider 10
		2138, -- Glory of the Raider 25
		1402, -- Realm First! Conqueror of Naxxramas
	},

	voa = {
		1722, -- Archavon the Stone Watcher 10
		3136, -- Emalon the Storm Watcher 10
		3836, -- Koralon the Flame Watcher 10
		4585, -- Toravon the Ice Watcher 10
		1721, -- Archavon the Stone Watcher 25
		3137, -- Emalon the Storm Watcher 25
		3837, -- Koralon the Flame Watcher 25
		4586, -- Toravon the Ice Watcher 25
	}
};

local spec_names = {
	full = {
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
		DeathKnightBlood = "Blood Death Knight",
		DeathKnightFrost = "Frost Death Knight",
		DeathKnightUnholy = "Unholy Death Knight",

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
		WarlockSummoning = "Demolition Warlock",
		WarlockDestruction = "Destruction Warlock",

		-- Druid
		DruidBalance = "Balance Druid",
		DruidFeralCombat = "Feral Druid",
		DruidRestoration = "Restoration Druid"
	},

	short = {
		WarriorArms = "Arms Warri",
		WarriorFury = "Fury Warri",
		WarriorProtection = "Prot Warri",

		PaladinHoly = "Holy Pala",
		PaladinProtection = "Prot Pala",
		PaladinCombat = "Retri Pala",

		HunterBeastMastery = "BM Hunt",
		HunterMarksmanship = "MM Hunt",
		HunterSurvival = "Surv Hunt",

		RogueAssassination = "Assa Rog",
		RogueCombat = "Combat Rog",
		RogueSubtlety = "Sub Rog",

		PriestDiscipline = "Disco Heal",
		PriestHoly = "Holy Priest",
		PriestShadow = "Shadow",

		DeathKnightBlood = "Blood DK",
		DeathKnightFrost = "Frost DK",
		DeathKnightUnholy = "Uh DK",

		ShamanElementalCombat = "Ele Shamy",
		ShamanEnhancement = "Enh Shamy",
		ShamanRestoration = "Resto Shamy",

		MageArcane = "Arcane Mage",
		MageFire = "Fire Mage",
		MageFrost = "Frost Mage",

		WarlockCurses = "Affli Lock",
		WarlockSummoning = "Demo Lock",
		WarlockDestruction = "Destro Lock",

		DruidBalance = "Boomy",
		DruidFeralCombat = "Feral",
		DruidRestoration = "Tree"
	}
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
		local fully_completed
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
	local _, class = UnitClass("player");

	-- If we're a feral druid, then we need to distinguish between tank and cat feral.
	if spec_name == 'DruidFeralCombat' then
		local thick_hide_talent = 5;
		local _, _, _, _, points = GetTalentInfo(active_tab, thick_hide_talent)
		if points > 1 then
			return 'Feral Druid (Tank)'
		else
			return 'Feral Druid (DPS)'
		end
	end
	
	-- If we're a death knight, then we need to distinguish between tank and dps.
	if class == 'DEATHKNIGHT' then
		local toughness_talent = 3;
		local _, _, _, _, points = GetTalentInfo(2, toughness_talent)
		local _, _, _, _, points2 = GetTalentInfo(1, 3)
		if points > 3 and points2 > 3 then
			return spec_name .. ' (Tank)'
		else
			return spec_name .. ' (DPS)'
		end
	end

	-- TODO: make config to toggle using full or short spec names
	return spec_names["full"][spec_name] or spec_name;
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

		-- older GearScore version does not return gs on method call
		if gs == nil and GS_Data then
			if GS_Data[GetRealmName()] and GS_Data[GetRealmName()].Players[UnitName("player")] then
				gs = GS_Data[GetRealmName()].Players[UnitName("player")]["GearScore"]
			end
		end
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

---@param set 'Primary'|'Secondary'
---@return string?, integer?
---@nodiscard
function RaidBrowser.stats.get_raidset(set)
	local raidset1 = RaidBrowserCharacterRaidsets['Primary'] or nil;
	local raidset2 = RaidBrowserCharacterRaidsets['Secondary'] or nil;
	if not (raidset1 or raidset2) then
		return
	elseif (raidset1 and raidset2) then
		return raidset1.spec , raidset1.gs , raidset2.spec , raidset2.gs
	elseif raidset1 then
		return raidset1.spec, raidset1.gs
	elseif raidset2 then
		return raidset2.spec, raidset2.gs
	end
end

---@return string?, integer?
function RaidBrowser.stats.current_raidset()
	if RaidBrowserCharacterCurrentRaidset == 'Active' then
		return RaidBrowser.stats.get_active_raidset();
		
	elseif RaidBrowserCharacterCurrentRaidset == 'Both' then
		return RaidBrowser.stats.get_raidsets();
	end

	---@diagnostic disable-next-line: param-type-mismatch
	return RaidBrowser.stats.get_raidset(RaidBrowserCharacterCurrentRaidset);
end

---@param set 'Active' | 'Primary' | 'Secondary' | 'Both'
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
	local message = 'inv ';
	local class = UnitClass("player");
	
	local spec1, gs1, spec2, gs2 = RaidBrowser.stats.current_raidset();
	if spec1 and gs1 then
		message = message .. gs1 .. 'gs ' .. spec1
	end
	if spec1 and gs1 and spec2 and gs2 then
		message = message .. ' / '
	end
	if spec2 and gs2 then
		message = message .. gs2 .. 'gs ' .. spec2
	end
	message = message .. ' ' .. class;
	
	-- Remove difficulty and raid_name size from the string
	raid_name = string.gsub(raid_name, '[1|2][0|5](%w*)', '');
	
	-- Find the best possible achievement for the given raid_name.
	local achieve_id = find_best_achievement(raid_name);
	if achieve_id then
		message = message .. ' ' .. GetAchievementLink(achieve_id);
	end

	return message;
end
