-- Register addon
raid_browser = LibStub('AceAddon-3.0'):NewAddon('RaidBrowser', 'AceConsole-3.0')

-- Whitespace separator
local sep = '[%s-_,.]';

-- Kleene closure of sep.
local csep = sep..'*';

-- Positive closure of sep.
local psep = sep..'+';

-- Raid patterns template for a raid with 2 difficulties and 2 sizes
local raid_patterns_template = {
	hc = {
		'<raid>' .. csep .. '<size>' .. csep .. 'm?a?n?' .. csep .. '%(?hc?%)?',
		psep..'%(?hc?%)?' .. csep .. '<raid>' .. csep .. '<size>',
		'<raid>' .. csep .. '%(?hc?%)?' .. csep .. '<size>',
		
		'<fullraid>' .. csep .. '<size>' .. sep .. 'm?a?n?' .. csep .. '%(?hc?%)?',
		psep..'%(?hc?%)?' .. csep .. '<fullraid>' .. csep .. '<size>',
		'<fullraid>' .. csep .. '%(?hc?%)?' .. csep .. '<size>',
	},
	
	nm = {
		'<raid>' .. csep .. '<size>' .. csep .. 'm?a?n?' .. csep .. '%(?nm?%)?',
		psep..'%(?nm?%)?' .. csep .. '<raid>' .. csep .. '<size>',
		'<raid>' .. csep .. '%(?nm?%)?' .. csep .. '<size>',
		'<raid>' .. csep .. '<size>',
		
		'<fullraid>' .. csep .. '<size>' .. csep .. 'm?a?n?' .. csep .. '%(?nm?%)?',
		psep..'%(?nm?%)?' .. csep .. '<fullraid>' .. csep .. '<size>',
		'<fullraid>' .. csep .. '%(?nm?%)?' .. csep .. '<size>',
		'<fullraid>' .. csep .. '<size>',
	}
};

