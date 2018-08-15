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
		roles = {'dps', 'healer'},
		gs = '5.5',
	},
	
	{
		message = 'LFM need feral cat and icc 25 rshammy 5.5+',
		should_fail = false,
		raid = 'icc25nm',
		roles = {'dps', 'healer'},
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
		roles = {'tank', 'healer', 'dps'},
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
		roles = {'healer', 'tank', 'dps'},
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
		raid = 'aq20',
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
		raid = 'toc10hc',
		roles = {'tank', 'healer'},
		gs = '5.0',
	},
	
	{
		message = 'LFM TOC 5 NM FARM need heal  and go  /w me gs,spec (banner res) 3.5k + 4/5',
		should_fail = true,
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
		roles = { 'tank', 'dps', 'healer' },
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
		roles = {'dps'},
		gs = '5.6',
	},
	
	{
		message = 'ICC 10  NM/HC raid  Need  1 Bommy1 SHAMMY healer  !! min GS 5.7k  --B+P are reserverd 8/10  [Fall of the Lich King (10 player)]',
		should_fail = false,
		raid = 'icc10nm',
		roles = {'dps', 'healer'},
		gs = '5.7',
	},
	
	{
		message = ' RS 10 Norm Need Resto Druid  6k+  [Heroic: The Twilight Destroyer (25 player)]',
		should_fail = false,
		raid = 'rs10nm',
		roles = {'healer'},
		gs = '6.0',
	},
	
	{
		message = 'LF 1 tank for Ruby Sanctum 10 man normal, 5,6k gs req',
		should_fail = false,
		raid = 'rs10nm',
		roles = {'tank'},
		gs = '5.6',
	},
	
	{
		message = 'ICC 25MAN LOOKING FOR 3 HEALERS AND 9 DPS 5.5K GS+ FOR FRASH ICC RUN B/E RES /W ME GS AND ACHIV AIM 7+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@',
		should_fail = false,
		raid = 'icc25nm',
		roles = {'healer', 'dps'},
		gs = '5.5',
	},
	
	{
		message = 'TOC 25 man HC need 1 prot pala and 1 heal {  pala } and 2 mdps { rogue / feral } and 3 rdps { mage / shamy ele } min gs 6k /// nothing ress /// all item rolled /// must have time /// link achvi /// come VH for inspect // 20 /25',
		should_fail = false,
		raid = 'toc25hc',
		roles = {'healer', 'tank', 'dps'},
		gs = '6.0',
	},
	
	{
		message = '<Release and Run> is a progressive guild led by experienced players. Looking for competent people for our ICC + RS 25man groups. Progress: 11/12 25hc and 12/12 10hc. RT 7pm ST, EPGP+LC used. Apply at [http://releaseandrun.shivtr.com]',
		should_fail = true,
	},
	
	{
		message = 'LFM ALL VOA 25 5k gs + /W ME ONLY FROST. DPS = LOCK ROGUE WARR PRIEST LFM ALL VOA 25 5k gs + /W ME ONLY FROST. DPS = LOCK ROGUE WARR PRIEST LFM ALL VOA 25 5k gs + /W ME ONLY FROST. DPS = LOCK ROGUE WARR PRIEST',
		should_fail = false,
		raid = 'voa25',
		roles = {'dps', 'healer', 'tank'},
		gs = '5.0',
	},
	
	{
		message = 'Lfm ICC 25 8 dps. 5/12 killed Dreamwalker. Restarting Run. Wisper me gs / Achieve.',
		should_fail = false,
		raid = 'icc25nm',
		roles = {'dps'},
		gs = ' ',
	},
	
	{
		message = 'WTS 6.4k gs Fire mage w lots of BiS, Boes, Transmog, Ashes of Alar mount, 450 tailor/enchant. Can remove items if needed. Char name - "Onepiecenami" on armory. LOD/RS25 achieve. can remove gear as needed',
		should_fail = true,
	},
	
	{
		message = 'Selling BIS Nelf Hunter with LOD,Bane,RS25HC. Everything is BIS. 11-12k DPS on dummy. Also loads of other stuff. /w for more info. only trading via warmane marketplace. Easy TOP DPS every raid. :)',
		should_fail = true,
	},
	
	{
		message = 'GUILD |cffffff00|Hachievement:3917:070000000012D4AD:1:3:15:15:4294967295:4294967295:4294967295:4294967295|h[Adrenaline]|h|r is LF members for ICC/RS25 HC and glory runs for BANE/TOC/NAXX/ULDU. Req: 6.1+ Discord. DkP/Raids@ 5 ST. Apply: https://adrenaline-icecrown.shivtr.com or wisp.',
		should_fail = true,
	},
	
	{
		message = 'Guild <Adrenaline> LF members for ICC/RS25 HC and glory runs for BANE/ULDU/TOC. Req: 6.1k+ Discord. Apply; [adrenaline-icecrown.shivtr.com] Raids @ 5-6 Pmst.',
		should_fail = true,
	},
	
	{
		message = '|cffffff00|Hachievement:2336:0x07000000000023FF:0:0:0:0:0:0:0:0|h[Primus]|h|r is LFM heroic experienced players. ICC25HC 12/12 - ICC10HC 12/12 - RS10HC 4/4 -4PM ST/DKP/DISCORD - PRIMUS-WARMANE.SHIVTR.COM',
		should_fail = true,
	},
	
	{
		message = '#### LFM VOA 25 NEED ALL /w GS AND SPEC FROST ONLY FAST RUN !!!! (warr pvp set res!( #####',
		should_fail = false,
		raid = 'voa25',
		roles = { 'dps', 'healer', 'tank' },
		gs = ' ',
	},
	
	{
		message = 'ICC 10HC/nm need 1TANK 2HEALS 1DPS(preff Fwar)!min 6k +achiv! (B/P ress) _!',
		should_fail = false,
		raid = 'icc10hc',
		roles = { 'dps', 'healer', 'tank' },
		gs = '6.0',
	},
	
	{
		message = 'Lfm fresh raid ToC 25 nm fast run need healers tank and dps rdps ..mins gs 5500 !! (BOE RESS ) +++++++',
		should_fail = false,
		raid = 'toc25nm',
		roles = { 'dps', 'healer', 'tank' },
		gs = '5.5',
	},
	
	{
		message = 'LFM VOA 25 Need all 5.2+  FIRE+Frost Fast Run',
		should_fail = false,
		raid = 'voa25',
		roles = { 'dps', 'healer', 'tank' },
		gs = '5.2',
	},
	
	{
		message = ' >Industry< IS LOOKING FOR SKILLED AND FRIENDLY MEMBERS TO FILL OUR CORE GROUPS. We are raiding ICC25HC,ICC10HC/N,RS,ULDUAR AND XMOG RUNS. USING DKP SYSTEM AND DISCORD. FEEL FREE TO APPLY ON industry.shivtr.com. FOR MORE INFO /W ME. RT 5pm st',
		should_fail = true,
	},
	
	{
		message = 'NEED TANK FOR ICC 10 HC 9/12 BOSES HC !! LINK BEST ACHIVE AND GS !!',
		should_fail = false,
		raid = 'icc10hc',
		roles = { 'tank' },
		gs = ' ',
	},
	
	{
		message = 'TOC  NM LF 3  RDPS link [Call of the Crusade (10 player)]',
		should_fail = false,
		raid = 'toc10nm',
		roles = { 'dps' },
		gs = ' ',
	},
	
	{
		message = 'LFM all FOR ICC 10 nm 5300 mini gs',
		should_fail = false,
		raid = 'icc10nm',
		roles = { 'dps', 'tank', 'healer' },
		gs = '5.3',
	},
	
	{
		message = 'LFM ULDAUR - 25 - Need 1 HEAL 5 DPS 1/12 BOSS - +5.1 GS - RAID 24/25 /w me - CraSh Serveur -PpL dc-',
		should_fail = false,
		raid = 'ulduar25',
		roles = { 'healer', 'dps' },
		gs = '5.1',
	},
	
	{
		message = 'TOC 10 HC NEED 1 TANK 6.2k GS (Pally)',
		should_false = false,
		raid = 'toc10hc',
		roles = { 'tank' },
		gs = '6.2',
	},
	
	{
		message = 'ULDUAR 10M HC NEED 2 TANKY - -- GS 5.5K--- ',
		should_false = false,
		raid = 'ulduar10',
		roles = { 'tank' },
		gs = '5.5',
	},
	
	{
		message = 'LFM Ulduar 25 - Need 2 heal 3 DPS - 1Boss dead - +5.1k gs /w me 20/25..',
		should_fail = false,
		raid = 'ulduar25',
		roles = { 'healer', 'dps' }, 
		gs = '5.1'
	},
	
	{
		message = 'ICC 25HC/N need MDPS RDPS HEALS 6,1k+  lk  run   no  achiv no [INV][ [The Light of Dawn]]  b+p+sfs  res discord req',
		should_fail = false,
		raid = 'icc25hc',
		roles = { 'dps', 'healer' },
		gs = '6.1'
	},

	{
		message = 'LF TOc 10 Nm need Rdps and x2 tank  Gs +5.1k Scroll RuN  [Call of the Grand Crusade (10 player)]..',
		should_fail = false,
		raid = 'toc10nm',
		roles = { 'dps', 'tank' },
		gs = '5.1',
	},
	
	{
		message = 'LF DPS FOR LAST SPOT 3 drake MOUNT RUN LAST SPOT GROUP LOOT DPS LAST SPOT 5.7k+ RANGED DPS MOUNT FREE ROLL GROUP LOOT DPS LAST SPOT OS 3 drake SUMMONING 10  MAN QUICK HURRY UP TRASH CLEAR 10 man os 3 drake zerg',
		should_fail = false,
		raid = 'os10',
		roles = { 'dps' },
		gs = '5.7',
	},
	
	{
		message = 'LFM <<<<<ICC 25 HC/N 5.9k min  ONLY DPS >>>>>>>>>>> B+p ress  [Fall of the Lich King (25 player)]',
		should_fail = false,
		raid = 'icc25hc',
		roles = { 'dps' },
		gs = '5.9',
	},
	
	{
		message = 'DRUID TANK 5.4k LF ICC10/25 TOC 10/25',
		should_fail = true,
	},
	
	{
		message = 'LF TOC 5 NM NEED  HEAL',
		should_fail = true,
	},
	
	{
		message = 'Voa 10 Man W/me Need All 4/10',
		should_fail = false,
		raid = 'voa10',
		roles = { 'dps', 'tank', 'healer' },
		gs = ' ',
	},
	
	{
		message = 'LF TOC 10 NM NEED  HEAL',
		should_fail = false,
		raid = 'toc10nm',
		roles = { 'healer' },
		gs = ' ',
	},
	
	{
		message = '<Scale> is now recuiting competitive players to fill our core. ICC25HC 12/12 ICC10HC 12/12 RS10hc 4/4 we require TS3 and decent gear for heroics our raid time is 5pm st feel free to apply on [https://scale.shivtr.com]',
		should_fail = true,
	},
	
	{
		message = '- // ICC 10 REP FARM // - Master Loot -  // w me ',
		should_fail = false,
		raid = 'icc10rep',
		roles = { 'dps', 'tank', 'healer' },
		gs = ' '
	},
	
	{
		message = ' LFM ICC 25 n/hcNEED boom gs+5.9[Heroic: The Frostwing Halls (25 player)]no achi no [inv]',
		should_fail = false,
		raid = 'icc25nm',
		roles = { 'dps' },
		gs = '5.9',
	},
	
	{
		message = '<Fade> is recruiting!  We are a social-pve guild raiding at 11 PM Server Time!  Doing daily 25man raids such as ICC 25HC / TOC 25HC / RS 25HC,  Achievment raids as Ulduar 25 / TBC Raids  Using Discord/DKP loot system! Join us!  /w me for more info!',
		should_fail = true,
	},
	
	{
		message = 'lfm VOA 25 need tank heal dps 5+ fire frost',
		should_fail = false,
		raid = 'voa25',
		roles = { 'tank', 'healer', 'dps' },
		gs = '5.0',
	},
	
	{
		message = '<Asperity> End game guild looking for exceptional players to join our roster. ICC10hc 12/12, ICC25hc 11/12, RS25N 4/4. Raid time: 10 PM ST. We use DKP+DISCORD 6.1k+ Apply @ [Asperity-ic.shivtr.com]',
		should_fail = true,
	},
	
	{
		message = 'VOA 25  5k+ fire + frost need Mdps Dk/dudu/war',
		should_fail = false,
		raid = 'voa25',
		roles = { 'dps' },
		gs = '5.0',
	},
	
	{
		message = 'ICC10REP-FARM NEED heal MUST CAN FLY  boe ress',
		should_fail = false,
		raid = 'icc10rep',
		roles = { 'healer' },
		gs = ' ',
	},
	
	{
		message = ' lf icc 10 group',
		should_fail = true,
	},
	
	{
		message = 'LF DPS VoA25, fast run, 5k gs+ (Feral pvp/pve legs res)',
		should_fail = false,
		raid = 'voa25',
		roles = { 'dps' },
		gs = '5.0',
	},
	
	{
		message = '10VOA NEED warri OT',
		should_fail = false,
		raid = 'voa10',
		roles = { 'tank' },
		gs = ' ',
	},
	
	{
		message = 'LFG VOA 10/25 - rdps',
		should_fail = true,
	},
	
	{
		message = 'VOA 25 DPS  /W CLASS AND GS (RESS ROGUE)',
		should_fail = false,
		raid = 'voa25',
		roles = { 'dps' },
		gs = ' ',
	},
	
	{
		message = 'TOC 10 NM semi grun 1x Main tank 5k+ 9/10',
		should_fail = false,
		raid = 'toc10nm',
		roles = { 'tank' },
		gs = '5.0',
	},
	
	{
		message = '5.9k ret pally / 5.3k holy LF VOA Group',
		should_fail = true,
	},
	
	{
		message = '<TOC 25n> FAST SCROLL + EOT RUN (25MIN RAID)! 5,5K GS + [Call of the Crusade (25 player)]! B/P/O RESS!',
		should_fail = false,
		raid = 'toc25nm',
		roles = { 'dps', 'healer', 'tank' },
		gs = '5.5'
	},
	
	{
		message = 'VOA 25 1xheal 2xRdps /w me',
		should_fail = false,
		raid = 'voa25',
		roles = { 'healer', 'dps' },
		gs = ' '
	},
	
	{
		message = 'VOA10 Frost only, Class run need all /w me ',
		should_fail = false,
		raid = 'voa10',
		roles = { 'dps', 'healer', 'tank' },
		gs = ' ',
	},
	
	{
		message = 'VOA 10 NEED RSHAMY AND 1 TANK ',
		should_fail = false,
		raid = 'voa10',
		roles = { 'healer', 'tank' },
		gs = ' ',
	},
	
	{
		message = 'Tides of Azshara is a social PvE guild currently looking for members, all levels are welcome, We currently need all classes(Low on healers) for our building of a progression team for TOC/ICC 10!',
		should_fail = true,
	},
	
	{
		message = 'PALA DPS 5.9 LFG ICC10 REP!!!!!! [INV] ME!!!!!!<3',
		should_fail = true,
	},
	
	{
		message = ' <<Knuckles Deep>> LF 5.6K+ ACTIVE RAIDERS for ICC 10 HC + ICC 25 NM PROGRESSION!!--> LF DISC/HOLY PRIEST + RANGED DPS --> 4PM/6PM ST RAID TIMES!!',
		should_fail = true, 
	},
	
	{
		message = 'LFM VOA 10  need  1 Heler,  clas run  min gs 5,1k 9/10',
		should_fail = false,
		raid = 'voa10',
		roles = { 'healer', },
		gs = '5.1'
	},
	
	{
		message = '5.1k prot pally LFG VOA 10/25',
		should_fail = true,
	},
	
	{
		message = '[Sartharion Must Die!] OS 10 heal/dps 4.5k+',
		should_fail = false,
		raid = 'os10',
		roles = { 'healer', 'dps' },
		gs = '4.5',
	},
	
	{
		message = 'VOA 25 wiss me (DK item ress) DPS 24/25',
		should_fail = false,
		raid = 'voa25',
		roles = { 'dps' },
		gs = ' ',
	},
	
	{
		message = 'LF 2 Healers and dps VoA25 5k gs+ fast run! (Mage items res)',
		should_fail = false,
		raid = 'voa25',
		roles = { 'healer', 'dps' },
		gs = '5.0',
	},
	
	{
		message = 'druid tank 5.8 LF ICC 25',
		should_fail = true
	},
	
	{
		message = '!!! Bulgarski Guild < BOMBASTIC  > nabira seriozni i opitni igrachi sus svobodno vreme i jelanie za igra za svoite raidove ICC / RS / Ulduar.   ICC 10 HC 10/12. !! RS  10 - 25  /  ICC 10 - 25 = CLEAR !.  Iziskvaniq 5,8 GS  ++ !',
		should_fail = true
	},
	
	{
		message = 'INV FOR  ICC REP FARM',
		should_fail = true,
	},
	
	{
		message = 'HUNT 5K8 LF ICC 10 N /H',
		should_fail = true,
	},
	
	{
		message = ' Nova bulgarska guildiq < X A H O B E T E > tursi PVE IGRACHI za ICC 10 / 25 // TOC 10/25 ?? RS 10/25//',
		should_fail = true,
	},
		      
	{
		message = '1 tank for ICC 10 Run - 9/10, aim 11/12',
		should_fail = false,
		raid = 'icc10nm',
		roles = { 'tank' },
		gs = ' ',
	},
		      
	{
		message = 'TOC 10 NM 1 TANK 1 HEAL + 1 PRIEST DPS',
		should_fail = false,
		raid = 'toc10nm',
		roles = { 'tank', 'healer', 'dps' },
		gs = ' ',
	},
	
	{
		message = '1 Lock for ICC 10 NM/HC.. Gs Req 5.7... [The Frostwing Halls (10 player)]...9/10',
		should_fail = false,
		raid = 'icc10nm',
		roles = {'dps'},
		gs = '5.7',
	},
	
	{
		message = 'some icc25',
		should_fail = true,
	},
	
	{
		message = 'OS 10+3 systém  ---> WEEKLY quest ->> drop 100% fly mout -> ACHIEV -> drop bag 22sloth ->  need all +6K gs tank, dmg  /W me   [Reins of the Black Drake]',
		should_fail = false,
		raid = 'os10',
		roles = { 'dps', 'healer', 'tank' },
		gs = '6.0',
	},
	
	-- meta_raid .. sep .. nonalpha .. meta_roles .. sep .. nonalpha .. gs
	{
		message = 'TOC 25NM NEED ** 1RESTO DRUID/SHAMAN  &  DPS** 5.5 GS + w/me gs spec and link achiv or NO [inv] !!! Throphy reserv [Call of the Crusade (25 player)]',
		should_fail = false,
		raid = 'toc25nm',
		roles = { 'healer', 'dps' },
		gs = '5.5',
	},
	
	{
		 message = 'lf icc10 5.5k rogue',
		 should_fail = true,
	},
	
	{
		message = 'lf rogue icc10 5.5k',
		should_fail = false,
		raid = 'icc10nm',
		roles = { 'dps' },
		gs = '5.5'
	},
	
	{
		message = 'ICC 10 N/HC # LF   TANK # HEAL # DPS 5.8k+ LINK KS # BRING TIME #  B+P  Reserved',
		should_fail = false,
		raid = 'icc10nm',
		roles = { 'tank', 'healer', 'dps' },
		gs = '5.8',
	},
	
	{
		message = 'LFM  [Anub\'Rekhan Must Die!] NEED ALL',
		should_fail = false,
		raid = 'naxx10',
		roles = { 'dps', 'healer', 'tank' },
		gs = ' ',
	},
	
	{
		message = 'LFM ICC 10 N REP FARM NEED  2 HEAL 4.5 (BOE RESS)',
		should_fail = false,
		raid = 'icc10rep',
		roles = { 'healer' },
		gs = '4.5',
	},
	
	{
		message = 'LFM [The Black Temple] Achievement and Transmog run',
		should_fail = false,
		raid = 'black temple',
		roles = { 'dps', 'healer', 'tank' },
		gs = ' ',
	},
	
	{
		message = 'LF tank ICC nm10',
		should_fail = false,
		raid = 'icc10nm',
		roles = { 'tank' },
		gs = ' ',
	},
	
	{
		message = 'LF tank ICC 10nm',
		should_fail = false,
		raid = 'icc10nm',
		roles = { 'tank' },
		gs = ' ',
	},
	
	{
		message = 'LFM |cffffff00|Hachievement:697:07000000001CB65C:0:0:0:-1:0:0:0:0|h[The Black Temple]|h|r. Get some transmorg. 12/20',
		should_fail = false,
		raid = 'black temple',
		roles = { 'dps', 'tank', 'healer' },
		gs = ' ',
	},
	
	{
		message = 'lfm mount hyjal XMOG RUn need all lvl 80 only w me fast  [The Battle for Mount Hyjal] TOken Hand Pala res',
		should_fail = false,
		raid = 'hyjal',
		roles = { 'dps', 'healer', 'tank' },
		gs = ' ',
	},
	
	{
		message = 'LFM  ALL TO [Zul\'Aman]/ TRANSMOG RUN ALL FREE!!',
		should_fail = false,
		raid = 'zul\'aman',
		roles = { 'dps', 'healer', 'tank' },
		gs = ' ',
	},
	
	{
		message = 'LFM RS10 NM! Need 1 TANK - 2HEAL - 5DPS ! 5k8 + Link ACHIV or no inv ! ID in front of the boss ! {losange}',
		should_fail = false,
		raid = 'rs10nm',
		roles = { 'tank', 'healer', 'dps' },
		gs = '5.8',
	},
	
	{
		message = 'PVE guild <Abyssal> is recruiting serious and dedicated players. LF active players (6,2k GS) with decent HC knowledge.Our progress:ICC 10 12/12HC, ICC 25 11/12HC, RS 25 4/4.Raids @ 5PM ST (using Discord/DKPs).Apply on [http://abyssal.shivtr.blue/]',
		should_fail = true,
	},
	
	{
		message = 'Guild ++ Virtual Experience ++ Trazi nove clanove za raidovanje. Radimo progres Guild-a! 12/12 NM, 11/12 HC, 25man 12/12 NM, 6/12 HC! Trazimo samo ozbiljne igrace koji ce biti aktivni! Za vise info /w me.',
		should_fail = true,
	},
	
	{
		message = '<ICC25HC> Lfm Dps( War Boomy) W me Gs 6.2+ And link Hc Achive(Lady PP Sindy Lk Norm){B/P+Shard Res}  [Bane of the Fallen King]',
		raid = 'icc25hc',
		roles = { 'dps' },
		gs = '6.2',
	},
	
	{
		message = '<<<LFM NEED 1 TANK 3 HEALERS SOME DPS FOR SSC HUNTER TOKENS RESERVED [Serpentshrine Cavern]',
		should_fail = false,
		raid = 'ssc',
		roles = { 'tank', 'healer', 'dps' },
		gs = ' ',
	},
	
	{
		message = 'LFM RS 10 NM NEED 1MDPS GS MIN 5.8KGS+ACHIEV WISP ME ',
		should_fail = false,
		raid = 'rs10nm',
		roles = { 'dps' },
		gs = '5.8',
	},
	
	{
		message = 'Guild <Elites>  player irani mipazirad >>> Raid hai ICC 25/10 >>>Rs 25/10 . TS3 va DKp system  / RAid time 8 SHab >[The Light of Dawn]<',
		should_fail = true,
	},

	{
		message = 'LFM icc 10 nm/hc need 1tank(pala-dudu) [Heroic: The Frostwing Halls (25 player)] gs+6k fast run eof farm lk run',
		should_fail = false,
		raid = 'icc10nm',
		roles = { 'tank' },
		gs = '6.0',
	},
	
	{
		message = 'LF All, ICC Rep Farm, boe ress',
		should_fail = false,
		raid = 'icc10rep',
		roles = { 'dps', 'healer', 'tank' },
		gs = ' ',
	},
	
	{
		message = ' [Magtheridon\'s Lair] NEED ALL,  [Chestguard of the Fallen Defender] [Magtheridon\'s Head] RES ',
		should_fail = false,
		raid = 'mag\'s lair',
		roles = { 'dps', 'healer', 'tank' },
		gs = ' ',
	},
	
	{
		message = 'TOC 25 N LF ALL b/p res W ME GS 5K+++++ [Call of the Crusade (25 player)]',
		should_fail = false,
		raid = 'toc25nm',
		roles = { 'dps', 'healer', 'tank' },
		gs = '5.0',
	},
	
	{
		message = 'Guild ++ Virtual Experience ++ Trazi nove clanve za radidovanje! Radimo progres Guild-a! Radimo ICC 10nm 12/12, HC 11/12, 25m, 12/12, HC 6/12, RS 4/4. Takodje radimo i Ulduar,TOC 10,25man.. Igraci sa 5.8+gs, akitvni i ozbilji nek se jave! /w me.',
		should_fail = true,
	},
	
	{
		message = ' ICC 25 N/HC 6k+NEED ALL ATM link BEST ACHV[Heroic: The Frostwing Halls (25 player)] ',
		should_fail = false,
		raid = 'icc25nm',
		roles = { 'dps', 'tank', 'healer' },
		gs = '6.0',
	},
	
	{
		message = 'LFM [Tempest Keep] tank 5k+ mount run',
		should_fail = false,
		raid = 'tempest keep',
		roles = { 'tank' },
		gs = '5.0',
	},
	
	{
		message = 'NEED ALL FOR TOC 10 (HC) W/ME UR GS CLASS AND SPEC ! LINK ACHIEV ! NO ACHIEV NO [INVITE] !(boes ress) NEED 21 TANK AND GO !',
		should_fail = false,
		raid = 'toc10hc',
		roles = { 'dps', 'healer', 'tank' },
		gs = ' ',
	},
	
	{
		message = 'LFM [Tempest Keep] MOUNT RUN (HEALS, DPS NEEDED) FREE ROLL 4 [Ashes of Al\'ar]',
		should_fail = false,
		raid = 'tempest keep',
		roles = { 'dps', 'healer' },
		gs = ' ',
	},
	
	{
		message = 'LF1 OT 5.8gs+ icc10hc @plague!',
		should_fail = false,
		raid = 'icc10hc',
		roles = { 'tank' },
		gs = '5.8',
	},
	
	{
		message = 'Icc 25 N / HC W/m Gs spec Achiv Boe + Primo Reserved [Fall of the Lich King (25 player)]',
		should_fail = false,
		raid = 'icc25nm',
		roles = { 'dps', 'tank', 'healer' },
		gs = ' ',
	},
	
	--[[{
		message = 'NEED DPS and  FOR VOA LAST SPOTS 24/25 warlock needed',
		should_fail = false,
		raid = 'voa25',
		roles = { 'dps' },
		gs = ' ',
	},]]--
	
	--
	--[[{
		message = 'LFM  [Bane of the Fallen King] need dog and mans for tank',
		should_fail = false,
		raid = 'icc25hc',
		roles = { 'tank' },
		gs = ' ',
	},]]-- TODO
	
	--'
	-- Idea: Convert raid/roles/gs into intermediate text such as <role> <class> <raid> <gs> so that the following could
	-- be parsed as: <role> for <raid>/HC.. Gs Req <gs>... [The Frostwing Halls (10 player)]...9/10
	-- This could be a more powerful technique for distinguishing between LFM messages and other messages
	
	--[[
		1. first discard non-lfm messages
		2. discard raids without a mentioned raid
		3. save raid, role, and gs info
		4. convert string into (raid) (role) (gs) format for lfm parsing
		5. parse string: e.g. (role) for (raid) (gs)?
		
	]]--
} 

