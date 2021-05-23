-- Register addon
raid_browser = LibStub('AceAddon-3.0'):NewAddon('RaidBrowser', 'AceConsole-3.0')

--[[ Parsing and pattern matching ]]--
-- Separator characters
local sep_chars = '%s-_,.<>%*)(/#+&x'

-- Whitespace separator
local sep = '[' .. sep_chars .. ']';

local role_sep = '[' .. sep_chars .. 'x\\/' .. ']';

-- Kleene closure of sep.
local csep = sep..'*';

-- Positive closure of sep.
local psep = sep..'+';

-- Separator characters + any text
local wtext = '[%w' .. sep_chars .. ']*'

local meta_char = '¿';

local meta_or_sep = '[^' .. meta_char .. ']?' .. '[' .. sep .. ']?';

local non_meta = '[^' .. meta_char .. ']*';

local function make_meta(text)
	return meta_char .. text .. meta_char;
end

-- Not needed?
local function meta_raid_n(n)
	return make_meta('raid' .. n);
end

local meta_role = make_meta('role');
local meta_roles = make_meta('roles');
local meta_raid = make_meta('raid');
local meta_gs = make_meta('gs');
local meta_guild = make_meta('guild');

-- Raid patterns template for a raid with 2 difficulties and 2 sizes
local raid_patterns_template = {
	hc = {
		'<raid>' .. csep .. '<size>' .. csep .. 'm?a?n?' .. csep .. 'f?u?l?l?' .. csep .. 'hc?',
		sep..'hc?' .. csep .. '<raid>' .. csep .. '<size>',
		'<raid>' .. csep .. 'hc?' .. csep .. '<size>',
		sep .. '<size>' .. csep .. 'ma?n?' .. csep .. '<raid>' .. sep,
		
		'^<size>' .. csep .. '<raid>' .. sep,
	},
	
	nm = {
		'<raid>' .. csep .. '<size>' .. csep .. 'm?a?n?' .. csep .. 'f?u?l?l?' .. csep .. 'n?m?' .. csep,
		sep..'nm?' .. csep .. '<raid>' .. csep .. '<size>',
		'<raid>' .. csep .. 'n?m?' .. csep .. '<size>',
		sep .. '<size>' .. csep .. 'ma?n?' .. csep .. '<raid>' .. sep,
		
		'^<size>' .. csep .. '<raid>' .. sep,
	},
	
	simple = {
		'<raid>' .. csep .. '<size>' .. csep .. 'm[an][an]' .. csep .. 'f?u?l?l?',
		'<raid>' .. csep .. '<size>' .. csep .. 'f?u?l?l?',
		'^<size>' .. csep .. 'm?a?n?' .. csep .. 'f?u?l?l?' .. csep .. '<raid>' .. sep,
		sep .. '<size>' .. csep .. 'm?a?n?' .. csep .. '<raid>' .. sep,
	},
};

