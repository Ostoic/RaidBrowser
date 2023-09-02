local registry = {}
local frame = CreateFrame('Frame')

local function printf(...) print(format(...)) end

local function script_error(type, err)
	local name, line, msg = err:match('%[string (".-")%]:(%d+): (.*)')
	printf('%s error%s:\n %s', type, name and format(' in %s at line %d', name, line, msg) or '', err)
end

local function UnregisterOrphanedEvent(event)
	if not next(registry[event]) then
		registry[event] = nil
		frame:UnregisterEvent(event)
	end
end

local function OnEvent(...)
	local _, event = ...
	for listener, val in pairs(registry[event]) do
		-- try-catch
		local success, rv = pcall(listener[1], listener[2], select(2, ...))
		if rv then
			if not success then script_error('event callback', rv) end
		end
	end

	UnregisterOrphanedEvent(event)
end

frame:SetScript('OnEvent', OnEvent)

-- INTERFACE

---@param event string
---@param callback function
---@param userparam any|nil
---@return table
function RaidBrowser.add_event_listener(event, callback, userparam)
	assert(callback, 'invalid callback')
	if not registry[event] then
		registry[event] = {}
		frame:RegisterEvent(event)
	end

	local listener = { callback, userparam }
	registry[event][listener] = true
	return listener
end

---@param event string
---@param listener table
function RaidBrowser.remove_event_listener(event, listener)
	registry[event][listener] = nil
	UnregisterOrphanedEvent(event)
end
