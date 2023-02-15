---@diagnostic disable: undefined-field
RaidBrowser.gui = {}

local search_button = LFRQueueFrameFindGroupButton
local join_button = LFRBrowseFrameInviteButton

local name_column = LFRBrowseFrameColumnHeader1
local gs_list_column = LFRBrowseFrameColumnHeader2
local raid_list_column = LFRBrowseFrameColumnHeader3

local sort_column
local sort_ascending = false

---Order by ascending or descending based on module variable sort_ascending.
---@param a any
---@param b any
---@return boolean
---@nodiscard
local function compare(a, b)
	if sort_ascending then
		return a > b
	else
		return a < b
	end
end

---@param a table
---@param b table
---@return boolean
---@nodiscard
local sort_function = function(a, b)
	if sort_column == "name" then
		return compare(a.sender, b.sender)
	elseif sort_column == "gs" then
		return compare(a.gs, b.gs)
	elseif sort_column == "raid" then
		return compare(a.raid_info.name, b.raid_info.name)
	else
		return compare(a.time, b.time)
	end
end

---@param column string
local function set_sort(column)
	if sort_column == column then
		sort_ascending = not sort_ascending
	else
		sort_column = column
	end

	if RaidBrowser.gui then
		RaidBrowser.gui.update_list()
	end
end


---@param column string
function RaidBrowser.set_sort(column)
	set_sort(column)
end

---@return table
---@nodiscard
local function get_sorted_messages()
	local keys = {}
	for _, info in pairs(RaidBrowser.lfm_messages) do
		table.insert(keys, info)
	end

	table.sort(keys, sort_function)
	return keys
end

name_column:SetScript('OnClick', function() set_sort('name') end)
gs_list_column:SetText('GS')
gs_list_column:SetScript('OnClick', function() set_sort('gs') end)
raid_list_column:SetText('Raid')
raid_list_column:SetScript('OnClick', function() set_sort('raid') end)

local function on_join()
	local raid_message = RaidBrowser.lfm_messages[LFRBrowseFrame.selectedName]

	if not raid_message then return end
	local raid_name = raid_message.raid_info.name
	local message = RaidBrowser.stats.build_join_message(raid_name)
	--print(LFRBrowseFrame.selectedName.." -> "..message)
	SendChatMessage(message, 'WHISPER', nil, LFRBrowseFrame.selectedName)
end

join_button:SetText('Join')
join_button:SetScript('OnClick', on_join)

---@param value integer
---@return string
---@nodiscard
local function format_count(value)
	if value == 1 then
		return ' '
	end

	return 's '
end

---@param seconds string
---@return string
---@nodiscard
local function format_seconds(seconds)
	local num_seconds = tonumber(seconds)

	if num_seconds <= 0 then
		return "00 seconds"
	end

	local days_text = ''
	local hours_text = ''
	local minutes_text = ''

	if num_seconds >= 86400 then
		local days = math.floor(num_seconds / 86400)
		days_text = days .. ' day' .. format_count(days)
		num_seconds = num_seconds % 86400
	end

	if num_seconds >= 3600 then
		local hours = math.floor(num_seconds / 3600)
		hours_text = hours .. ' hr' .. format_count(hours)
		num_seconds = num_seconds % 3600
	end

	if num_seconds >= 60 then
		local minutes = math.floor(num_seconds / 60)
		minutes_text = minutes .. ' min' .. format_count(minutes)
	end

	return days_text .. hours_text .. minutes_text
end

-- Hide unused dropdown menu
LFRBrowseFrameRaidDropDown:Hide()

search_button:SetText('Find Raid')
search_button:SetScript('OnClick', function()
end)

local function clear_highlights()
	for i = 1, NUM_LFR_LIST_BUTTONS do
		_G["LFRBrowseFrameListButton" .. i]:UnlockHighlight()
	end
end

