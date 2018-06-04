local folder, addon = ...
raid_browser = raid_browser or addon;

-- Register addon
LibStub("AceAddon-3.0"):NewAddon(raid_browser, folder, "AceConsole-3.0", "AceSerializer-3.0", "AceHook-3.0", "AceEvent-3.0")

local function printf(...) DEFAULT_CHAT_FRAME:AddMessage('|cff0061ff[RaidBrowser]: '..format(...)) end

local raid_list = {
	-- Note: The order of each raid is deliberate.
	-- Heroic raids are checked first, since NM raids will have the default 'icc10' pattern. 
	-- Be careful about changing the order of the raids below
	{
		name = 'icc10rep',
		patterns = {
			 'icc[%s]*10[%s]*rep',
			 'rep[%s]*icc[%s]*10',
			 'icc[%s]*rep',
		}
	},

	{
		name = 'icc25rep',
		patterns = {
			'icc[%s]*25[%s]*rep[%s]*',
			'rep[%s]*icc[%s]*25',
		}
	},
	
	{
		name = 'icc10hc',
		patterns = {
			'icc[%s]*10[%s]*%(?hc?%)?',
			'%(?hc?%)?[%s]*icc[%s]*10',
			'icc[%s]*%(?hc?%)?[%s]*10',
			'10[%s]*icc[%s]*%(?hc?%)?',
		}
	},

	{
		name = 'icc25hc',
		patterns = {
			'icc[%s]*25[%s]*%(?hc?%)?',
			'%(?hc?%)?[%s]*icc[%s]*25',
			'icc[%s]*%(?hc?%)?[%s]*25',
			'25[%s]*icc[%s]*%(?hc?%)?'
		}
	},

	{
		name = 'icc10nm',
		patterns = {
			'icc[%s]*10[%s]*%(?nm?%)?',
			'%(?nm?%)?[%s]*icc[%s]*10',
			'icc[%s]*%(?nm?%)?[%s]*10',
			'10[%s]*icc[%s]*%(?nm?%)?',
			'icc[%s]*10',
		}
	},

	{
		name = 'icc25nm',
		patterns = {
			'icc[%s]*25[%s]*%(?nm?%)?',
			'%(?nm?%)?[%s]*icc[%s]*25',
			'icc[%s]*%(?nm?%)?[%s]*25',
			'25[%s]*icc[%s]*%(?nm?%)?',
			'icc[%s]*25',
		}
	},

	{
		name = 'toc10hc',
		patterns = {
			'toc[%s]*10[%s]*%(?hc?%)?',
			'%(?hc?%)?[%s]*toc[%s]*10',
			'toc[%s]*%(?hc?%)?[%s]*10',
			'10[%s]*toc[%s]*%(?hc?%)?',
		}
	},

	{
		name = 'toc25hc',
		patterns = {
			'toc[%s]*25[%s]*%(?hc?%)?',
			'%(?hc?%)?[%s]*toc[%s]*25',
			'toc[%s]*%(?hc?%)?[%s]*25',
			'25[%s]*toc[%s]*%(?hc?%)?',
		}
	},

	{
		name = 'toc10nm',
		patterns = {
			'toc[%s]*10[%s]*%(?nm?%)?',
			'%(?nm?%)?[%s]*toc[%s]*10',
			'toc[%s]*%(?nm?%)?[%s]*10',
			'10[%s]*toc[%s]*%(?nm?%)?',
			'toc[%s]*10',
		}
	},

	{
		name = 'toc25nm',
		patterns = {
			'toc[%s]*25[%s]*%(?nm?%)?',
			'%(?nm?%)?[%s]*toc[%s]*25',
			'toc[%s]*%(?nm?%)?[%s]*25',
			'25[%s]*toc[%s]*%(?nm?%)?',
			'toc[%s]*25',
		}
	},
	
	{
	   name = 'rs10hc',
	   patterns = {
		  'rs[%s]*10[%s]*%(?hc?%)?',
		  '%(?hc?%)?[%s]*rs[%s]*10',
		  'rs[%s]*%(?hc?%)?[%s]*10',
		  '10[%s]*rs[%s]*%(?hc?%)?',
	   }
	},

	{
	   name = 'rs25hc',
	   patterns = {
		  'rs[%s]*25[%s]*%(?hc?%)?',
		  '%(?hc?%)?[%s]*rs[%s]*25',
		  'rs[%s]*%(?hc?%)?[%s]*25',
		  '25[%s]*rs[%s]*%(?hc?%)?',
	   }
	},

	{
	   name = 'rs10nm',
	   patterns = {
		  'rs[%s]*10[%s]*%(?nm?%)?',
		  '%(?nm?%)?[%s]*rs[%s]*10',
		  'rs[%s]*%(?nm?%)?[%s]*10',
		  '10[%s]*rs[%s]*%(?nm?%)?',
		  'rs[%s]*10',
	   }
	},


	{
	   name = 'rs25nm',
	   patterns = {
		  'rs[%s]*25[%s]*%(?nm?%)?',
		  '%(?nm?%)?[%s]*rs[%s]*25',
		  'rs[%s]*%(?nm?%)?[%s]*25',
		  '25[%s]*rs[%s]*%(?nm?%)?',
		  'rs[%s]*25',
	   }
	},
	
	{
		name = 'voa10',
		patterns = {"voa[%s]*10"},
	},
	
	{
		name = 'voa25',
		patterns = {"voa[%s]*25"},
	},
		
	{
		name = 'ulduar10',
		patterns = {
			'uld[%s]*10',
			'ulduar[%s]*10',
		},
	},
	
	{
		name = 'ulduar25',
		patterns = {
			'uld[%s]*25',
			'ulduar[%s]*25',
		}
	},
	
	{
		name = 'os10',
		patterns = {
			'os[%s]*10',
		},
	},
	
	{
		name = 'os25',
		patterns = {
			'os[%s]*25',
		},
	},
}

