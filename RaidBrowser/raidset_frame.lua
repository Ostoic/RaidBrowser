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

local function is_both_selected(option)
	return ('Both' == current_selection);
end

local function set_selection(selection)
	local text = '';
	
	if selection == 'Active' then
		text = 'Active';

	elseif selection == 'Both' then
		local spec1, gs1 = raid_browser.stats.get_raidset('Primary')
		local spec2, gs2 = raid_browser.stats.get_raidset('Secondary')
		

		if spec1 and gs1 then
			text = text .. gs1 .. ' ' .. spec1
		else
			text = text .. '-'
		end
		text = text .. ' / '
		if spec2 and gs2 then
			text = text .. gs2 .. ' ' .. spec2
		else
			text = text .. '-'
		end
		if not (spec1 or spec2) then
			text = 'Set any spec first';
		end
		
	else
		local spec, gs = raid_browser.stats.get_raidset(selection)
		if not spec then
			text = 'Open';
		elseif not gs then
			text = spec;
		else
			text = gs..' '..spec
		end
	end
	
	UIDropDownMenu_SetText(RaidBrowserRaidSetMenu, text)
	current_selection = selection;
end

local function on_active() 	
	set_selection('Active');
	raid_browser.stats.select_current_raidset('Active');
	raid_browser.check_button()
end

local function on_primary()	
	set_selection('Primary');
	raid_browser.stats.select_current_raidset('Primary');
	raid_browser.check_button()
end

local function on_secondary()
	set_selection('Secondary');
	raid_browser.stats.select_current_raidset('Secondary');
	raid_browser.check_button()
end

local function on_both()
	set_selection('Both');
	raid_browser.stats.select_current_raidset('Both');
	raid_browser.check_button()
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
	
	{ 
		text = "Both", 
		func = on_both, 
		checked = is_both_selected,
	}
}

-- Get the menu option text
local function get_option_active(option)
    local spec, gs = raid_browser.stats.active_spec(), GearScore_GetScore(UnitName('player'), 'player');
    return (option .. ': ' .. gs .. ' ' .. spec)
end

-- Get the menu option text
local function get_option_text(option)
	local spec, gs = raid_browser.stats.get_raidset(option);
	if not spec then
		return (option .. ': Open');
	end
	
	return (option .. ': ' .. gs .. ' ' .. spec);
end

-- Get the menu option texts
local function get_option_texts(option)
	local spec1, gs1 = raid_browser.stats.get_raidset('Primary');
	local spec2, gs2 = raid_browser.stats.get_raidset('Secondary');
	if not spec1 then
		return (option .. ': Open');
	end

	if not (spec1 or spec2) then
		return (option .. ': Set any spec first')
	elseif (spec1 and spec2) then
		return (option .. ': ' .. gs1 .. ' ' .. spec1 .. ' / ' .. gs2 .. ' ' .. spec2)
	elseif spec1 then
		return (option .. ': ' .. gs1 .. ' ' .. spec1 .. ' / ' .. '-')
	elseif spec2 then
		return (option .. ': ' .. '-' .. ' / ' .. gs2 .. ' ' .. spec2)
	end
	
	return (option .. ': ' .. gs1 .. ' ' .. spec1 .. ' / ' .. gs2 .. ' ' .. spec2);
end

-- Setup dropdown menu for the raidset selection
frame:SetPoint("CENTER", LFRBrowseFrame, "CENTER", 30, 165)
UIDropDownMenu_Initialize(frame, EasyMenu_Initialize, nil, nil, menu);

local function show_menu()
	menu[1].text = get_option_active('Active');
	menu[2].text = get_option_text('Primary');
	menu[3].text = get_option_text('Secondary');
	menu[4].text = get_option_texts('Both');
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

local function check_button(button)
    if is_active_selected() or is_both_selected() then
        button:Disable()
    else
        button:Enable()
    end
end

function raid_browser.check_button()
    if is_active_selected() or is_both_selected() then
        RaidBrowserRaidSetSaveButton:Disable()
        RaidBrowserRaidSetSaveButton:SetText("Select spec first")
        RaidBrowserRaidSetSaveButton:Hide()
    else
        RaidBrowserRaidSetSaveButton:Enable()
        RaidBrowserRaidSetSaveButton:SetText("Save gear+spec")
        RaidBrowserRaidSetSaveButton:Show()
    end
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
check_button(button);
