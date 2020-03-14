raid_browser.gui = {}

local search_button = LFRQueueFrameFindGroupButton
local join_button = LFRBrowseFrameInviteButton
local refresh_button = LFRBrowseFrameRefreshButton

local name_column = LFRBrowseFrameColumnHeader1
local gs_list_column = LFRBrowseFrameColumnHeader2
local raid_list_column = LFRBrowseFrameColumnHeader3

gs_list_column:SetText('GS')
raid_list_column:SetText('Raid')

local function on_join()
	local raid_message = raid_browser.lfm_messages[LFRBrowseFrame.selectedName]
	
	if not raid_message then return end
	local raid_name = raid_message.raid_info.name;
	local message = raid_browser.stats.build_inv_string(raid_name);
	SendChatMessage(message, 'WHISPER', nil, LFRBrowseFrame.selectedName);
end

local function clear_highlights()
	for i = 1, NUM_LFR_LIST_BUTTONS do
		_G["LFRBrowseFrameListButton"..i]:UnlockHighlight();
	end	
end

join_button:SetText('Join')
join_button:SetScript('OnClick', on_join)

local function format_count(value)
   if value == 1 then
      return ' ';
   end
   
   return 's ' ;
end

local function format_seconds(seconds)
   local seconds = tonumber(seconds)
   
   if seconds <= 0 then
      return "00 seconds";
   end
   
   local days_text = '';
   local hours_text = '';
   local mins_text = '';
   local seconds_text = '';
   
   if seconds >= 86400 then
      local days = math.floor(seconds / 86400);
      days_text = days .. ' day' .. format_count(days);
      seconds = seconds % 86400;
   end
   
   if seconds >= 3600 then
      local hours = math.floor(seconds / 3600) ;
      hours_text = hours .. ' hr' .. format_count(hours);
      seconds = seconds % 3600;
   end
   
   if seconds >= 60 then 
      local minutes = math.floor(seconds / 60) ;
      minutes_text = minutes .. ' min' .. format_count(minutes);
   end
   
   return days_text .. hours_text .. minutes_text;
end

-- Setup tooltip and LFR button entry functionality.
for i = 1, NUM_LFR_LIST_BUTTONS do
	local button = _G["LFRBrowseFrameListButton"..i];
	button:SetScript("OnDoubleClick", on_join)
	button:SetScript("OnClick", 
		function(button) 
			LFRBrowseFrame.selectedName = button.unitName;
			clear_highlights();
			button:LockHighlight();
			LFRBrowse_UpdateButtonStates();
		end
	);
	
	-- Todo: This causes heavy lag for some reason
	button:SetScript('OnEnter', 
		function(button)
			GameTooltip:SetOwner(button, 'ANCHOR_RIGHT');
			
			local seconds = time() - button.lfm_info.time;
			local last_sent = string.format('Last sent: %d seconds ago', seconds);
			GameTooltip:AddLine(button.lfm_info.message, 1, 1, 1, true);
			GameTooltip:AddLine(last_sent);
			
			if button.raid_locked then
				GameTooltip:AddLine('\nYou are |cffff0000saved|cffffd100 for ' .. button.raid_info.name);
				local _, reset_time = raid_browser.stats.raid_lock_info(button.raid_info.instance_name, button.raid_info.size)
				GameTooltip:AddLine('Lockout expires in ' .. format_seconds(reset_time));
			else
				GameTooltip:AddLine('\nYou are |cff00ffffnot saved|cffffd100 for ' .. button.raid_info.name);
			end
			
			GameTooltip:Show();
		end
	)
	
	button:SetScript('OnLeave', 
		function(self)
			GameTooltip:Hide();
		end
	)
end

-- Hide unused dropdown menu
LFRBrowseFrameRaidDropDown:Hide()

search_button:SetText('Find Raid')
search_button:SetScript('OnClick', function() end)

local function clear_highlights()
	for i = 1, NUM_LFR_LIST_BUTTONS do
		_G["LFRBrowseFrameListButton"..i]:UnlockHighlight();
	end	
end


-- Assignment operator for LFR buttons
local function assign_lfr_button(button, host_name, lfm_info, index)
	local offset = FauxScrollFrame_GetOffset(LFRBrowseFrameListScrollFrame);
	button.index = index;
	index = index - offset;

	button.lfm_info = lfm_info;
	button.raid_info = lfm_info.raid_info;
	
	-- Update selected LFR raid host name
	button.unitName = host_name;

	-- Update button text with raid host name , GS, Raid, and role information
	button.name:SetText(host_name);
	button.level:SetText(button.lfm_info.gs); -- Previously level, now GS

	-- Raid name
	button.class:SetText(button.raid_info.name); 

	button.raid_locked = raid_browser.stats.raid_lock_info(button.raid_info.instance_name, button.raid_info.size);
	button.type = "party";

	button.partyIcon:Show();

	button.tankIcon:Hide();
	button.healerIcon:Hide();
	button.damageIcon:Hide();
	
	-- Get all the roles from the lfm info table
	for _, role in pairs(button.lfm_info.roles) do 
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

	-- If the raid is saved, then color the raid text in the list as red
	if button.raid_locked then
		button.class:SetTextColor(1, 0, 0);
	else
		button.class:SetTextColor(0, 1, 1);
	end;
	
	-- Set up the corresponding textures for the roles columns
	button.tankIcon:SetTexture("Interface\\LFGFrame\\LFGRole");
	button.healerIcon:SetTexture("Interface\\LFGFrame\\LFGRole");
	button.damageIcon:SetTexture("Interface\\LFGFrame\\LFGRole");
	button.partyIcon:SetTexture("Interface\\LFGFrame\\LFGRole");
end

local function insert_lfm_button(button, index)
	local host_name = nil;
	local count = 1;
	
	for n, lfm_info in pairs(raid_browser.lfm_messages) do
		if count == index then
			assign_lfr_button(button, n, lfm_info, index);
			break;
		end

		count = count + 1;
	end
	
end

local function update_buttons()
	local playerName = UnitName("player");
	local selectedName = LFRBrowseFrame.selectedName;

	LFRBrowseFrameSendMessageButton:Enable();
	LFRBrowseFrameInviteButton:Enable();
end

local function clear_list()
	for i = 1, NUM_LFR_LIST_BUTTONS do
		local button = _G["LFRBrowseFrameListButton"..i];
		button:Hide();
		button:UnlockHighlight();
	end
end

local function table_length(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end

function raid_browser.gui.update_list()
	LFRBrowseFrameRefreshButton.timeUntilNextRefresh = LFR_BROWSE_AUTO_REFRESH_TIME;
	  
	local numResults = table_length(raid_browser.lfm_messages)

	FauxScrollFrame_Update(LFRBrowseFrameListScrollFrame, numResults, NUM_LFR_LIST_BUTTONS, 16);

	local offset = FauxScrollFrame_GetOffset(LFRBrowseFrameListScrollFrame);

	clear_list();

	-- Update button information
	for i = 1, NUM_LFR_LIST_BUTTONS do
		local button = _G["LFRBrowseFrameListButton"..i];
		if ( i <= numResults ) then
			insert_lfm_button(button, i + offset);
			button:Show();
		else
			button:Hide();
		end
	end

	clear_highlights();

	-- Update button highlights
	for i = 1, NUM_LFR_LIST_BUTTONS do
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
LFRBrowseFrameListButton_SetData = insert_lfm_button

-- Set the "Browse" tab to be active.
LFRFrame_SetActiveTab(2)

LFRParentFrameTab1:Hide();
LFRParentFrameTab2:Hide();