local function create_pattern_from_template(raid_name_pattern, size, difficulty, full_raid_name)
	if not raid_name_pattern or not size or not difficulty or not full_raid_name then
		return;
	end
	
	full_raid_name = string.lower(full_raid_name);
	
	if size == 10 then
		size = '1[0o]';
	elseif size == 40 then
		size = '4[0p]';
	end
	
	-- Replace placeholders with the specified raid info
	return std.algorithm.transform(raid_patterns_template[difficulty], function(pattern)
		pattern = string.gsub(pattern, '<fullraid>', full_raid_name);
        pattern = string.gsub(pattern, '<raid>', raid_name_pattern);
        pattern = string.gsub(pattern, '<size>', size);
        return pattern;
	end);
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
			'icc'..csep..'25'..csep..'m?a?n?'..csep..'repu?t?a?t?i?o?n?'..csep..'',
			'icc'..csep..'repu?t?a?t?i?o?n?'..csep..'25'..csep..'m?a?n?',
		}
	},
	
	{
		name = 'icc10rep',
		instance_name = 'Icecrown Citadel',
		size = 10,
		patterns = {
			'icc'..csep..'10'..csep..'m?a?n?'..csep..'repu?t?a?t?i?o?n?'..csep..'',
			'icc'..csep..'repu?t?a?t?i?o?n?'..csep..'10',
			'icc'..csep..'repu?t?a?t?i?o?n?',
		}
	},
	
	{
		name = 'icc10hc',
		instance_name = 'Icecrown Citadel',
		size = 10,
		patterns = create_pattern_from_template('icc', 10, 'hc', 'Icecrown Citadel'),
	},

	{
		name = 'icc25hc',
		instance_name = 'Icecrown Citadel',
		size = 25,
		patterns = create_pattern_from_template('icc', 25, 'hc', 'Icecrown Citadel'),
	},

	{
		name = 'icc10nm',
		instance_name = 'Icecrown Citadel',
		size = 10,
		patterns = create_pattern_from_template('icc', 10, 'nm', 'Icecrown Citadel'),
	},

	{
		name = 'icc25nm',
		instance_name = 'Icecrown Citadel',
		size = 25,
		patterns = create_pattern_from_template('icc', 25, 'nm', 'Icecrown Citadel'),
	},

	{
		name = 'toc10hc',
		instance_name = 'Trial of the Crusader',
		size = 10,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('toc', 10, 'hc', 'Trial of the Crusader'),
			{ 'togc'..csep..'10' } -- Trial of the grand crusader (togc) refers to heroic toc
		),
	},

	{
		name = 'toc25hc',
		instance_name = 'Trial of the Crusader',
		size = 25,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('toc', 25, 'hc', 'Trial of the Crusader'),
			{ 'togc'..csep..'25' } -- Trial of the grand crusader (togc) refers to heroic toc
		),
	},

	{
		name = 'toc10nm',
		instance_name = 'Trial of the Crusader',
		size = 10,
		patterns = create_pattern_from_template('toc', 10, 'nm', 'Trial of the Crusader'),
	},

	{
		name = 'toc25nm',
		instance_name = 'Trial of the Crusader',
		size = 25,
		patterns = create_pattern_from_template('toc', 25, 'nm', 'Trial of the Crusader'),
	},
	
	{
		name = 'rs10hc',
		instance_name = 'The Ruby Sanctum',
		size = 10,
		patterns = create_pattern_from_template('rs', 10, 'hc', 'ruby sanctum'),
	},

	{
		name = 'rs25hc',
		instance_name = 'The Ruby Sanctum',
		size = 25,
		patterns = create_pattern_from_template('rs', 25, 'hc', 'ruby sanctum'),
	},

	{
		name = 'rs10nm',
		instance_name = 'The Ruby Sanctum',
		size = 10,
		patterns = create_pattern_from_template('rs', 10, 'nm', 'ruby sanctum'),
	},

	{
		name = 'rs25nm',
		instance_name = 'The Ruby Sanctum',
		size = 25,
		patterns = create_pattern_from_template('rs', 25, 'nm', 'ruby sanctum'),
	},
	
	{
		name = 'voa10',
		instance_name = 'Vault of Archavon',
		size = 10,
		patterns = {'voa'..csep..'10'},
	},
	
	{
		name = 'voa25',
		instance_name = 'Vault of Archavon',
		size = 25,
		patterns = {'voa'..csep..'25'},
	},
		
	{
		name = 'ulduar10',
		instance_name = 'Ulduar',
		size = 10,
		patterns = {
			'uldu?a?r?'..csep..'10',
		},
	},
	
	{
		name = 'ulduar25',
		instance_name = 'Ulduar',
		size = 25,
		patterns = {
			'uldu?a?r?'..csep..'25',
		}
	},
	
	{
		name = 'os10',
		instance_name = 'The Obsidian Sanctum',
		size = 10,
		patterns = {
			'os'..csep..'10',
			'sartharion must die!',
		},
	},
	
	{
		name = 'os25',
		instance_name = 'The Obsidian Sanctum',
		size = 25,
		patterns = {
			'os'..csep..'25',
		},
	},
	
	{
		name = 'naxx10',
		instance_name = 'Naxxramas',
		size = 10,
		patterns = {
			'naxx?r?a?m?m?a?s?'..csep..'10',
			'naxx'..sep..'weekly',
			'patchwerk'..sep..'must'..sep..'die!',
		},
	},
	
	{
		name = 'naxx25',
		instance_name = 'Naxxramas',
		size = 25,
		patterns = {
			'naxx?r?a?m?m?a?s?'..csep..'25',
		},
	},
	
	{
		name = 'onyxia25',
		instance_name = 'Onyxia\'s Lair',
		size = 25,
		patterns = {
			'onyx?i?a?'..csep..'25'
		},
	},
	
	{
		name = 'onyxia10',
		instance_name = 'Onyxia\'s Lair',
		size = 10,
		patterns = {
			'onyx?i?a?'..csep..'10'
		},
	},
	
	{
		name = 'karazhan',
		instance_name = 'Karazhan',
		size = 10,
		patterns = {
			'karaz?h?a?n?'..csep..'1?0?', -- karazhan 
		},
	},
	
	{
		name = 'molten core',
		instance_name = 'Molten Core',
		size = 40,
		patterns = {
			'molte?n'..csep..'core?',
			'[%s-_,.%^]+mc'..csep..'4?0?[%s-_,.$]+',
		},
	},
	
	{
		name = 'black temple',
		instance_name = 'The Black Temple',
		size = 25,
		patterns = {
			'black'..csep..'temple',
			'[%s-_,.]+bt'..csep..'25[%s-_,.]+',
		},
	},
	
	{
		name = 'aq40',
		instance_name = 'Ahn\'Qiraj Temple',
		size = 40,
		patterns = {
			'temple?'..csep..'of?'..csep..'ahn\'?'..csep..'qiraj',
			sep..'*aq'..csep..'40'..csep..'',
		},
	},
	
	{
		name = 'aq20',
		instance_name = 'Ruins of Ahn\'Qiraj',
		size = 20,
		patterns = {
			'ruins?'..csep..'of?'..csep..'ahn\'?'..csep..'qiraj',
			sep..'*aq'..csep..'20'..csep..'',
		},
	},
}