local function create_pattern_from_template(raid_name_pattern, size, difficulty)
    if not difficulty then
        difficulty = 'nm'
    end
  
	if size == 10 then
		size = '1[0o]';
	elseif size == 40 then
		size = '4[0p]';
	end
	
	if not difficulty then
		difficulty = 'nm'
	end
	
	-- Replace placeholders with the specified raid info
	return std.algorithm.transform(raid_patterns_template[difficulty], function(pattern)
        pattern = pattern:gsub('<raid>', raid_name_pattern);
        pattern = pattern:gsub('<size>', size);
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
			'icc' .. csep .. '25' .. csep .. 'nm?' .. csep .. 'farm',
			'rep' .. csep .. 'farm' .. csep .. 'icc' .. csep .. 25,
		}
	},
	
	{
		name = 'icc10rep',
		instance_name = 'Icecrown Citadel',
		size = 10,
		patterns = {
			'icc' .. csep .. '10' .. csep .. 'm?a?n?' .. csep .. 'repu?t?a?t?i?o?n?' .. csep,
			'icc' .. csep .. 'repu?t?a?t?i?o?n?' .. csep .. '10',
			'icc' .. csep .. '10' .. csep .. 'nm?' .. csep .. 'farm',
			'icc' .. csep .. 'nm?' .. csep .. 'farm',
			'icc' .. csep .. 'repu?t?a?t?i?o?n?',
			'rep' .. csep .. 'farm' .. csep .. 'icc' .. csep .. 10,
			-- Todo: rep farm icc 10, etc combinations
		}
	},
	
	{
		name = 'icc10hc',
		instance_name = 'Icecrown Citadel',
		size = 10,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('icc', 10, 'hc'),
			{ 'bane of the fallen king' }
		)
	},

	{
		name = 'icc25hc',
		instance_name = 'Icecrown Citadel',
		size = 25,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('icc', 25, 'hc'),
			{ 'the light of dawn' }
		)
	},

	{
		name = 'icc10nm',
		instance_name = 'Icecrown Citadel',
		size = 10,
		patterns = create_pattern_from_template('icc', 10, 'nm'),
	},

	{
		name = 'icc25nm',
		instance_name = 'Icecrown Citadel',
		size = 25,
		patterns = create_pattern_from_template('icc', 25, 'nm'),
	},

	{
		name = 'toc10hc',
		instance_name = 'Trial of the Crusader',
		size = 10,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('toc', 10, 'hc'),
			{ 
				'togc'..csep..'10',
				--'%[call of the grand crusade %(10 player%)%]'
			} -- Trial of the grand crusader (togc) refers to heroic toc
		),
	},

	{
		name = 'toc25hc',
		instance_name = 'Trial of the Crusader',
		size = 25,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('toc', 25, 'hc'),
			{ 
				'togc'..csep..'25',
				--'%[call of the grand crusade %(25 player%)%]'
			} -- Trial of the grand crusader (togc) refers to heroic toc
		),
	},

	{
		name = 'toc10nm',
		instance_name = 'Trial of the Crusader',
		size = 10,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('toc', 10, 'nm'),
			{ '%[call of the crusade %(10 player%)%]' }
		),
	},

	{
		name = 'toc25nm',
		instance_name = 'Trial of the Crusader',
		size = 25,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('toc', 25, 'nm'),
			{ '%[call of the crusade %(25 player%)%]' }
		),
	},
	
	{
		name = 'rs10hc',
		instance_name = 'The Ruby Sanctum',
		size = 10,
		patterns = create_pattern_from_template('rs', 10, 'hc')
	},

	{
		name = 'rs25hc',
		instance_name = 'The Ruby Sanctum',
		size = 25,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('rs', 25, 'hc'),
			{
				'ruby' .. csep .. 'sanctum' .. csep .. 25
			}
		),
	},

	{
		name = 'rs10nm',
		instance_name = 'The Ruby Sanctum',
		size = 10,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('rs', 10, 'nm'),
			{
				'ruby' .. csep .. 'sanctum' .. csep .. 10
			}
		),
	},

	{
		name = 'rs25nm',
		instance_name = 'The Ruby Sanctum',
		size = 25,
		patterns = std.algorithm.copy_back(
			{ ' rs 25n ' },
			create_pattern_from_template('rs', 25, 'nm')
		)
	},
	
	{
		name = 'voa10',
		instance_name = 'Vault of Archavon',
		size = 10,
		patterns = create_pattern_from_template('voa', 10, 'simple')
	},
	
	{
		name = 'voa25',
		instance_name = 'Vault of Archavon',
		size = 25,
		patterns = create_pattern_from_template('voa', 25, 'simple'),
	},
		
	{
		name = 'ulduar10',
		instance_name = 'Ulduar',
		size = 10,
		patterns = {
			'ull?a?d[au]?[au]?r?'..csep..'10',
		},
	},
	
	{
		name = 'ulduar25',
		instance_name = 'Ulduar',
		size = 25,
		patterns = {
			'ull?a?d[au]?[au]?r?'..csep..'25',
		}
	},
	
	{
		name = 'os10',
		instance_name = 'The Obsidian Sanctum',
		size = 10,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('os', 10, 'simple'),
			{ 'sartharion must die!' }
		),
	},
	
	{
		name = 'os25',
		instance_name = 'The Obsidian Sanctum',
		size = 25,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('os', 25, 'simple'),
			{ 
				'%[sartharion must die!%]' .. csep .. '25',
				csep .. '25' .. '%[sartharion must die%!%]',
			}
		)
	},
	
	{
		name = 'naxx10',
		instance_name = 'Naxxramas',
		size = 10,
		patterns = {
			'the fall of naxxramas %(10 player%)',
			'noth'..csep..'the'..csep..'plaguebringer'..csep..'must'..csep..'die!',
			'instructor'..csep..'razuvious'..csep..'must'..csep..'die!',
			'naxx?ramm?as'..csep..'10',
			'anub\'rekhan'..csep..'must'..csep..'die!',
			'patchwerk must die!',
			'naxx?'..csep..'10',
			'naxx'..sep..'weekly',
			'patchwerk'..csep..'must'..csep..'die!',
		},
	},
	
	{
		name = 'naxx25',
		instance_name = 'Naxxramas',
		size = 25,
		patterns = {
			'the fall of naxxramas %(25 player%)',
			'naxx?ramm?as'..csep..'25',
			'naxx?'..csep..'25',
		},
	},
	
	{
		name = 'eoe10',
		instance_name = 'The Eye of Eternity',
		size = 10,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('eoe', 10, 'simple'),
			{ 
				' eoe'..csep..'1?0?',
				'malygo?s'..csep..'1?0?',
			} 
		),
	},
	
	{
		name = 'eoe25',
		instance_name = 'The Eye of Eternity',
		size = 25,
		patterns = std.algorithm.copy_back(
			create_pattern_from_template('eoe', 25, 'simple'),
			{ 
				'malygo?s'..csep..'25',
			} 
		),
	},
	
	{
		name = 'onyxia25',
		instance_name = 'Onyxia\'s Lair',
		size = 25,
		patterns = {
			"onyxia's lair (25 player)",
			'onyx?i?a?'..csep..'25',
		},
	},
	
	{
		name = 'onyxia10',
		instance_name = 'Onyxia\'s Lair',
		size = 10,
		patterns = {
			"onyxia's lair (10 player)",
			'onyx?i?a?'..csep..'10',
		},
	},
	
	{
		name = 'hyjal25',
		instace_name = 'The Battle For Mount Hyjal',
		size = 25,
		patterns = {
			'mount' .. csep .. 'hyjal',
			'the' .. csep .. 'battle' .. csep .. 'for' .. csep .. 'mount' .. csep .. 'hyjal',
		},
	},
	
	{
		name = 'zul\'aman10',
		instance_name = 'Zul\'Aman',
		size = 10,
		patterns = {
			'zul' .. csep .. '\'?' .. csep .. 'aman',
		},
	},
	
	{
		name = 'tempest keep25',
		instance_name = 'Tempest Keep',
		size = 25,
		patterns = {
			'te*mpe*st' .. csep .. 'ke+p',
			sep .. 'tk',
			'tk' .. sep,
		},
	},
	
	{
		name = 'karazhan10',
		instance_name = 'Karazhan',
		size = 10,
		patterns = {
			'karaz?h?a?n?'..csep..'1?0?', -- karazhan 
		},
	},
	
	{
		name = 'mag\'s lair25',
		instance_name = 'Magtheridon\'s Lair',
		size = 25,
		patterns = {
			'magt?h?e?r?i?d?o?n?\'*s*' .. csep .. 'lai?r',
		},
	},
	
	{
		name = 'gruul\'s lair25',
		instance_name = 'Gruul\'s Lair',
		size = 25,
		patterns = {
			'gruul\'*s*' .. csep .. 'l?a?i?r?',
		},
	},
	
	{
		name = 'bwl40',
		instance_name = 'Blackwing Lair',
		size = 40,
		patterns = {
			'gruul\'*s*' .. csep .. 'l?a?i?r?',
		},
	},
	
	{
		name = 'molten core40',
		instance_name = 'Molten Core',
		size = 40,
		patterns = {
			'molte?n'..csep..'core?',
			sep .. 'mc'..csep..'4?0?' .. sep,
		},
	},
	
	{
		name = 'black temple25',
		instance_name = 'Black Temple',
		size = 25,
		patterns = {
			'black'..csep..'temple',
			'[%s-_,.]+bt'..csep..'25[%s-_,.]+',
		},
	},
	
	{
		name = 'sunwell25',
		instance_name = 'The Sunwell',
		size = 25,
		patterns = {
			'sunwell'..csep..'plateau',
			'swp' .. sep,
			sep .. 'swp',
		},
	},
	
	{
		name = 'ssc25',
		instance_name = 'Coilfang: Serpentshrine Cavern',
		size = 25,
		patterns = {
			'^ssc',
			sep .. 'ssc',
			'ssc' .. sep,
			'ssc' .. csep .. '$',
			'serpent' .. csep .. 'shrine' .. csep .. 'cavern',
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
		instance_name = "Ruins of Ahn'Qiraj",
		size = 20,
		patterns = {
			'ruins?'..csep..'of?'..csep..'ahn\'?'..csep..'qiraj',
			'aq'..csep..'20',
		},
	},
}

