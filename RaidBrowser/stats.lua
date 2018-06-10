raid_browser.stats = {};

local raid_achievements = {
	icc = {
		4604, -- Storming the Citadel 25-man
		4531, -- Storming the Citadel 10-man
		4632, -- Storming the Citadel 25-man HC
		4628, -- Storming the Citadel 10-man HC
		4605, -- The Plagueworks 25-man
		4528, -- The Plagueworks 10-man
		4633, -- The Plagueworks 25-man HC
		4629, -- The Plagueworks 10-man HC
		4606, -- The Crimson Hall 25-man
		4529, -- The Crimson Hall 10-man
		4634, -- The Crimson Hall 25-man HC
		4630, -- The Crimson Hall 10-man HC
		4607, -- The Frostwing Halls 25-man
		4527, -- The Frostwing Halls 10-man
		4635, -- The Frostwing Halls 25-man HC
		4631, -- The Frostwing Halls 10-man HC
		4597, -- The Frozen Throne (LK25 NM)
		4530, -- The Frozen Throne (LK10 NM)
		4584, -- The Light of Dawn (LK25 HC)
		4583, -- Bane of the Fallen King (LK10 HC)
	},
	
	toc = {
		3916, -- Call of the Crusade 25-man
		3917, -- Call of the Crusade 10-man  
		3812, -- Call of the Grand Crusade (25 HC)
		3918, -- Call of the Grand Crusade (10 HC)
	},
	
	rs = {
		4815, -- The Twilight Destroyer 25
		4817, -- The Twilight Destroyer 10
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

local function get_active_spec()
	local index = 1;
	local _, _, points = GetTalentTabInfo(index);
	for i = 2, 3 do
		local _, _, p = GetTalentTabInfo(i);
		if (p > points) then
			index = i;
		end
	end
	
	return GetTalentTabInfo(index)
end

function raid_browser.stats.raid_lock_info(instance_name, size)
	for i = 1, GetNumSavedInstances() do
		local saved_name, _, reset, _, _, _, _, _, saved_size = GetSavedInstanceInfo(i);
		
		if saved_name == instance_name and saved_size == size then
			return true, reset;
		end
	end
	
	return false, nil;
end

function raid_browser.stats.build_inv_string(raid_name)
	local message = 'inv ';
	local class = UnitClass("player");
	
	local gs = '';
	
	-- Retrieve gearscore if GearScoreLite is installed
	if GearScore_GetScore then 
		gs = GearScore_GetScore(UnitName('player'), 'player');
		gs = gs .. 'gs ';
	end
	
	local spec = get_active_spec();
	message = message .. gs .. spec .. ' ' .. class;
	
	-- Remove difficulty and raid_name size from the string
	raid_name = string.gsub(raid_name, '[1|2][0|5](%w+)', '');
	
	-- Find the best possible achievement for the given raid_name.
	local achieve_id = find_best_achievement(raid_name);
		if achieve_id then
		message = message .. ' ' .. GetAchievementLink(achieve_id);
	end
	
	return message;
end













