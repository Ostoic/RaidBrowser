-- Register addon
raid_browser = LibStub("AceAddon-3.0"):NewAddon("RaidBrowser", "AceConsole-3.0")

local raid_list = {
	-- Note: The order of each raid is deliberate.
	-- Heroic raids are checked first, since NM raids will have the default 'icc10' pattern. 
	-- Be careful about changing the order of the raids below
	{
		name = 'icc10rep',
		instance_name = 'Icecrown Citadel',
		size = 10,
		patterns = {
			 'icc[%s-]*10[%s-]*rep',
			 'rep[%s]*icc[%s-]*10',
			 'icc[%s-]*rep',
		}
	},

	{
		name = 'icc25rep',
		instance_name = 'Icecrown Citadel',
		size = 25,
		patterns = {
			'icc[%s-]*25[%s-]*rep[%s-]*',
			'rep[%s-]*icc[%s-]*25',
		}
	},
	
	{
		name = 'icc10hc',
		instance_name = 'Icecrown Citadel',
		size = 10,
		patterns = {
			'icc[%s-]*10[%s-]*%(?hc?%)?',
			'%(?hc?%)?[%s-]*icc[%s-]*10',
			'icc[%s-]*%(?hc?%)?[%s-]*10',
			'10[%s-]*icc[%s-]*%(?hc?%)?',
		}
	},

	{
		name = 'icc25hc',
		instance_name = 'Icecrown Citadel',
		size = 25,
		patterns = {
			'icc[%s-]*25[%s-]*%(?hc?%)?',
			'%(?hc?%)?[%s-]*icc[%s-]*25',
			'icc[%s-]*%(?hc?%)?[%s-]*25',
			'25[%s-]*icc[%s-]*%(?hc?%)?'
		}
	},

	{
		name = 'icc10nm',
		instance_name = 'Icecrown Citadel',
		size = 10,
		patterns = {
			'icc[%s-]*10[%s-]*%(?nm?%)?',
			'%(?nm?%)?[%s-]*icc[%s-]*10',
			'icc[%s-]*%(?nm?%)?[%s-]*10',
			'10[%s-]*icc[%s-]*%(?nm?%)?',
			'icc[%s-]*10',
		}
	},

	{
		name = 'icc25nm',
		instance_name = 'Icecrown Citadel',
		size = 25,
		patterns = {
			'icc[%s-]*25[%s-]*%(?nm?%)?',
			'%(?nm?%)?[%s-]*icc[%s-]*25',
			'icc[%s-]*%(?nm?%)?[%s-]*25',
			'25[%s-]*icc[%s-]*%(?nm?%)?',
			'icc[%s-]*25',
		}
	},

	{
		name = 'toc10hc',
		instance_name = 'Trial of the Crusader',
		size = 10,
		patterns = {
			'toc[%s-]*10[%s-]*%(?hc?%)?',
			'%(?hc?%)?[%s-]*toc[%s-]*10',
			'toc[%s-]*%(?hc?%)?[%s-]*10',
			'10[%s-]*toc[%s-]*%(?hc?%)?',
		}
	},

	{
		name = 'toc25hc',
		instance_name = 'Trial of the Crusader',
		size = 25,
		patterns = {
			'toc[%s-]*25[%s-]*%(?hc?%)?',
			'%(?hc?%)?[%s-]*toc[%s-]*25',
			'toc[%s-]*%(?hc?%)?[%s-]*25',
			'25[%s-]*toc[%s-]*%(?hc?%)?',
		}
	},

	{
		name = 'toc10nm',
		instance_name = 'Trial of the Crusader',
		size = 10,
		patterns = {
			'toc[%s-]*10[%s-]*%(?nm?%)?',
			'%(?nm?%)?[%s-]*toc[%s-]*10',
			'toc[%s-]*%(?nm?%)?[%s-]*10',
			'10[%s-]*toc[%s-]*%(?nm?%)?',
			'toc[%s-]*10',
		}
	},

	{
		name = 'toc25nm',
		instance_name = 'Trial of the Crusader',
		size = 25,
		patterns = {
			'toc[%s-]*25[%s-]*%(?nm?%)?',
			'%(?nm?%)?[%s-]*toc[%s-]*25',
			'toc[%s-]*%(?nm?%)?[%s-]*25',
			'25[%s-]*toc[%s-]*%(?nm?%)?',
			'toc[%s-]*25',
		}
	},
	
	{
		name = 'rs10hc',
		instance_name = 'The Ruby Sanctum',
		size = 10,
		patterns = {
			'rs[%s-]*10[%s-]*%(?hc?%)?',
			'%(?hc?%)?[%s-]*rs[%s-]*10',
			'rs[%s-]*%(?hc?%)?[%s-]*10',
			'10[%s-]*rs[%s-]*%(?hc?%)?',
		}
	},

	{
		name = 'rs25hc',
		instance_name = 'The Ruby Sanctum',
		size = 25,
		patterns = {
			'rs[%s-]*25[%s-]*%(?hc?%)?',
			'%(?hc?%)?[%s-]*rs[%s-]*25',
			'rs[%s-]*%(?hc?%)?[%s-]*25',
			'25[%s-]*rs[%s-]*%(?hc?%)?',
		}
	},

	{
		name = 'rs10nm',
		instance_name = 'The Ruby Sanctum',
		size = 10,
		patterns = {
			'rs[%s-]*10[%s-]*%(?nm?%)?',
			'%(?nm?%)?[%s-]*rs[%s-]*10',
			'rs[%s-]*%(?nm?%)?[%s-]*10',
			'10[%s-]*rs[%s-]*%(?nm?%)?',
			'rs[%s-]*10',
		}
	},

	{
		name = 'rs25nm',
		instance_name = 'The Ruby Sanctum',
		size = 25,
		patterns = {
			'rs[%s-]*25[%s-]*%(?nm?%)?',
			'%(?nm?%)?[%s-]*rs[%s-]*25',
			'rs[%s-]*%(?nm?%)?[%s-]*25',
			'25[%s-]*rs[%s-]*%(?nm?%)?',
			'rs[%s-]*25',
		}
	},
	
	{
		name = 'voa10',
		instance_name = 'Vault of Archavon',
		size = 10,
		patterns = {"voa[%s-]*10"},
	},
	
	{
		name = 'voa25',
		instance_name = 'Vault of Archavon',
		size = 25,
		patterns = {"voa[%s-]*25"},
	},
		
	{
		name = 'ulduar10',
		instance_name = 'Ulduar',
		size = 10,
		patterns = {
			'uld[%s-]*10',
			'ulduar[%s-]*10',
		},
	},
	
	{
		name = 'ulduar25',
		instance_name = 'Ulduar',
		size = 25,
		patterns = {
			'uld[%s-]*25',
			'ulduar[%s-]*25',
		}
	},
	
	{
		name = 'os10',
		instance_name = 'The Obsidian Sanctum',
		size = 10,
		patterns = {
			'os[%s-]*10',
		},
	},
	
	{
		name = 'os25',
		instance_name = 'The Obsidian Sanctum',
		size = 25,
		patterns = {
			'os[%s-]*25',
		},
	},
	
	{
		name = 'naxx10',
		instance_name = 'Naxxramas',
		size = 10,
		patterns = {
			'naxx?r?a?m?m?a?s?[%s-]*10',
		},
	},
	
	{
		name = 'naxx25',
		instance_name = 'Naxxramas',
		size = 25,
		patterns = {
			'naxx?r?a?m?m?a?s?[%s-]*25',
		},
	},
	
	{
		name = 'onyxia25',
		instance_name = 'Onyxia\'s Lair',
		size = 25,
		patterns = {
			'onyx?i?a?[%s-]*25'
		},
	},
	
	{
		name = 'onyxia10',
		instance_name = 'Onyxia\'s Lair',
		size = 10,
		patterns = {
			'onyx?i?a?[%s-]*10'
		},
	},
}

