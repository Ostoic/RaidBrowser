raid_browser.stats = {};

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
		for j = 1, GetAchievementNumCriteria(id) do
			local _, _, completed = GetAchievementCriteriaInfo(id, j)
			if completed and (not max_achievement or max_achievement[1] <= i) then
				max_achievement = {i, id};
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
	
	-- If we're a feral druid, then we need to distinguish between tank and cat feral.
	if tab_name == 'Feral Combat' then
		local protector_of_pack_talent = 22;
		local _, _, _, _, points = GetTalentInfo(active_tab, protector_of_pack_talent)
		if points > 0 then
			return 'Feral (Bear)'
		else
			return 'Feral (Cat)'
		end
	end
	
	return tab_name;
end

function raid_browser.stats.raid_lock_info(instance_name, size)
	if instance_name == nil or size == nil then return false, nil end
	
	for i = 1, GetNumSavedInstances() do
		local saved_name, _, reset, _, _, _, _, _, saved_size = GetSavedInstanceInfo(i);
		if saved_name ~= nil then 
			if string.lower(saved_name) == string.lower(instance_name) and saved_size == size then
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

function raid_browser.stats.current_raidset()
	if raid_browser_character_current_raidset == 'Active' then
		return raid_browser.stats.get_active_raidset();
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
	
	local spec, gs = raid_browser.stats.current_raidset();
	message = message .. gs .. 'gs ' .. spec .. ' ' .. class;
	
	-- Remove difficulty and raid_name size from the string
	raid_name = string.gsub(raid_name, '[1|2][0|5](%w+)', '');
	
	-- Find the best possible achievement for the given raid_name.
	local achieve_id = find_best_achievement(raid_name);
	if achieve_id then
		message = message .. ' ' .. GetAchievementLink(achieve_id);
	end
	
	return message;
end