local role_patterns = {	
	dps = {
		
		'feral' .. csep .. 'cat' .. sep,
		'feral' .. csep .. 'd?p?s?',
		
		'ret' .. csep .. 'pal[al]?[dy]?i?n?',
		
		'shadow' .. csep .. 'pri?e?st',
		'pri?e?st' .. csep .. 'dps',
		
		'balance' .. '[ru][ud][iu]d?',
		
		'elem?e?n?t?a?l?' .. csep .. 'shamm?[iy]?',
		'mage',
		
		'boo?my?i?',
		'boo?mki?n',
		
		'b[ru][ud][iu]d?',
		
		'rogue' .. meta_or_sep,
		'rouge' .. meta_or_sep,
		
		'kitt?y',
		
		'w?a?r?lock',
		
		'spri?e?st',
		
		'hunte?r?s?',
		
		'm[dp][dp]s' .. meta_or_sep,
		'r[dp][dp]s',
		'dps',
	},
	
	healer = {
		'h[ea][ea]l[ers]*', -- LF healer
		'heler',
		
		'resto' .. csep .. 'd[ru][ud][iu]d?', -- LF rdruid/rdudu
		'rd[ru][ud][iu]d?', -- LF rdruid/rdudu
		meta_or_sep .. 'r' .. csep .. 'd[ru][ud][iu]d?', -- LF rdruid/rdudu
		
		'tree', 			   -- LF tree
		
		'resto' .. csep .. 'shamm?y?', -- LF rsham
		'rshamm?y?', -- LF rsham
		meta_or_sep .. 'r' .. csep .. 'shamm?y?', -- LF rsham
		
		'disco?' .. csep .. 'pri?e?st', -- disc priest
		'dpri?e?st', -- disc priest
		meta_or_sep .. 'd' .. csep .. 'pri?e?st', -- disc priest
		
		'holl?y' .. csep .. 'palad?i?n?',	   -- LF holy pala
		'hpala?d?i?n?',	   -- LF hpala
		meta_or_sep .. 'h' .. csep .. 'palad?i?n?',	   -- LF hpala
	},
	
	tank = {
		role_sep .. '[mo]t' .. role_sep,		   -- Need MT/OT
		role_sep .. '[mo]t' .. csep .. '$', -- Need MT/OT
		'ta*n+a?k+s?',	 -- NEED TANKS
		'b[ea]*rs?',
		'prot' .. csep .. 'pal[al]?[dy]?i?n?',
	},
}

