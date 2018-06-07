-- Register addon
raid_browser = LibStub("AceAddon-3.0"):NewAddon("RaidBrowser", "AceConsole-3.0")

local function table_copy(t)
	local copy = {};
	
	for k, v in pairs(t) do
		copy[k] = v;
	end
	
	return copy;
end

-- Raid patterns template for a raid with 2 difficulties and 2 sizes
local raid_patterns_template = {
	hc = {
		'<raid>[%s-_]*<size>[%s-_]*m?a?n?[%s-_]*%(?hc?%)?',
		'%(?hc?%)?[%s-_]*<raid>[%s-_]*<size>',
		'<raid>[%s-_]*%(?hc?%)?[%s-_]*<size>',
		'<size>[%s-_]*m?a?n?[%s-_]*<raid>[%s-_]*%(?hc?%)?',
	},
	
	nm = {
		'<raid>[%s-_]*<size>[%s-_]*m?a?n?[%s-_]*%(?hc?%)?',
		'%(?hc?%)?[%s-_]*<raid>[%s-_]*<size>',
		'<raid>[%s-_]*%(?hc?%)?[%s-_]*<size>',
		'<size>[%s-_]*m?a?n?[%s-_]*<raid>[%s-_]*%(?hc?%)?',
		'<raid>[%s-_]*<size>',
	}
};

local function create_raid_patterns(raid_name_pattern, size, difficulty)
	if not raid_name_pattern or not size or not difficulty then
		return;
	end
	
	local patterns = table_copy(raid_patterns_template[difficulty]);
	
	-- Replace placeholders with the specified raid info
	for i, pattern in ipairs(patterns) do
		pattern = string.gsub(pattern, '<raid>', raid_name_pattern);
		pattern = string.gsub(pattern, '<size>', size);
		patterns[i] = pattern;
	end
	
	return patterns;
end
			
local raid_list = {
	-- Note: The order of each raid is deliberate.
	-- Heroic raids are checked first, since NM raids will have the default 'icc10' pattern. 
	-- Be careful about changing the order of the raids below
	{
		name = 'icc25rep',
		instance_name = 'Icecrown Citadel',
		size = 25,
		patterns = {
			'icc[%s-_]*25[%s-_]*m?a?n?[%s-_]*rep[%s-_]*',
			'icc[%s-_]*rep[%s-_]*25[%s-_]*m?a?n?',
		}
	},
	
	{
		name = 'icc10rep',
		instance_name = 'Icecrown Citadel',
		size = 10,
		patterns = {
			'icc[%s-_]*10[%s-_]*m?a?n?[%s-_]*rep[%s-_]*',
			'icc[%s-_]*rep[%s-_]*10',
			 'icc[%s-_]*rep',
		}
	},
	
	{
		name = 'icc10hc',
		instance_name = 'Icecrown Citadel',
		size = 10,
		patterns = create_raid_patterns('icc', 10, 'hc');
	},

	{
		name = 'icc25hc',
		instance_name = 'Icecrown Citadel',
		size = 25,
		patterns = create_raid_patterns('icc', 25, 'hc'),
	},

	{
		name = 'icc10nm',
		instance_name = 'Icecrown Citadel',
		size = 10,
		patterns = create_raid_patterns('icc', 10, 'nm'),
	},

	{
		name = 'icc25nm',
		instance_name = 'Icecrown Citadel',
		size = 25,
		patterns = create_raid_patterns('icc', 25, 'nm'),
	},

	{
		name = 'toc10hc',
		instance_name = 'Trial of the Crusader',
		size = 10,
		patterns = create_raid_patterns('toc', 10, 'hc'),
	},

	{
		name = 'toc25hc',
		instance_name = 'Trial of the Crusader',
		size = 25,
		patterns = create_raid_patterns('toc', 25, 'hc'),
	},

	{
		name = 'toc10nm',
		instance_name = 'Trial of the Crusader',
		size = 10,
		patterns = create_raid_patterns('toc', 10, 'nm'),
	},

	{
		name = 'toc25nm',
		instance_name = 'Trial of the Crusader',
		size = 25,
		patterns = create_raid_patterns('toc', 25, 'nm'),
	},
	
	{
		name = 'rs10hc',
		instance_name = 'The Ruby Sanctum',
		size = 10,
		patterns = create_raid_patterns('rs', 10, 'hc'),
	},

	{
		name = 'rs25hc',
		instance_name = 'The Ruby Sanctum',
		size = 25,
		patterns = create_raid_patterns('rs', 25, 'hc'),
	},

	{
		name = 'rs10nm',
		instance_name = 'The Ruby Sanctum',
		size = 10,
		patterns = create_raid_patterns('rs', 10, 'nm'),
	},

	{
		name = 'rs25nm',
		instance_name = 'The Ruby Sanctum',
		size = 25,
		patterns = create_raid_patterns('rs', 25, 'nm'),
	},
	
	{
		name = 'voa10',
		instance_name = 'Vault of Archavon',
		size = 10,
		patterns = {"voa[%s-_]*10"},
	},
	
	{
		name = 'voa25',
		instance_name = 'Vault of Archavon',
		size = 25,
		patterns = {"voa[%s-_]*25"},
	},
		
	{
		name = 'ulduar10',
		instance_name = 'Ulduar',
		size = 10,
		patterns = {
			'uldu?a?r?[%s-_]*10',
		},
	},
	
	{
		name = 'ulduar25',
		instance_name = 'Ulduar',
		size = 25,
		patterns = {
			'uldu?a?r?[%s-_]*25',
		}
	},
	
	{
		name = 'os10',
		instance_name = 'The Obsidian Sanctum',
		size = 10,
		patterns = {
			'os[%s-_]*10',
		},
	},
	
	{
		name = 'os25',
		instance_name = 'The Obsidian Sanctum',
		size = 25,
		patterns = {
			'os[%s-_]*25',
		},
	},
	
	{
		name = 'naxx10',
		instance_name = 'Naxxramas',
		size = 10,
		patterns = {
			'naxx?r?a?m?m?a?s?[%s-_]*10',
		},
	},
	
	{
		name = 'naxx25',
		instance_name = 'Naxxramas',
		size = 25,
		patterns = {
			'naxx?r?a?m?m?a?s?[%s-_]*25',
		},
	},
	
	{
		name = 'onyxia25',
		instance_name = 'Onyxia\'s Lair',
		size = 25,
		patterns = {
			'onyx?i?a?[%s-_]*25'
		},
	},
	
	{
		name = 'onyxia10',
		instance_name = 'Onyxia\'s Lair',
		size = 10,
		patterns = {
			'onyx?i?a?[%s-_]*10'
		},
	},
	
	{
		name = 'karazhan',
		instance_name = 'Karazhan',
		size = 25,
		patterns = {
			'karaz?h?a?n?[%s-_]*[12]?[05]?', -- karazhan 
		},
	}
}