local role_patterns = {
	ranged_dps = {
		"[0-9]*[%s]*rdps",
		'[0-9]*[%s]*hunte?r?s?',
	},
	
	melee_dps = {
		'[0-9]*[%s]*mdps',
		'[0-9]*[%s]*rogue',
	},
	
	dps = {
		'[0-9]*[%s]*dps',
	},
	
	healer = {
		'[0-9]*[%s]*he[a]?l[er|ers]*',
		'[0-9]*[%s]*rdudu',
		'[0-9]*[%s]*rdruid',
		'[0-9]*[%s]*rshamm?y?',
		'[0-9]*[%s]*disc[%s]*',
		'[0-9]*[%s]*hpala',
	},
	
	tank = {
		'[0-9]*[%s]*t[a]?nk[s]?',
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
	'lf[%s]*.*for',								-- LF () for 
	'lf[%s]*[0-9]*[%s]*he[a]?l[er|ers]*',		-- LF healer
	'lf[%s]*[0-9]*[%s]*t[a]?nk[s]?',				-- LF 5 tanks
	'lf[%s]*[0-9]*[%s]*[mr]?dps',				-- LF 9 DPS
	'seek[%s]*[0-9]*[%s]*he[a]?l[er|ers]*',		-- seek healer
	'seek[%s]*[0-9]*[%s]*t[a]?nk[s]?',			-- seek 5 tanks
	'seek[%s]*[0-9]*[%s]*[mr]?dps',				-- seek 9 DPS
	'lf[%s]*all',
	'need',
	'need[%s]*all',
}

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

function raid_browser.raid_info(message)
	message = string.lower(message)
	
	-- Stop if it's a guild recruit message
	if string.find(message, 'recruit') or string.find(message, 'recruiting') then
		return;
	end
	
	message = remove_achievement_text(message);
	
	-- Search for LFM announcement in the message
	local found_lfm = false;
	for _, pattern in pairs(lfm_patterns) do
		if string.find(message, pattern) then
			found_lfm = true
		end
	end

	if not found_lfm then
		return nil
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
	raid_browser:Print("RaidBrowser stopped")
	
	raid_browser.kill_timer(raid_browser.timer)
end