local gearscore_patterns = {
	'[1-6].?[0-9]?kgs',
	'[1-6]'..csep..'k[0-9]+',
	'[1-6][.,][0-9]',
	'[1-6]'..csep..'k'..csep..'%+',
	'[1-6]'..csep..'k'..sep,
	'%+?'..csep..'[1-6]'..csep..'k'..sep,
	'[1-6][0-9][0-9][0-9]',
	'[1-6]%+',
}

local guild_recruitment_patterns = {
	'recrui?ti?n?g?',
	'we'..csep..'raid',
	'we'..csep..'are'..csep..'raidi?n?g?',
	'[<({-][%a%s]+[-})>]'..csep..'is'..csep..'a?', -- (<GuildName> is a) pve guild looking for
	'is'..csep..'[%a%s]*playe?rs?',
	'[0-9][0-9][pa]m'..csep..'st', -- we raid (12pm set)
	'autorecruit',
	'raid'..csep..'time',
	'active'..csep..'raiders?',
	'is'..csep..'a'..csep..'[%a]*'..csep..'[pvep][pvep][pvep]'..csep..'guild',
	'lf'..sep..'members',
};

local trade_message_patterns = {
	'wts' .. sep,
	'wtb' .. sep,
	'selling' .. sep,
	'buying' .. sep,
};