local role_patterns = {	
	dps = {
		'[0-9]*'..csep..'dps',
		
		-- melee dps
		'[0-9]*'..csep..'m[dp][dp]s',
		'[0-9]*'..csep..'rogue',
		'[0-9]*'..csep..'kitt?y?',
		'[0-9]*'..csep..'cat'..sep,
		'[0-9]*'..csep..'feral'..csep..'cat'..sep,
		'[0-9]*'..csep..'ret'..csep..'pal[al]?[dy]?i?n?',
		
		-- ranged dps
		'[0-9]*'..csep..'r[dp][dp]s',
		'[0-9]*'..csep..'w?a?r?lock',
		'[0-9]*'..csep..'spri?e?st',
		'[0-9]*'..csep..'elem?e?n?t?a?l?',
		'[0-9]*'..csep..'mage',
		'[0-9]*'..csep..'boo?mm?y?k?i?n?',
		'[0-9]*'..csep..'hunte?r?s?',
	},
	
	healer = {
		'[0-9]*'..csep..'he[a]?l[er|ers]*', -- LF healer
		'[0-9]*'..csep..'re?s?t?o?'..csep..'d[ru][ud][iu]d?', -- LF rdruid/rdudu
		'[0-9]*'..csep..'tree', 			   -- LF tree
		'[0-9]*'..csep..'re?s?t?o?'..csep..'shamm?y?', -- LF rsham
		'[0-9]*'..csep..'di?s?c?o?'..csep..'pri?e?st', -- disc priest
		'[0-9]*'..csep..'ho?l?l?y?'..csep..'pala',	   -- LF hpala
	},
	
	tank = {
		'[0-9]*'..csep..'t[a]?nk[s]?',	 -- NEED TANKS
		'[0-9]*'..csep..'tn?[a]?k[s]?',  -- Need TNAK
		'[%s-_,.]+[mo]t[%s-_,.]+',		 -- Need MT/OT
		'[0-9]*'..csep..'bears?',
		'[0-9]*'..csep..'prot'..csep..'pal[al]?[dy]?i?n?',
	},
}

local gearscore_patterns = {
	'[1-6]'..csep..'k[0-9]+',
	'[1-6][.,][0-9]',
	'[1-6]'..csep..'k'..csep..'%+',
	'[1-6]'..csep..'k'..sep,
	'%+?'..csep..'[1-6]'..csep..'k'..sep,
	'[1-6][0-9][0-9][0-9]',
	'[1-6]%+',
}

local lfm_patterns = {
	'lf[0-9]*m',
	'lf'..csep..'all',
	'need',
	'need'..csep..'all',
	'seek'..csep..'[0-9]*'..csep..'he[a]?l[er|ers]*',		-- seek healer
	'seek'..csep..'[0-9]*'..csep..'t[a]?nk[s]?',			-- seek 5 tanks
	'seek'..csep..'[0-9]*'..csep..'[mr]?dps',				-- seek 9 DPS
	'looking'..csep..'for'..csep..'all',
	'looking'..csep..'for'..csep..'an?'..sep,
	'looking'..csep..'for'..csep..'[0-9]*'..csep..'more',		-- looking for 9 more
	'lf'..csep..'.*for',								-- LF <any characters> for 
	'looking'..csep..'for'..csep..'.*'..sep..'for',		-- LF <any characters> for 
	'lf'..csep..'[0-9]*'..csep..'he[a]?l[er|ers]*',		-- LF healer
	'lf'..csep..'[0-9]*'..csep..'t[a]?nk[s]?',			-- LF 5 tanks
	'lf'..csep..'[0-9]*'..csep..'[mr]?dps',				-- LF 9 DPS
	'whispe?r?'..csep..'me',
	--''..sep..'/w'..csep..'[%a]+', -- Too greedy
}

lfm_channel_listeners = {
	['CHAT_MSG_CHANNEL'] = {},
	['CHAT_MSG_YELL'] = {},
};

local channel_listeners = {};