local role_patterns = {
	ranged_dps = {
		"[0-9]*[%s]*rdps",
		'[0-9]*[%s]*w?a?r?lock',
		'[0-9]*[%s]*spri?e?st',
		'[0-9]*[%s]*elem?e?n?t?a?l?',
		'[0-9]*[%s]*mage',
		'[0-9]*[%s]*hunte?r?s?',
	},
	
	melee_dps = {
		'[0-9]*[%s]*mdps',
		'[0-9]*[%s]*rogue',
		'[0-9]*[%s]*kitt?y?',
		'[0-9]*[%s]*feral',
		'[0-9]*[%s]*ret[%s]*pal[a|l]?[dy]i?n?',
	},
	
	dps = {
		'[0-9]*[%s]*dps',
	},
	
	healer = {
		'[0-9]*[%s]*he[a]?l[er|ers]*', -- LF healer
		'[0-9]*[%s]*rd[ru][ud][iu]d?', -- LF rdruid/rdudu
		'[0-9]*[%s]*tree', 			   -- LF tree
		'[0-9]*[%s]*re?s?t?o?[%s]*shamm?y?', -- LF rsham
		-- disc priest
		'[0-9]*[%s]*hpala',			   -- LF hpala
	},
	
	tank = {
		'[0-9]*[%s]*t[a]?nk[s]?',
		'[0-9]*[mo]t',				-- Need MT/OT
		'[0-9]*[%s]*bears?',
	},
}

local gearscore_patterns = {
	'[1-6][.,][0-9]',
	'[1-6][%s]*k[%s]*%+?',
	'%+?[%s]*[1-6][%s]*k',
	'[1-6][0-9][0-9][0-9]',
	'[1-6]%+',
}

local lfm_patterns = {
	'lf[0-9]*m',
	'looking[%s]*for[%s]*all',
	'looking[%s]*for[%s]*[0-9]*[%s]*more',		-- looking for 9 more
	'lf[%s]*.*for',								-- LF <any characters> for 
	'lf[%s]*[0-9]*[%s]*he[a]?l[er|ers]*',		-- LF healer
	'lf[%s]*[0-9]*[%s]*t[a]?nk[s]?',			-- LF 5 tanks
	'lf[%s]*[0-9]*[%s]*[mr]?dps',				-- LF 9 DPS
	'seek[%s]*[0-9]*[%s]*he[a]?l[er|ers]*',		-- seek healer
	'seek[%s]*[0-9]*[%s]*t[a]?nk[s]?',			-- seek 5 tanks
	'seek[%s]*[0-9]*[%s]*[mr]?dps',				-- seek 9 DPS
	'lf[%s]*all',
	'need',
	'need[%s]*all',
	'whispe?r?[%s]*me',
	--'[%s]/w[%s]*[%a]+', -- Too greedy
}