local rolelist_patterns = {
	meta_role .. non_meta .. 'and' .. non_meta .. meta_role,
	meta_role .. non_meta .. 'or' .. non_meta .. meta_role,
	meta_role .. non_meta .. meta_role,
};

local lfm_patterns = {
	'l[fm][fm]?' .. non_meta .. meta_role .. non_meta .. meta_raid,
	
	meta_raid .. non_meta .. sep .. '[0-9]+' .. non_meta .. meta_role,
   
   'lfm?' .. csep .. '[0-9]*' .. csep .. meta_role .. non_meta .. meta_gs .. '.*' .. meta_raid,
   'lfm?' .. csep .. 'all' .. non_meta .. meta_raid,
   'need' .. csep .. 'all' .. non_meta .. meta_raid,
   'seek' .. csep .. 'all' .. non_meta .. meta_raid,
   
	meta_raid .. non_meta .. 'lfm?' .. csep .. 'all',
	meta_raid .. non_meta .. 'need' .. csep .. 'all',
	meta_raid .. non_meta .. meta_gs .. non_meta .. 'lf' .. csep .. 'all',
	meta_raid .. non_meta .. meta_gs .. non_meta .. 'seek' .. csep .. 'all',
	meta_raid .. non_meta .. meta_gs .. non_meta .. 'need' .. csep .. 'all',
		
	meta_raid .. non_meta .. meta_role .. non_meta .. meta_gs,
	meta_raid .. non_meta .. 'need' .. non_meta .. meta_role,
	meta_raid .. non_meta .. 'seek' .. non_meta .. meta_role,
	
	meta_raid .. non_meta .. 'lfm?' .. non_meta .. meta_role,
	meta_raid .. non_meta .. 'looki?ng' .. csep .. 'for' .. non_meta .. meta_role,
   
	meta_raid .. non_meta .. 'need' .. csep .. 'all',
	
	meta_raid .. non_meta .. meta_gs .. non_meta .. meta_role,
	
	meta_role .. non_meta .. 'for' .. non_meta .. meta_raid,

	meta_raid .. non_meta .. sep .. 'loot' .. sep .. non_meta .. 'wh?i?s?p?e?r?' .. csep .. 'me',
	
	meta_raid .. non_meta .. meta_gs .. non_meta .. 'wh?i?s?p?e?r?' .. csep .. 'me',
	meta_raid .. non_meta .. meta_gs .. non_meta .. 'wh?i?s?p?e?r?' .. csep .. '[A-Z][a-z]+',
	
	meta_raid .. non_meta .. non_meta .. 'wh?i?s?p?e?r?' .. csep .. 'me' .. non_meta .. meta_gs,
	meta_raid .. non_meta .. non_meta .. 'wh?i?s?p?e?r?' .. csep .. '[A-Z][a-z]+' .. non_meta .. meta_gs,
   
	meta_raid .. non_meta .. 'run' .. non_meta .. meta_gs,
   
   '[0-9]' .. non_meta ..  meta_role .. non_meta .. meta_raid,
   
	meta_raid .. non_meta .. 'reserved',
   
	'l[fm][fm]' .. non_meta .. meta_raid,
	
	meta_raid .. non_meta .. meta_role,
   'new' .. csep .. 'run' .. meta_raid,
}