-- Assignment operator for LFR buttons
---@param button Button
---@param host_name string
---@param lfm_info any
---@param index integer
local function assign_lfr_button(button, host_name, lfm_info, index)
	local offset = FauxScrollFrame_GetOffset(LFRBrowseFrameListScrollFrame)
	button.index = index
	index = index - offset

	button.lfm_info = lfm_info
	button.raid_info = lfm_info.raid_info

	-- Update selected LFR raid host name
	button.unitName = host_name

	-- Update button text with raid host name , GS, Raid, and role information
	button.name:SetText(host_name)
	button.level:SetText(button.lfm_info.gs); -- Previously level, now GS

	-- Raid name
	button.class:SetText(button.raid_info.name)

	button.raid_locked, button.raid_reset_time = RaidBrowser.stats.raid_lock_info(button.raid_info)
	button.type = "party"

	button.partyIcon:Show()

	button.tankIcon:Hide()
	button.healerIcon:Hide()
	button.damageIcon:Hide()

	-- Get all the roles from the lfm info table
	for _, role in pairs(button.lfm_info.roles) do
		if role == 'tank' then
			button.tankIcon:Show()
		end

		if role == 'healer' then
			button.healerIcon:Show()
		end

		if role == 'melee_dps' or role == 'ranged_dps' or role == 'dps' then
			button.damageIcon:Show()
		end
	end

	button:Enable()
	button.name:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
	button.level:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)

	-- If the raid is saved, then color the raid text in the list as red
	if button.raid_locked then
		button.class:SetTextColor(1, 0, 0)
	else
		button.class:SetTextColor(0, 1, 1)
	end

	-- Set up the corresponding textures for the roles columns
	button.tankIcon:SetTexture("Interface\\LFGFrame\\LFGRole")
	button.healerIcon:SetTexture("Interface\\LFGFrame\\LFGRole")
	button.damageIcon:SetTexture("Interface\\LFGFrame\\LFGRole")
	button.partyIcon:SetTexture("Interface\\LFGFrame\\LFGRole")

	button:SetScript('OnEnter',
		function(lfr_button)
			GameTooltip:SetOwner(lfr_button, 'ANCHOR_RIGHT')

			local seconds = time() - lfr_button.lfm_info.time
			local last_sent = string.format('Last sent: %d seconds ago', seconds)
			GameTooltip:AddLine(lfr_button.lfm_info.message, 1, 1, 1, true)
			GameTooltip:AddLine(last_sent)

			if lfr_button.raid_locked then
				GameTooltip:AddLine('\nYou are |cffff0000saved|cffffd100 for ' .. lfr_button.raid_info.name)
				GameTooltip:AddLine('Lockout expires in ' .. format_seconds(lfr_button.raid_reset_time))
			else
				GameTooltip:AddLine('\nYou are |cff00ffffnot saved|cffffd100 for ' .. lfr_button.raid_info.name)
			end

			GameTooltip:Show()
		end
	)

	button:SetScript('OnLeave',
		function(_)
			GameTooltip:Hide()
		end
	)
end

---@param button Button
---@param index integer
local function insert_lfm_button(button, index)
	local count = 1

	local sortedMessages = get_sorted_messages()

	for _, lfm_info in pairs(sortedMessages) do
		if count == index then
			assign_lfr_button(button, lfm_info.sender, lfm_info, index)
			break
		end

		count = count + 1
	end
end

local function update_buttons()
	LFRBrowseFrameSendMessageButton:Enable()
	LFRBrowseFrameInviteButton:Enable()
end

local function clear_list()
	for i = 1, NUM_LFR_LIST_BUTTONS do
		local button = _G["LFRBrowseFrameListButton" .. i]
		button:Hide()
		button:UnlockHighlight()
	end
end

---@param t table
---@return integer
local function table_length(t)
	local count = 0
	for _ in pairs(t) do count = count + 1 end
	return count
end

function RaidBrowser.gui.update_list()
	LFRBrowseFrameRefreshButton.timeUntilNextRefresh = LFR_BROWSE_AUTO_REFRESH_TIME

	local numResults = table_length(RaidBrowser.lfm_messages)
	FauxScrollFrame_Update(LFRBrowseFrameListScrollFrame, numResults, NUM_LFR_LIST_BUTTONS, 16)

	local offset = FauxScrollFrame_GetOffset(LFRBrowseFrameListScrollFrame)
	clear_list()

	-- Update button information
	for i = 1, NUM_LFR_LIST_BUTTONS do
		local button = _G["LFRBrowseFrameListButton" .. i]
		if (i <= numResults) then
			insert_lfm_button(button, i + offset)
			button:Show()
		else
			button:Hide()
		end
	end

	clear_highlights()

	-- Update button highlights
	for i = 1, NUM_LFR_LIST_BUTTONS do
		local button = _G["LFRBrowseFrameListButton" .. i]
		if (LFRBrowseFrame.selectedName == button.unitName) then
			button:LockHighlight()
		else
			button:UnlockHighlight()
		end

		update_buttons()
	end
end

-- Setup LFR browser hooks
LFRBrowse_UpdateButtonStates = update_buttons
LFRBrowseFrameList_Update = RaidBrowser.gui.update_list
LFRBrowseFrameListButton_SetData = insert_lfm_button

-- Set the "Browse" tab to be active.
LFRFrame_SetActiveTab(2)

LFRParentFrameTab1:Hide()
LFRParentFrameTab2:Hide()
