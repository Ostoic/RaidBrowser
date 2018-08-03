local registry = {}
local frame = CreateFrame('Frame')

local function printf(...) DEFAULT_CHAT_FRAME:AddMessage('|cff0061ff[RaidBrowser]: '..format(...)) end

local function script_error(type, err)
	local name, line, msg = err:match('%[string (".-")%]:(%d+): (.*)')
	printf( '%s error%s:\n %s', type,
			name and format(' in %s at line %d', name, line, msg) or '',
			err )
end

local function UnregisterOrphanedEvent(event)
	if not next(registry[event]) then
		registry[event] = nil
		frame:UnregisterEvent(event)
	end
end

local function OnEvent(...)
	local self, event = ...
	for listener,val in pairs(registry[event]) do
		local success, rv = pcall(listener[1], listener[2], select(2,...))
		if rv then
			registry[event][listener] = nil
			if not success then script_error('event callback', rv) end
		end
	end		  
	
	UnregisterOrphanedEvent(event)
end

frame:SetScript('OnEvent', OnEvent)

-- INTERFACE

function raid_browser.add_event_listener(event, callback, userparam)
	assert(callback, 'invalid callback')
	if not registry[event] then
		registry[event] = {}
		frame:RegisterEvent(event)
	end
	
	local listener = { callback, userparam }
	registry[event][listener] = true
	return listener
end

function raid_browser.remove_event_listener (event, listener)
	registry[event][listener] = nil
	UnregisterOrphanedEvent(event)
end
