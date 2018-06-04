local folder, addon = ...
raid_browser = raid_browser or addon;
raid_browser.gui = raid_browser.gui or {}

local function printf(...) DEFAULT_CHAT_FRAME:AddMessage('|cff0061ff[RaidBrowser]: '..format(...)) end

local search_button = LFRQueueFrameFindGroupButton
local join_button = LFRBrowseFrameInviteButton
local refresh_button = LFRBrowseFrameRefreshButton

local gs_list_column = LFRBrowseFrameColumnHeader2
local raid_list_column = LFRBrowseFrameColumnHeader3

gs_list_column:SetText('GS')
raid_list_column:SetText('Raid')

local function get_active_spec()
	local index = 1;
	local _, _, points = GetTalentTabInfo(index);
	for i = 2, 3 do
		local _, _, p = GetTalentTabInfo(i);
		if (p > points) then
			index = i;
		end
	end
	
	return GetTalentTabInfo(index)
end

local function ask_for_invite()
	local message = 'inv ';
	local class = UnitClass("player");
	local gs = GearScore_GetScore(UnitName('player'), 'player');
	local spec = get_active_spec();

	message =  message .. gs .. 'gs ' .. spec .. ' ' .. class
	SendChatMessage(message, 'WHISPER', nil, LFRBrowseFrame.selectedName);
end

local function clear_highlights()
   for i=1, NUM_LFR_LIST_BUTTONS do
      _G["LFRBrowseFrameListButton"..i]:UnlockHighlight();
   end   
end

join_button:SetText('Join')
join_button:SetScript('OnClick', ask_for_invite)

for i=1, NUM_LFR_LIST_BUTTONS do
   local button = _G["LFRBrowseFrameListButton"..i];
   button:SetScript("OnDoubleClick", ask_for_invite)
   button:SetScript("OnClick", 
      function(self) 
         LFRBrowseFrame.selectedName  = self.unitName;
         clear_highlights();
         self:LockHighlight();
         LFRBrowse_UpdateButtonStates();
      end
   );
   
   button:SetScript('OnEnter', 
      function(self)
         GameTooltip:SetOwner(self, 'ANCHOR_RIGHT');
         
         local message = self.message;
         local seconds = time() - self.time;
         local last_sent = string.format('Last sent: %d seconds ago', seconds);
         GameTooltip:AddLine(message, 1, 1, 1, true);
         GameTooltip:AddLine(last_sent);
         GameTooltip:Show();
      end
   )
   
   button:SetScript('OnLeave', 
      function(self)
         GameTooltip:Hide();
      end
   )
end
LFRBrowseFrameRaidDropDown:Hide()

search_button:SetText('Find Raid')
search_button:SetScript('OnClick', function()
   end
)