local guild_recruitment_metapatterns = {
	meta_guild .. non_meta .. meta_raid,
};

local guild_patterns = {
	'^guild' .. psep .. '[a-z]+[%s][a-z]*' .. psep,
	'^guild' .. sep .. '[a-z]+[%s][a-z]*',
};

local lfg_patterns = {
	'^' .. csep .. 'lfg' .. non_meta .. meta_raid,
	'^' .. csep .. meta_gs .. non_meta .. meta_role .. non_meta .. 'looking' .. csep .. 'for' .. non_meta .. meta_raid,
	'^' .. csep .. meta_role .. non_meta .. meta_gs .. non_meta .. 'looking' .. csep .. 'for' .. non_meta .. meta_raid,
	
	'^' .. csep .. meta_gs .. non_meta .. meta_role .. non_meta .. 'lf' .. non_meta .. meta_raid,
	'^' .. csep .. meta_role .. non_meta .. meta_gs .. non_meta .. 'lf' .. non_meta .. meta_raid,
};

local function matches_any_pattern(message, patterns)
	return std.algorithm.find_if(patterns, function(pattern)
		return message:find(pattern);
	end) ~= nil;
end

local function is_lfm_message(message)
	return matches_any_pattern(message, lfm_patterns);
end

local function is_guild_recruitment(message)
	return matches_any_pattern(message, guild_recruitment_patterns);
end

local function is_lfg_message(message)
	return matches_any_pattern(message, lfg_patterns);
end

local function is_trade_message(message)
	return matches_any_pattern(message, trade_message_patterns);
end

-- Basic http pattern matching for streaming sites and etc.
local function remove_http_links(message)
	local http_pattern = 'https?://*[%a]*.[%a]*.[%a]*/?[%a%-%%0-9_]*/?';
	return message:gsub(http_pattern, '');
end

local function lex_achievements(message)
	local achievement_pattern = '\124cffffff00\124h.*\124h(%[.*%])\124h\124r';
	return message:gsub(achievement_pattern, '%1');
end

local function lex_guild_recruitments(message)
	for _, pattern in ipairs(guild_patterns) do
		message = message:gsub(pattern, meta_guild);
	end
	
	return message;
end
	
local function lex_roles(roles, message, role)		
	local found = false;
	
	for _, pattern in ipairs(role_patterns[role]) do
		local m, result = message:gsub(pattern, meta_role);
		
		if result > 0 then 
			message = m;
			found = true;
		end;
	end
	
	if found then table.insert(roles, role) end
	return roles, message;
end

local function format_gs_string(gs)
	local formatted = gs:gsub(sep .. '*%+?', ''); -- Trim whitespace
	formatted = formatted:gsub('[kgs]', '')
	formatted = formatted:gsub(sep, '.');
	gs = tonumber(formatted);

	-- Convert ex: 5800 into 5.8 for display
	if gs  > 1000 then
		gs  = gs /1000;
		
	-- Convert 57.0 into 5.7
	elseif gs > 100 then
		gs = gs / 100;
		
	-- Convert 57.0 into 5.7
	elseif gs > 10 then
		gs = gs / 10;
	end

	return string.format('%.1f', gs);
end

local function lex_gs_req(message)
	for _, pattern in pairs(gearscore_patterns) do
		local gs_text = message:match(pattern);
		if gs_text then
			-- Extract gs and replace it with the gearscore nonterminal
			return 
				format_gs_string(gs_text), 
				-- TODO: Check for valid pattern
				message:gsub(gs_text, meta_gs)
		end
	end
	
	return nil, message;
end