local function array_contains(t, element)
	for _, k in ipairs(t) do
		if k == element then
			return true;
		end
	end
	
	return false;
end

local function subset_of(table1, table2)
	if #table1 ~= #table2 then
		return false;
	end
   
	for _, x in ipairs(table1) do
		
		if not array_contains(table2, x) then
			return false;
		end
	end
	
	return true;
end

local function display_test(test)
	local roles_string = '';
	local raid_string = test.raid or '';
	local gs_string = test.gs or '';
	
	if (test.roles) then
		for _, role in ipairs(test.roles) do
			roles_string = role .. ' ' .. roles_string;
		end
	end
	
	raid_browser:Print('Original message: ' .. test.message);
	raid_browser:Print('[Required]: ' .. raid_string .. ', ' .. roles_string .. ', ' .. gs_string);
	raid_browser:Print('Should fail: ' .. tostring(test.should_fail));
end

local function test_failed(test, detected, message)
	display_test(test);
	raid_browser:Print('Test failed: ' .. message);
	
	if detected then
		local roles_string = std.algorithm.fold(detected.roles, '', function(text, role)
			return text .. role .. ' ';
		end)
		
		raid_browser:Print('[Detected]: ' .. detected.raid .. ', ' .. roles_string .. ', ' .. detected.gs);
	end
	
	print('');
