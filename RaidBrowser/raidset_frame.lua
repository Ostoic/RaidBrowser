raid_browser.gui.raidset = {};

local frame = CreateFrame("Frame", "RaidBrowserRaidSetMenu", LFRBrowseFrame, "UIDropDownMenuTemplate")
UIDropDownMenu_SetWidth(RaidBrowserRaidSetMenu, 150)
frame:SetWidth(90);

local current_selection = nil;

local function is_active_selected(option)
	return ('Active' == current_selection);
end

local function is_primary_selected(option)
	return ('Primary' == current_selection);
end

local function is_secondary_selected(option)
	return ('Secondary' == current_selection);
end

local function set_selection(selection)
	local text = '';
	
	if selection == 'Active' then
		text = 'Active';
	else
		local spec, gs = raid_browser.stats.get_raidset(selection)
		if not spec then
			text = 'Open';
		elseif not gs then
			text = spec;
		end
	end
	
	UIDropDownMenu_SetText(RaidBrowserRaidSetMenu, text)
	current_selection = selection;
end

local function on_active() 	
	set_selection('Active');
	raid_browser.stats.select_current_raidset('Active');
end

local function on_primary()	
	set_selection('Primary');
	raid_browser.stats.select_current_raidset('Primary');
end

local function on_secondary()
	set_selection('Secondary');
	raid_browser.stats.select_current_raidset('Secondary');
end

local menu = {
	{ 
		text = 'Active',
		func = on_active,
		checked = is_active_selected,
	},
	
	{ 
		text = "Primary", 
		func = on_primary,
		checked = is_primary_selected,
	},
	
	{ 
		text = "Secondary", 
		func = on_secondary, 
		checked = is_secondary_selected,
	},
}

-- Get the menu option text
local function get_option_text(option)
	local spec = raid_browser.stats.get_raidset(option);
	if not spec then
		return (option .. ': Open');
	end
	
	return (option .. ': ' .. spec);
end

-- Setup dropdown menu for the raidset selection
frame:SetPoint("CENTER", LFRBrowseFrame, "CENTER", 30, 165)
UIDropDownMenu_Initialize(frame, EasyMenu_Initialize, nil, nil, menu);

local function show_menu()
	menu[2].text = get_option_text('Primary');
	menu[3].text = get_option_text('Secondary');
	ToggleDropDownMenu(1, nil, frame, frame, 25, 10, menu);	 
end

RaidBrowserRaidSetMenuButton:SetScript('OnClick', show_menu)

local function on_raidset_save()
	if current_selection == 'Primary' then
		raid_browser.stats.save_primary_raidset();
		
	elseif current_selection == 'Secondary' then
		raid_browser.stats.save_secondary_raidset();
	end
	
	local spec, gs = raid_browser.stats.current_raidset();
	raid_browser:Print('Raidset saved: ' .. spec .. ' ' .. gs .. 'gs');
	set_selection(current_selection);
end

function raid_browser.gui.raidset.initialize()
	set_selection(raid_browser_character_current_raidset);
end

-- Create raidset save button
local button = CreateFrame("BUTTON","RaidBrowserRaidSetSaveButton", LFRBrowseFrame, "OptionsButtonTemplate")
button:SetPoint("CENTER", LFRBrowseFrame, "CENTER", -53, 168)
button:EnableMouse(true)
button:RegisterForClicks("AnyUp")

button:SetText("Save Raid Gear");
button:SetWidth(110);
button:SetScript("OnClick", on_raidset_save);
button:Show();

