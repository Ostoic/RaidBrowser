local test_cases = {
	{
		message = 'LFM need kitty and dps for icc25manhc 5.5+',
		should_fail = false,
		raid = 'icc25hc',
		roles = {'dps'},
		gs = '5.5',
	},
	
	{
		message = 'LFM need kitty and icc 25 rshammy 5.5+',
		should_fail = false,
		raid = 'icc25nm',
		roles = {'melee_dps', 'healer'},
		gs = '5.5',
	},
	
	{
		message = 'LFM icc			 25htea35c nn_-r3eraefneed__363626yrkgk,grMT_-363ylrdslh5k+',
		should_fail = false,
		raid = 'icc25hc',
		roles = {'dps', 'healer', 'tank'},
		gs = '5.0',
	},
	
	{
		message = 'LFM VOA 25 RSHAMMY OR PRIEST HEAL LAST SPOT',
		should_fail = false,
		raid = 'voa25',
		roles = {'healer'},
		gs = ' ',
	},
	
	{
		message = 'LFM ICC 1O HC continuation at PP, 6k gs req pst [Fall of the Lich King (10 player)]',
		should_fail = false,
		raid = 'icc10hc',
		roles = {'dps', 'healer', 'tank'},
		gs = '6.0',
	},
	
	{
		message = 'LFM icc 10NM/HC Min Gs Require	:	5.5K Whisper me your gs and spec',
		should_fail = false,
		raid = 'icc10nm',
		roles = {'dps', 'healer', 'tank'},
		gs = '5.5',
	},
	
	{
		message = 'OS10 NEED 1HEAL 2DPS	[Sartharion Must Die!]',
		should_fail = false,
		raid = 'os10',
		roles = {'dps', 'healer'},
		gs = ' ',
	},
	
	{
		message = '<Altruistic> is helpfu chill ENG guild LFM. We raid 10 or 25m Wed 8pm EST aka 12pm ST. We are 12/12 ICC10 Any level can join. [altruisticguild.com]',
		should_fail = true,
		raid = 'guild_message',
		roles = {},
		gs = ' ',
	},
	
	{
		message = 'LFM ICC10N NEED 2 TNAKS AND 1 HEALER AND RDPS 5.3GS MIN. WHISPER GS AND EXP. NO GS AND EXP=IGNORE',
		should_fail = false,
		raid = 'icc10nm',
		roles = {'tank', 'healer', 'ranged_dps'},
		gs = '5.3',
	},
	
	-- Need to figure out how to do this without breaking other tests
	--[[{
		message = 'LFM 10m ICC NEED 1 TNAKS AND 1 HEALER 5.3GS MIN. WHISPER GS AND EXP. NO GS AND EXP=IGNORE',
		should_fail = false,
		raid = 'icc10nm',
		roles = {'tank', 'healer'},
		gs = '5.3',
	},]]--
	
	{
		message = 'LFM for OS 25   Need ALL! 4.8k GS ++++',
		should_fail = false,
		raid = 'os25',
		roles = {'tank', 'dps', 'healer'},
		gs = '4.8',
	},
	
	{
		message = 'LFM Icc25N at BPC(putricide is dead), need 1 resto sham',
		should_fail = false,
		raid = 'icc25nm',
		roles = {'healer'},
		gs = ' ',
	},
	
	{
		message = ' ICC10 nm/hc lf 5k7+ boe reserved link achiv// spec // 6/10 need 2 Heals // 1 tank //  1 Rdps (preflock)',
		should_fail = false,
		raid = 'icc10nm',
		roles = {'healer', 'tank', 'ranged_dps'},
		gs = '5.7',
	},
	
	{
		message = ' LFM [Temple of Ahn\'Qiraj] Achievement / Transmorg Run. Dark Edge Reserved.',
		should_fail = false,
		raid = 'aq40',
		roles = {'healer', 'tank', 'dps'},
		gs = ' ',
	},
	
	{
		message = 'ICC10 nm/hc lf 5k7+ boe reserved link achiv// spec // 9/10 need 1 Dpriest',
		should_fail = false,
		raid = 'icc10nm',
		roles = {'healer'},
		gs = '5.7',
	},
	
	{
		message = 'need dps for MC old raid',
		should_fail = false,
		raid = 'molten core',
		roles = {'dps'},
		gs = ' ',
	},
	
	{
		message = 'LF tank for aq40 get your achieve',
		should_fail = false,
		raid = 'aq40',
		roles = {'tank'},
		gs = ' ',
	},
	
	{
		message = 'LFM [Temple of Ahn\'Qiraj] Achievement / Transmorg Run. Dark Edge Reserved. In progress.  Pst WIll summon. Pst. All welcome.',
		should_fail = false,
		raid = 'aq40',
		roles = {'tank', 'dps', 'healer'},
		gs = ' ',
	},
	
	{
		message = 'LFM [Ruins of Ahn\'Qiraj] Achievement / Transmorg Run. Dark Edge Reserved. In progress.  Pst WIll summon. Pst. All welcome.',
		should_fail = false,
		raid = 'aq10',
		roles = {'tank', 'dps', 'healer'},
		gs = ' ',
	},
	
	{
		message = ' NEED HEAL  TANK FOR TOC 10 5K++',
		should_fail = false,
		raid = 'toc10nm',
		roles = {'tank', 'healer'},
		gs = '5.0',
	},
	
	{
		message = ' NEED dpriest  TANK FOR TOGC 10 5K++',
		should_fail = false,
		raid = 'toc10nm',
		roles = {'tank', 'healer'},
		gs = '5.0',
	},
	
	{
		message = 'LFM TOC 5 NM FARM need heal  and go  /w me gs,spec (banner res) 3.5k + 4/5',
		should_fail = true,
		raid = 'toc5nm',
		roles = {'healer'},
		gs = '3.5',
	},
	
	{
		message = 'Icc 10 HC- Looking for an OT, 1 Healer . Whisper your class.role and [The Frozen Throne (10 player)] for an [invite]. DISCORD REQUIRED.',
		should_fail = false,
		raid = 'icc10hc',
		roles = {'tank', 'healer'},
		gs = ' ',
	},
	
	{
		message = 'Fresh RS10 NEED ALL /w Gearscore/Class/Achiv - Discord is a must  [The Twilight Destroyer (10 player)]',
		should_fail = false,
		raid = 'rs10nm',
		roles = {'tank', 'dps', 'healer'},
		gs = ' ',
	},

-- Ruby Sanctum name variation tests
	{
		message = 'LFM rs25 need all 5k1+',
		should_fail = false,
		raid = 'rs25nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM rs10 need all 5k1+',
		should_fail = false,
		raid = 'rs10nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM rs10n need all 5k1+',
		should_fail = false,
		raid = 'rs10nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM rs25n need all 5k1+',
		should_fail = false,
		raid = 'rs25nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM rs10nc need all 5k1+',
		should_fail = false,
		raid = 'rs10nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM rs25nc need all 5k1+',
		should_fail = false,
		raid = 'rs25nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM rs10h need all 5k1+',
		should_fail = false,
		raid = 'rs10hc',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM rs25h need all 5k1+',
		should_fail = false,
		raid = 'rs25hc',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM rs10hc need all 5k1+',
		should_fail = false,
		raid = 'rs10hc',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM rs25hc need all 5k1+',
		should_fail = false,
		raid = 'rs25hc',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
-- ICC name variation tests
	{
		message = 'LFM icc25 need all 5k1+',
		should_fail = false,
		raid = 'icc25nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM icc10 need all 5k1+',
		should_fail = false,
		raid = 'icc10nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM icc10n need all 5k1+',
		should_fail = false,
		raid = 'icc10nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM icc25n need all 5k1+',
		should_fail = false,
		raid = 'icc25nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM icc10nc need all 5k1+',
		should_fail = false,
		raid = 'icc10nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM icc25nc need all 5k1+',
		should_fail = false,
		raid = 'icc25nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM icc10h need all 5k1+',
		should_fail = false,
		raid = 'icc10hc',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM icc25h need all 5k1+',
		should_fail = false,
		raid = 'icc25hc',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM icc10hc need all 5k1+',
		should_fail = false,
		raid = 'icc10hc',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM icc25hc need all 5k1+',
		should_fail = false,
		raid = 'icc25hc',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
-- TOC name variation tests
	{
		message = 'LFM toc25 need all 5k1+',
		should_fail = false,
		raid = 'toc25nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM toc10 need all 5k1+',
		should_fail = false,
		raid = 'toc10nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM toc10n need all 5k1+',
		should_fail = false,
		raid = 'toc10nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM toc25n need all 5k1+',
		should_fail = false,
		raid = 'toc25nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM toc10nc need all 5k1+',
		should_fail = false,
		raid = 'toc10nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM toc25nc need all 5k1+',
		should_fail = false,
		raid = 'toc25nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM toc10h need all 5k1+',
		should_fail = false,
		raid = 'toc10hc',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM toc25h need all 5k1+',
		should_fail = false,
		raid = 'toc25hc',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM toc10hc need all 5k1+',
		should_fail = false,
		raid = 'toc10hc',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},
	
	{
		message = 'LFM toc25hc need all 5k1+',
		should_fail = false,
		raid = 'toc25hc',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.1',
	},

-- More random tests	
	{
		message = 'ICC 10 nm wis me .....need all ..........gs up 5.5 ........and link me achive ..........{no B+P ress} ..... { com VH } ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++',
		should_fail = false,
		raid = 'icc10nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '5.5',
	},	
	
	{
		message = 'Rs 25N >> Discord Req >> Need all +6k Gs  [The Twilight Destroyer (25 player)] STS Ress',
		should_fail = false,
		raid = 'rs25nm',
		roles = {'tank', 'dps', 'healer'},
		gs = '6.0',
	},
	
	{
		message = 'LFM ICC 25 nm need RPDS Fresh Run 5.6k+ FULL GEMS and ENCHANTS! (B+P res) /w best achi. Make sure you have TIME!',
		should_fail = false,
		raid = 'icc25nm',
		roles = {'ranged_dps'},
		gs = '5.6',
	},
} 



local function array_contains(table, element)
	for _, k in ipairs(table) do
		if k == element then
			return true;
		end
	end
	
	return false;
end

local function compare_arrays(table1, table2)
	for _, x in ipairs(table1) do
		if not array_contains(table2, x) then
			return false;
		end
	end
	
	return true;
end

local function display_test(test)
	local roles_string = '';
	for _, role in ipairs(test.roles) do
		roles_string = role .. ' ' .. roles_string;
	end
	
	raid_browser:Print('Test case for ' .. test.raid);
	raid_browser:Print('Original message: ' .. test.message);
	raid_browser:Print('Roles: ' .. roles_string);
	raid_browser:Print('Gearscore: ' .. test.gs);
	raid_browser:Print('Should fail: ' .. tostring(test.should_fail));
end

local function test_failed(test, detected, message)
	raid_browser:Print('Test failed: ' .. message);
	display_test(test);
	
	raid_browser:Print('Detected info: ');
	if detected then
		local roles_string = '';
		for _, role in ipairs(detected.roles) do
			roles_string = role .. ' ' .. roles_string;
		end
		
		raid_browser:Print('Raid: ' .. detected.raid);
		raid_browser:Print('Roles: ' .. roles_string);
		raid_browser:Print('Gearscore: ' .. detected.gs);
	end
	
	print('');
end

local function run_test_case(test)
	local raid_info, roles, gs = raid_browser.raid_info(test.message)
	
	local detected = nil;
	if raid_info and roles and gs then
		detected = {raid = raid_info.name, roles = roles, gs = gs};
	end
	
	if raid_info and test.should_fail then
		if test.raid == 'guild_message' then
			test_failed(test, detected, 'guild recruitment message passed');
		else
			test_failed(test, detected, 'test should have failed');
		end
		
	elseif not raid_info then
		if not test.should_fail then
			test_failed(test, detected, 'no raid detected');
		end
		
	elseif not (test.raid == raid_info.name) then
		test_failed(test, detected, 'detected raid name is incorrect');
		
	elseif not (test.gs == gs) then 
		test_failed(test, detected, 'detected gearscore is incorrect');
		
	elseif not compare_arrays(test.roles, roles) then
		test_failed(test, detected, 'detected list of roles is not correct');
	end
end

for _, test in ipairs(test_cases) do
	run_test_case(test);
end

raid_browser:Print('All unit tests completed');