end

local function run_test_case(test)
	local raid_info, roles, gs = raid_browser.raid_info(test.message)
	
	local detected = nil;
	if raid_info and roles and gs then
		detected = {raid = raid_info.name, roles = roles, gs = gs};
	end
	
	if test.should_fail then
		-- If we found an lfm message, then the test failed
		if raid_info then
			test_failed(test, detected, 'test should have failed');
			return false;
		end
	else
		-- No raid was found
		if not raid_info then
			test_failed(test, detected, 'no raid detected');
			return false;
		
		elseif test.raid ~= raid_info.name then
			test_failed(test, detected, 'detected raid name is incorrect');
			return false;
			
		elseif test.gs ~= gs then 
			test_failed(test, detected, 'detected gearscore is incorrect');
			return false;
		
		-- Incorrect gearscore detected
		elseif not (test.gs == gs) then 
			test_failed(test, detected, 'detected gearscore is incorrect');
			return false;
			
		-- Incorrect list of roles
		elseif not subset_of(test.roles, roles) then
			test_failed(test, detected, 'detected list of roles is not correct');
			return false;
		end
	end
	
	return true;
end

-- Run all the test cases
local test_results = std.algorithm.transform(test_cases, run_test_case);

-- Count the number of failed tests.
local number_failed_tests = #test_cases - std.algorithm.count(test_results, true);

raid_browser:Print('All unit tests executed.');
raid_browser:Print('There were ' .. number_failed_tests .. '/' .. #test_cases .. ' failed unit tests!');