function raid_browser.lex_raid_info(message)
	
	local raid;
	local num_unique_raids = 0;
	for i, r in ipairs(raid_list) do
	
		local index = std.algorithm.find_if(r.patterns, function(pattern)
			local m, result = message:gsub(pattern, meta_raid);
			
			if result > 0 then 
				message = m;
				return true;
			end;
			
			return false;
		end);
		
		if index then
			num_unique_raids = num_unique_raids + 1;
			raid = r;
		end;
	end
	
	if not raid then return end;
	return raid, message, num_unique_raids;
end

local function has_guild_recruitment_production(message)
	return matches_any_pattern(message, guild_recruitment_metapatterns)
end

local function reduce_rolelists(message)

	local sub_count = 0;
	
	repeat
		local results = std.algorithm.transform(rolelist_patterns, function(pattern)
			local t = {message:gsub(pattern, meta_role)};
			message = t[1]; return t[2];
		end);
		
		sub_count = std.algorithm.find_if(results, function(x) return x > 0 end) or 0;
	until sub_count == 0;

	return message;
end

function raid_browser.lex_and_extract(message)
	if not message then return end;
	message = message:lower();
	message = remove_http_links(message);
	
	-- Stop if it's a guild recruit/wts message
	if is_guild_recruitment(message) or is_trade_message(message) then
		return;
	end
	
	-- Remove any instances of the meta character
	message = message:gsub(meta_char, '');
		
	message = lex_guild_recruitments(message);
		
	-- Get the raid_info from the message
	local raid_info, message, num_unique_raids = raid_browser.lex_raid_info(message);
	if not raid_info then return end
	
	if has_guild_recruitment_production(message) then return end
	
	-- If there are multiple distinct raids, then it is most likely a recruitment message.
	if num_unique_raids > 1 then return end;
	
	message = lex_achievements(message);
	
	-- Get any roles that are needed
	local roles = {};
	
	if not message:find('lfm? all ') and not message:find('need all ') then 
		roles, message = lex_roles(roles, message, 'dps');
		roles, message = lex_roles(roles, message, 'tank');
		roles, message = lex_roles(roles, message, 'healer');
	end
	
	-- If there is only an LFM message, then it is assumed that all roles are needed
	if #roles == 0 then
		roles = {'dps', 'tank', 'healer' }
	end

	-- Search for a gearscore requirement.
	local gs, message = lex_gs_req(message);
	message = reduce_rolelists(message);
	
	return message, raid_info, roles, gs or ' ';
end

function raid_browser.raid_info(message)
	local lexed_message, raid_info, roles, gs = raid_browser.lex_and_extract(message);
	
	if not lexed_message then return end;
	
	-- Any message that is lexed out to be an lfg is excluded (unfortunately near the end).
	if is_lfg_message(lexed_message) then return end;
	
	-- Parse symbols to determine if the message is valid
	if not is_lfm_message(lexed_message) then return  end
	
	return raid_info, roles, gs or ' ';
end

--[[ Event handlers and listeners ]]--
lfm_channel_listeners = {
	['CHAT_MSG_CHANNEL'] = {},
	['CHAT_MSG_YELL'] = {},
};

local channel_listeners = {};

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

local function refresh_lfm_messages()
	-- Requesting lock info each time a tooltip is produced creates a lot of lag.
	-- This is a better alternative
	RequestRaidInfo();
	
	for name, info in pairs(raid_browser.lfm_messages) do
		-- If the last message from the sender was too long ago, then
		-- remove his raid from lfm_messages.
		if time() - info.time > raid_browser.expiry_time then
			raid_browser.lfm_messages[name] = nil;
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
		table.insert(channel_listeners, raid_browser.add_event_listener(channel, event_handler))
	end
	
	raid_browser.gui.raidset.initialize();
end

function raid_browser:OnDisable()
	for channel, listener in pairs(lfm_channel_listeners) do
		raid_browser.remove_event_listener(channel, listener)
	end
	
	raid_browser.kill_timer(raid_browser.timer)
end