local guild_recruitment_patterns = {
	'recrui?ti?n?g?',
	'we'..csep..'raid',
	'[<({-][%a%s]+[-})>]'..csep..'is'..csep..'a?', -- (<GuildName> is a) pve guild looking for
	'is'..csep..'[%a%s]*playe?rs?',
	'[0-9][0-9][pa]m'..csep..'st', -- we raid (12pm set)
	'autorecruit',
	'raid'..csep..'time',
	'active'..csep..'raiders?',
	'is'..csep..'a'..csep..'[%a]*'..csep..'[pvep][pvep][pvep]'..csep..'guild',
	'lf'..sep..'members',
};

local wts_message_patterns = {
	'wts'..sep,
	'selling'..sep,
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
	local formatted = string.gsub(gs, sep..'*%+?', ''); -- Trim whitespace
	formatted  = string.gsub(formatted , 'k', '')
	formatted  = string.gsub(formatted , sep, '.');
	formatted  = tonumber(formatted);

	-- Convert ex: 5800 into 5.8 for display
	if formatted  > 1000 then
		formatted  = formatted /1000;
		
	-- Convert 57.0 into 5.7
	elseif formatted > 100 then
		formatted = formatted / 100;
		
	-- Convert 57.0 into 5.7
	elseif formatted > 10 then
		formatted = formatted / 10;
	end

	return string.format('%.1f', formatted );
end

local function is_guild_recruitment(message)
	return std.algorithm.find_if(guild_recruitment_patterns, function(pattern)
		return string.find(message, pattern);
	end);
end

local function is_wts_message(message)
	return std.algorithm.find_if(wts_message_patterns, function(pattern)
		return string.find(message, pattern);
	end);
end

-- Basic http pattern matching for streaming sites and etc.
local function remove_http_links(message)
	local http_pattern = 'https?://*[%a]*.[%a]*.[%a]*/?[%a%-%%0-9_]*/?';
	return string.gsub(message, http_pattern, '');
end
	
local function find_roles(roles, message, pattern_table, role)
	local found = false;
	for _, pattern in ipairs(pattern_table[role]) do
		local result = string.find(message, pattern)

		-- If a raid was found then save it to our list of roles and continue.
		if result then
			found = true;
			
			-- Remove the substring from the message
			message = string.gsub(message, pattern, '')
		end
	end
	
	if not found then
		return roles, message;
	end
	
	table.insert(roles, role);
	return roles, message;
end

function raid_browser.raid_info(message)
	message = string.lower(message)
	message = remove_http_links(message);
	
	-- Stop if it's a guild recruit message
	if is_guild_recruitment(message) or is_wts_message(message) then
		return;
	end
		
	-- Search for LFM announcement in the message
	local lfm_found = std.algorithm.find_if(lfm_patterns, function(pattern) return string.find(message, pattern) end) 
	
	if not lfm_found then
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
	
	message = remove_achievement_text(message);
	
	-- Get any roles that are needed
	local roles = {};
	
	--if string.find(message, '
	if not string.find(message, 'lfm? all ') and not string.find(message, 'need all ') then 
		roles, message  = find_roles(roles, message, role_patterns, 'dps');
		roles, message  = find_roles(roles, message, role_patterns, 'tank');
		roles, message = find_roles(roles, message, role_patterns, 'healer');
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

local function is_lfm_channel(channel)
	return channel == 'CHAT_MSG_CHANNEL' or channel == 'CHAT_MSG_YELL';
end

local function event_handler(self, event, message, sender)
	if is_lfm_channel(event) then
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
	raid_browser:Print('loaded. Type /rb to toggle the raid browser.')
	
	if not raid_browser_character_current_raidset then
		raid_browser_character_current_raidset = 'Active';
	end
	
	if not raid_browser_character_raidsets then
		raid_browser_character_raidsets = {
			primary = {},
			secondary = {},
		};
	end

	-- LFM messages expire after 60 seconds
	raid_browser.expiry_time = 60;

	raid_browser.lfm_messages = {}
	raid_browser.timer = raid_browser.set_timer(10, refresh_lfm_messages, true)
	for channel, listener in pairs(lfm_channel_listeners) do
		channel_listeners[i] = raid_browser.add_event_listener(channel, event_handler)
	end
	
	raid_browser.gui.raidset.initialize();
end

function raid_browser:OnDisable()
	for channel, listener in pairs(lfm_channel_listeners) do
		raid_browser.remove_event_listener(channel, listener)
	end
	
	raid_browser.kill_timer(raid_browser.timer)
end