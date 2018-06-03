local folder, file = ...
raid_browser = raid_browser or file;
raid_browser.gui = raid_browser.gui or {}

local search_button = LFRQueueFrameFindGroupButton
local join_button = LFRBrowseFrameInviteButton
local refresh_button = LFRBrowseFrameRefreshButton

local gs_list_column = LFRBrowseFrameColumnHeader2
local raid_list_column = LFRBrowseFrameColumnHeader3

gs_list_column:SetText('GS')
raid_list_column:SetText('Raid')

local function ask_for_invite()
   local message = 'inv ';
   local class = UnitClass("player");
   local spec = GetTalentTabInfo(GetActiveTalentGroup())
   local gs = GearScore_GetScore(UnitName('player'), 'player');
   
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
   _G["LFRBrowseFrameListButton"..i]:SetScript("OnDoubleClick", ask_for_invite)
   _G["LFRBrowseFrameListButton"..i]:SetScript("OnClick", 
      function(self) 
         LFRBrowseFrame.selectedName  = self.unitName;
         clear_highlights();
         self:LockHighlight();
         LFRBrowse_UpdateButtonStates();
      end
   );
end

LFRBrowseFrameRaidDropDown:Hide()

search_button:SetText('Find Raid')
search_button:SetScript('OnClick', function()
   end
)