local guild_recruitment_patterns = {
	'recrui?ti?ng',
	'recrui?t',
	'autorecruit',
	'raid[%s]*time',
	'active[%s]*raiders?',
	'is[%s]*a[%s]*[%a]*[%s]*[pvep][pvep][pvep][%s]*guild',
};

local function refresh_lfm_messages()
	for name, info in pairs(raid_browser.lfm_messages) do
		-- If the last message from the sender was too long ago, then
		-- remove his raid from lfm_messages.
		if time() - info.time > raid_browser.expiry_time then
			raid_browser.lfm_messages[name] = nil;
		end
	end
end

local function remove_achievement_text(message)
	return string.gsub(message, '|c.*|r', '');
end

local function format_gs_string(gs)
	local formatted = string.gsub(gs, '[%s]*%+?', ''); -- Trim whitespace
	formatted  = string.gsub(formatted , 'k', '')
	formatted  = string.gsub(formatted , ',', '.');
	formatted  = tonumber(formatted);

	-- Convert ex: 5800 into 5.8 for display
	if formatted  > 1000 then
		formatted  = formatted /1000;
	end

	return string.format('%.1f', formatted );
end

local function is_guild_recruitment(message)
	for _, pattern in ipairs(guild_recruitment_patterns) do
		if string.find(message, pattern) then
			return true;
		end
	end
	
	return false;
end

-- Basic http pattern matching for streaming sites and etc.
local function remove_http_links(message)
	local http_pattern = 'https?://*[%a]*.[%a]*.[%a]*/?[%a%-%%0-9_]*/?';
	return string.gsub(message, http_pattern, '');
end

function raid_browser.raid_info(message)
	message = string.lower(message)
	message = remove_http_links(message);
	
	-- Stop if it's a guild recruit message
	if is_guild_recruitment(message) then
		return;
	end
	
	message = remove_achievement_text(message);
		
	-- Search for LFM announcement in the message
	local found_lfm = false;
	for _, pattern in ipairs(lfm_patterns) do
		if string.find(message, pattern) then
			found_lfm = true
		end
	end

	if not found_lfm then
		return;
	end
	
	-- Get the raid_info from the message
	local raid_info = nil;
	for _, r in ipairs(raid_list) do
		for _, pattern in ipairs(r.patterns) do
			local result = string.find(message, pattern);

			-- If a raid was found then save it and continue.
			if result then
				raid_info = r;

				-- Remove the substring from the message
				message = string.gsub(message, pattern, '')
				break
			end
		end
		
		if raid_info then 
			break;
		end
	end

	-- Get any roles that are needed
	local roles = {};
	for r, patterns in pairs(role_patterns) do
		for _, pattern in ipairs(patterns) do
			local result = string.find(message, pattern)

			-- If a raid was found then save it to our list of roles and continue.
			if result then
				table.insert(roles, r)

				-- Remove the substring from the message
				message = string.gsub(message, pattern, '')
				break;
			end
		end
	end

	-- If there is only an LFM message, then it is assumed that all roles are needed
	if #roles == 0 then
		roles = {'dps', 'tank', 'healer'}
	end

	local gs = ' ';

	-- Search for a gearscore requirement.
	for _, pattern in pairs(gearscore_patterns) do
		local gs_start, gs_end = string.find(message, pattern)

		-- If a gs requirement was found, then save it and continue.
		if gs_start and gs_end then
			gs = format_gs_string(string.sub(message, gs_start, gs_end))
			break
		end
	end

	return raid_info, roles, gs
end

local function table_contains = tContains;

local function event_handler(self, event, message, sender)
	if event == "CHAT_MSG_CHANNEL" then
		local raid_info, roles, gs = raid_browser.raid_info(message)
		if raid_info and roles and gs then
			
			-- Put the sender in the table of active raids
			raid_browser.lfm_messages[sender] = { 
				raid_info = raid_info, 
				roles = roles, 
				gs = gs, 
				time = time(), 
				message = message
			};
			
			raid_browser.gui.update_list();
		end
	end
end

function raid_browser:OnEnable()
	raid_browser:Print("loaded. Type /rb to toggle the raid browser.")

	-- LFM messages expire after 60 seconds
	raid_browser.expiry_time = 60;

	raid_browser.lfm_messages = {}
	raid_browser.timer = raid_browser.set_timer(10, refresh_lfm_messages, true)
	raid_browser.listener = raid_browser.add_event_listener("CHAT_MSG_CHANNEL",	event_handler )
end

function raid_browser:OnDisable()
	raid_browser.remove_event_listener ("CHAT_MSG_CHANNEL", raid_browser.listener)
	raid_browser.kill_timer(raid_browser.timer)
end