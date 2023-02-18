raid_browser.stats = {};

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
	
	togc = {
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
			max_achievement = {i, id};
		end		 
	end
	
	-- Find the highest ranking completed achievement criterion
	for i, id in ipairs(ids) do
		local fully_completed
		for j = 1, GetAchievementNumCriteria(id) do
			local _, _, completed = GetAchievementCriteriaInfo(id, j)
			if not completed then
				fully_completed = false
				break
			end
			fully_completed = true	 
		end
		if fully_completed and (not max_achievement or max_achievement[1] <= i) then
			max_achievement = {i, id};
		end
	end
	
	if max_achievement then
		return max_achievement[2];
	else 
		return nil;
	end
end

-- Function wrapper around GetTalentTabInfo
local function GetTalentTabPoints(i)
	local _, _, pts = GetTalentTabInfo(i)
	return pts;
end

function raid_browser.stats.active_spec_index()
	local indices = std.algorithm.transform({1, 2, 3}, GetTalentTabPoints)
	local i, v = std.algorithm.max_of(indices);
	return i;
end

function raid_browser.stats.active_spec()
	local active_tab = raid_browser.stats.active_spec_index()
	local tab_name = GetTalentTabInfo(active_tab);
	local _,class = UnitClass("player");
	
	-- If we're a feral druid, then we need to distinguish between tank and cat feral.
	if tab_name == 'Feral Combat' then
		local protector_of_pack_talent = 22;
		local thick_hide_talent = 5;
		local _, _, _, _, points = GetTalentInfo(active_tab, thick_hide_talent)
		if points > 1 then
			return 'Feral (Tank)'
		else
			return 'Feral (DPS)'
		end
	end
	
	-- If we're a death knight, then we need to distinguish between tank and dps.
	if class == 'DEATHKNIGHT' then
		local toughness_talent = 3;
		local blade_barrier_talent = 3;
		local _, _, _, _, points = GetTalentInfo(2, toughness_talent)
		local _, _, _, _, points2 = GetTalentInfo(1, 3)
		if points > 3 and points2 > 3 then
			return tab_name .. ' (Tank)'
		else
			return tab_name .. ' (DPS)'
		end
	end
	
	return tab_name;
end

function raid_browser.stats.raid_lock_info(instance_name, size)
	if instance_name == nil or size == nil then return false, nil end
	for i = 1, GetNumSavedInstances() do
		local saved_name, _, reset, _, locked, _, _, _, saved_size = GetSavedInstanceInfo(i);
		if saved_name ~= nil then
			-- @napnapnap lockout fix (c8207076730d04f41b881dea3dd9f6ca32655372)
			if string.lower(saved_name) == string.lower(instance_name) and saved_size == size and locked then
				return true, reset;
			end
		end		
	end
	
	return false, nil;
end

function raid_browser.stats.get_active_raidset()
	local spec = nil;
	local gs = nil;
	
	-- Retrieve gearscore if GearScoreLite is installed
	if GearScore_GetScore then 
		gs = GearScore_GetScore(UnitName('player'), 'player');
	end
	
	spec = raid_browser.stats.active_spec();
	return spec, gs;
end

function raid_browser.stats.get_raidset(set)
	local raidset = raid_browser_character_raidsets[set];
	if not raidset then return end;
	return raidset.spec, raidset.gs;
end

function raid_browser.stats.get_raidsets()
	local raidset1 = raid_browser_character_raidsets['Primary'] or nil;
	local raidset2 = raid_browser_character_raidsets['Secondary'] or nil;
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

function raid_browser.stats.current_raidset()
	if raid_browser_character_current_raidset == 'Active' then
		return raid_browser.stats.get_active_raidset();
	elseif raid_browser_character_current_raidset == 'Both' then
		return raid_browser.stats.get_raidsets();
	end
	
	return raid_browser.stats.get_raidset(raid_browser_character_current_raidset);
end

function raid_browser.stats.select_current_raidset(set)
	raid_browser_character_current_raidset = set;
end

function raid_browser.stats.save_primary_raidset()
	local spec, gs = raid_browser.stats.get_active_raidset();
	raid_browser_character_raidsets['Primary'] = {spec = spec, gs = gs};
end

function raid_browser.stats.save_secondary_raidset()
	local spec, gs = raid_browser.stats.get_active_raidset();
	raid_browser_character_raidsets['Secondary'] = {spec = spec, gs = gs};
end

function raid_browser.stats.build_inv_string(raid_name)
	local message = 'inv ';
	local class = UnitClass("player");
	
	local spec1, gs1, spec2, gs2 = raid_browser.stats.current_raidset();
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