local raid_roles = {
   ranged_dps = "[0-9]*[%s]*rdps",
   melee_dps = "[0-9]*[%s]*mdps",
   dps = '[0-9]*[%s]*dps',
   healer = "[0-9]*[%s]*he[a]?l[er|ers]*",
   tank = "[0-9]*[%s]*t[a]?nk[s]?",
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

local function remove_achievements(message)
	return string.gsub(message, '|c.*|r', '');
end

function raid_browser.raid_info(message)
	message = string.lower(message)
	
	-- Stop if it's a guild recruit message
	if string.find(message, 'recruit') or string.find(message, 'recruiting') then
		return;
	end
	message = remove_achievements(message);
	

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
	for _, r in ipairs(raid_list) do
		for _, pattern in ipairs(r['patterns']) do
			local result = string.find(message, pattern);

			-- If a raid was found then save it and continue.
			if result then
				raid = r['name'];

				-- Remove the substring from the message
				message = string.gsub(message, pattern, '')
				break
			end
		end
	  
		if raid then 
			break;
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

   local gs = ' ';

   -- Search for a gearscore requirement.
   for _, pattern in pairs(gearscore_patterns) do
      local gs_start, gs_end = string.find(message, pattern)

	  -- If a gs requirement was found, then save it and continue.
      if gs_start and gs_end then
         gs = string.sub(message, gs_start, gs_end)
		 gs = string.gsub(gs, '[%s]*%+?', ''); -- Trim whitespace
		 gs = string.gsub(gs, 'k', '')
		 gs = string.gsub(gs, ',', '.');
		 gs = tonumber(gs);
		 
		 -- Convert ex: 5800 into 5.8 for display
		 if gs > 1000 then
		    gs = gs/1000;
		 end

		 gs = string.format('%.1f', gs);
         break
	  end
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