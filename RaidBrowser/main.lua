local folder, addon = ...
raid_browser = raid_browser or addon;

LibStub("AceAddon-3.0"):NewAddon(raid_browser, folder, "AceConsole-3.0", "AceSerializer-3.0", "AceHook-3.0", "AceEvent-3.0") 

function raid_browser:OnEnable()
	raid_browser.start();
end

function raid_browser:OnDisable()
	raid_browser.stop();
end

-- TODO: Register addon, setup slash commands, etc

local raid_list = {
   icc10rep = 'icc[ ]*10[ ]*rep[ ]*',
   icc25rep = 'icc[ ]*25[ ]*rep[ ]*',
   icc10 = "icc[ ]*10",
   icc25 = "icc[ ]*25",
   toc10 = "toc[ ]*10",
   toc25 = "toc[ ]*25",
   voa10 = "voa[ ]*10",
   voa25 = "voa[ ]*25",
   rs10 = 'rs[ ]*10',
   rs25 = 'rs[ ]*25',
}

raid_browser.roles = {
   ranged_dps = "rdps",
   melee_dps = "mdps",
   dps = 'dps',
   healer = "he[a]?l[er|ers]?",
   tank = "tank[s]?",
}

local gearscore_patterns = {
   '[1-6][.,][0-9]',
   '[1-6][ ]*k[ ]*%+?',
   '%+?[ ]*[1-6][ ]*k',
   '[1-6][0-9][0-9][0-9]',
   '[1-6]%+',
}

local lfm_patterns = {
   'lf[0-9]*m',
   'lf[ ]*all',
   'need',
   'need[ ]*all',
}

-- Raids expire after 60 seconds
raid_browser.expiry_time = 60; 

raid_browser.active_raids = {}

local function refresh_active_raids()
   for name, info in pairs(raid_browser.active_raids) do
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
   for r, pattern in pairs(raid_list) do
      local result = string.find(message, pattern);
      if result then
         raid = r
         message = string.gsub(message, pattern, '')
         break
      end
   end
   
   -- Get any roles that are needed
   local roles = {};
   for r, pattern in pairs(raid_browser.roles) do
      local result = string.find(message, pattern)
      if result then 
         table.insert(roles, r)
         message = string.gsub(message, pattern, '')
      end
   end
   
   -- If there is only an LFM message, then it is assumed that all roles are needed
   if #roles == 0 then
      roles = {'dps', 'tank', 'healer'}
   end
   
   local gs = nil;
   for _, pattern in pairs(gearscore_patterns) do
      local gs_start, gs_end = string.find(message, pattern)
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

function raid_browser.start()
   if not raid_browser.listener then 
      print("[RaidBrowser] Loaded. Type /rb to toggle the raid browser.")
      
      raid_browser.timer = raid_browser.set_timer(10, refresh_active_raids, true)
      raid_browser.listener = raid_browser.add_event_listener("CHAT_MSG_CHANNEL",  event_handler )
   end
end

function raid_browser.stop()
   if raid_browser.listener then
      raid_browser.remove_event_listener ("CHAT_MSG_CHANNEL", raid_browser.listener)
      print("[RaidBrowser] Browser stopped")
      raid_browser.listener = nil
      raid_browser.kill_timer(raid_browser.timer)
   end
end