raid_browser.gui = {}

local search_button = LFRQueueFrameFindGroupButton
local join_button = LFRBrowseFrameInviteButton
local refresh_button = LFRBrowseFrameRefreshButton

local gs_list_column = LFRBrowseFrameColumnHeader2
local raid_list_column = LFRBrowseFrameColumnHeader3

gs_list_column:SetText('GS')
raid_list_column:SetText('Raid')

local function ask_for_invite()
	local raid = raid_browser.active_raids[LFRBrowseFrame.selectedName].raid;
	local message = raid_browser.stats.build_inv_string(raid);
	SendChatMessage(message, 'WHISPER', nil, LFRBrowseFrame.selectedName);
end

local function clear_highlights()
	for i = 1, NUM_LFR_LIST_BUTTONS do
		_G["LFRBrowseFrameListButton"..i]:UnlockHighlight();
	end	
end

join_button:SetText('Join')
join_button:SetScript('OnClick', ask_for_invite)

-- Setup tooltip and LFR button entry functionality.
for i = 1, NUM_LFR_LIST_BUTTONS do
	local button = _G["LFRBrowseFrameListButton"..i];
	button:SetScript("OnDoubleClick", ask_for_invite)
	button:SetScript("OnClick", 
		function(self) 
			LFRBrowseFrame.selectedName = self.unitName;
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

-- Hide unused dropdown menu
LFRBrowseFrameRaidDropDown:Hide()

search_button:SetText('Find Raid')
search_button:SetScript('OnClick', function() end)

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
	local roles = nil;
	local raid = nil;

	local count = 1;
	for n, raid_info in pairs(raid_browser.active_raids) do
		if count == index then
			name = n;
			raid = raid_info.raid;
			roles = raid_info.roles;
			gs = raid_info.gs;
			button.time = raid_info.time;
			button.message = raid_info.message;
			break;
		end

		count = count + 1;
	end
	
	-- Update LFR selected name
	button.unitName = name;

	-- Update button text with Name, GS, Raid, and role information
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
	  
	local numResults = table_length(raid_browser.active_raids)

	FauxScrollFrame_Update(LFRBrowseFrameListScrollFrame, numResults, NUM_LFR_LIST_BUTTONS, 16);

	local offset = FauxScrollFrame_GetOffset(LFRBrowseFrameListScrollFrame);

	clear_list();

	-- Update button information
	for i = 1, NUM_LFR_LIST_BUTTONS do
		local button = _G["LFRBrowseFrameListButton"..i];
		if ( i <= numResults ) then
			LFRBrowseFrameListButton_SetData(button, i + offset);
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
LFRBrowseFrameListButton_SetData = set_list_data
