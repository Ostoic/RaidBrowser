local folder, addon = ...
raid_browser = raid_browser or addon;

-- Register addon
LibStub("AceAddon-3.0"):NewAddon(raid_browser, folder, "AceConsole-3.0", "AceSerializer-3.0", "AceHook-3.0", "AceEvent-3.0")

local function printf(...) DEFAULT_CHAT_FRAME:AddMessage('|cffff6600[RaidBrowser]: '..format(...)) end

local raid_list = {
   icc10rep = {
		'icc[%s]*10[%s]*rep[%s]*',
		'rep[%s]*icc[%s]*10',
	},

   icc25rep = {
		'icc[%s]*25[%s]*rep[%s]*',
		'rep[%s]*icc[%s]*25',
	},

   icc10hc = {
		'icc[%s]*10[%s]*hc?',
		'hc?[%s]*icc[%s]*10',
		'icc[%s]*hc?[%s]*10',
		'10[%s]*icc[%s]*hc?',
	},

	icc25hc = {
		'icc[%s]*25[%s]*hc?',
		'hc?[%s]*icc[%s]*25',
		'icc[%s]*hc?[%s]*25',
		'25[%s]*icc[%s]*hc?'
	},

   icc10nm = {
		'icc[%s]*10[%s]*nm?',
		'nm?[%s]*icc[%s]*10',
		'icc[%s]*nm?[%s]*10',
		'10[%s]*icc[%s]*nm?',
		'icc[%s]*10',
	},

   icc25nm = {
		'icc[%s]*25[%s]*nm?',
		'nm?[%s]*icc[%s]*25',
		'icc[%s]*nm?[%s]*25',
		'25[%s]*icc[%s]*nm?',
		'icc[%s]*25',
	},

   toc10 = {"toc[%s]*10"},
   toc25 = {"toc[%s]*25"},
   voa10 = {"voa[%s]*10"},
   voa25 = {"voa[%s]*25"},
   rs10 = {'rs[%s]*10'},
   rs25 = {'rs[%s]*25'},

   ulduar10 = {
		'uld[%s]*10',
		'ulduar[%s]*10',
   },
}

local raid_roles = {
   ranged_dps = "rdps",
   melee_dps = "mdps",
   dps = 'dps',
   healer = "he[a]?l[er|ers]*",
   tank = "tank[s]?",
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
   'looking[%s]*for[%s]*[0-9]*[%s]*more',
   'lf[%s]*.*for',
   'lf[%s]*all',
   'need',
   'need[%s]*all',
}

-- Raids expire after 60 seconds
raid_browser.expiry_time = 60;

raid_browser.active_raids = {}

local function refresh_active_raids()
   for name, info in pairs(raid_browser.active_raids) do
	  -- If the last message from the sender was too long ago, then
	  -- remove his raid from active_raids.
      if time() - info[4] > raid_browser.expiry_time then
         raid_browser.active_raids[name] = nil;
      end
   end
end

function raid_browser.raid_info(message)
   message = string.lower(message)

   local found_lfm = false;
   -- Search for LFM announcement in the message
   for _, pattern in pairs(lfm_patterns) do
      if string.find(message, pattern) then
         found_lfm = true
      end
   end

   if not found_lfm then
      return nil
   end

   -- Get the raid from the message
   local raid = nil;
   for r, pattern_list in pairs(raid_list) do
	  for _, pattern in ipairs(pattern_list) do
        local result = string.find(message, pattern);

		  -- If a raid was found then save it and continue.
		  if result then
			 raid = r

			 message = string.gsub(message, pattern, '')
			 -- Remove the substring from the message
			 break
		  end
	  end
   end

   -- Get any roles that are needed
   local roles = {};
   for r, pattern in pairs(raid_roles) do
      local result = string.find(message, pattern)

	  -- If a raid was found then save it to our list of roles and continue.
      if result then
         table.insert(roles, r)

		 -- Remove the substring from the message
         message = string.gsub(message, pattern, '')
      end
   end

   -- If there is only an LFM message, then it is assumed that all roles are needed
   if #roles == 0 then
      roles = {'dps', 'tank', 'healer'}
   end

   local gs = nil;

   -- Search for a gearscore requirement.
   for _, pattern in pairs(gearscore_patterns) do
      local gs_start, gs_end = string.find(message, pattern)

	  -- If a gs requirement was found, then save it and continue.
      if gs_start and gs_end then
         gs = string.sub(message, gs_start, gs_end)
         break
      end
   end

   if not gs then
      gs = 'N/A'
   end

   return raid, roles, gs
end

local function event_handler(self, event, message, sender)
   if event == "CHAT_MSG_CHANNEL" then
      local raid, roles, gs = raid_browser.raid_info(message)
      if raid and roles and gs then
         local roles_string = nil;

         -- Build the LFR string
         for _, role in pairs(roles) do
            if not roles_string then
               roles_string = role
            else
               roles_string = roles_string .. ', ' .. role
            end
         end

         -- Put the sender in the table of active raids
         raid_browser.active_raids[sender] = {raid, roles, gs, time(), message};
         raid_browser.gui.update_list();
      end
   end
end

function raid_browser:OnEnable()
  printf("RaidBrowser loaded. Type /rb to toggle the raid browser.")

  raid_browser.timer = raid_browser.set_timer(10, refresh_active_raids, true)
  raid_browser.listener = raid_browser.add_event_listener("CHAT_MSG_CHANNEL",  event_handler )
end

function raid_browser:OnDisable()
  raid_browser.remove_event_listener ("CHAT_MSG_CHANNEL", raid_browser.listener)
  printf("RaidBrowser stopped")
  
  raid_browser.kill_timer(raid_browser.timer)
end