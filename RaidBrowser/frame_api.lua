local folder, addon = ...
raid_browser = raid_browser or addon;

local function printf(...) DEFAULT_CHAT_FRAME:AddMessage('|cff0061ff[RaidBrowser]: '..format(...)) end

local function clear_highlights()
   for i=1, NUM_LFR_LIST_BUTTONS do
      _G["LFRBrowseFrameListButton"..i]:UnlockHighlight();
   end   
end

local function set_list_data(button, index)
   local offset = FauxScrollFrame_GetOffset(LFRBrowseFrameListScrollFrame);
   
   button.index = index;
   index = index - offset;
   
   local name = nil;
   local gs = nil;
   local raid = nil;
   local roles = nil;
   
   local count = 1;
   for n, raid_info in pairs(raid_browser.active_raids) do
      if count == index then
         name = n;
         raid = raid_info[1];
         roles = raid_info[2];
         gs = raid_info[3];
		 button.time = raid_info[4];
         button.message = raid_info[5];
         break;
      end
      
      count = count + 1;
   end
   
   -- Update LFR selected name
   button.unitName = name;
   
   button.name:SetText(name); -- Name
   button.level:SetText(gs); -- Previously level, now GS
   
   button.class:SetText(raid); -- Raid
   
   button.type = "party";
   
   button.partyIcon:Show();
   
   button.tankIcon:Hide();
   button.healerIcon:Hide();
   button.damageIcon:Hide();
   for _, role in pairs(roles) do 
      if role == 'tank' then
         button.tankIcon:Show()
      end
      
      if role == 'healer' then
         button.healerIcon:Show();
      end
      
      if role == 'melee_dps' or role == 'ranged_dps' or role == 'dps' then
         button.damageIcon:Show();
      end
   end
   
   button:Enable();
   button.name:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
   button.level:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
   
   button.class:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
   
   button.tankIcon:SetTexture("Interface\\LFGFrame\\LFGRole");
   button.healerIcon:SetTexture("Interface\\LFGFrame\\LFGRole");
   button.damageIcon:SetTexture("Interface\\LFGFrame\\LFGRole");
   button.partyIcon:SetTexture("Interface\\LFGFrame\\LFGRole");
end

local function update_buttons()
   local playerName = UnitName("player");
   local selectedName = LFRBrowseFrame.selectedName;
   
   if ( selectedName and selectedName ~= playerName ) then
      LFRBrowseFrameSendMessageButton:Enable();
      LFRBrowseFrameInviteButton:Enable();
   else
      LFRBrowseFrameSendMessageButton:Disable();
      LFRBrowseFrameInviteButton:Disable();
   end
end

local function clear_list()
   for i = 1, NUM_LFR_LIST_BUTTONS do
      local button = _G["LFRBrowseFrameListButton"..i];
      button:Hide();
      button:UnlockHighlight();
   end
end

function raid_browser.gui.update_list()
   LFRBrowseFrameRefreshButton.timeUntilNextRefresh = LFR_BROWSE_AUTO_REFRESH_TIME;
      
   local function tablelength(T)
      local count = 0
      for _ in pairs(T) do count = count + 1 end
      return count
   end
   
   local numResults = tablelength(raid_browser.active_raids)
   
   FauxScrollFrame_Update(LFRBrowseFrameListScrollFrame, numResults, NUM_LFR_LIST_BUTTONS, 16);
   
   local offset = FauxScrollFrame_GetOffset(LFRBrowseFrameListScrollFrame);
   
   clear_list();
   
   for i=1, NUM_LFR_LIST_BUTTONS do
      local button = _G["LFRBrowseFrameListButton"..i];
      if ( i <= numResults ) then
         LFRBrowseFrameListButton_SetData(button, i + offset);
         button:Show();
      else
         button:Hide();
      end
   end
   
   clear_highlights();
   
   for i=1, NUM_LFR_LIST_BUTTONS do
      local button = _G["LFRBrowseFrameListButton"..i];
      if ( LFRBrowseFrame.selectedName == button.unitName ) then
         button:LockHighlight();
      else
         button:UnlockHighlight();
      end
      
      update_buttons();
   end
end

-- Setup LFR browser hooks
LFRBrowse_UpdateButtonStates = update_buttons
LFRBrowseFrameList_Update = raid_browser.gui.update_list
LFRBrowseFrameListButton_SetData = set_list_data
