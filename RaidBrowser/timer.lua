local function printf(...) DEFAULT_CHAT_FRAME:AddMessage('|cff0061ff[RaidBrowser]: ' .. format(...)) end

local function script_error(type, err)
	local name, line, msg = err:match('%[string (".-")%]:(%d+): (.*)')
	printf('%s error%s:\n %s',
		type,
		name and format(' in %s at line %d', name, line, msg) or '',
		err
	)
end

local timers = {}

function RaidBrowser.set_timer(interval, callback, recur, ...)
	local timer = {
		interval = interval,
		callback = callback,
		recur = recur,
		update = 0,
		...
	}
	timers[timer] = timer
	return timer
end

function RaidBrowser.kill_timer(timer)
	timers[timer] = nil
end

-- How often to check timers. Lower values are more CPU intensive.
local granularity = 0.1

local totalElapsed = 0

---@param self any
---@param elapsed integer
---@diagnostic disable-next-line: unused-local
local function OnUpdate(self, elapsed)
	totalElapsed = totalElapsed + elapsed

	if totalElapsed > granularity then
		for _, t in pairs(timers) do
			t.update = t.update + totalElapsed

			if t.update > t.interval then
				---@diagnostic disable-next-line: deprecated
				local success, rv = pcall(t.callback, unpack(t))

				if not rv and t.recur then
					t.update = 0
				else
					timers[t] = nil
					if not success then script_error('timer callback', rv) end
				end
			end
		end
		totalElapsed = 0
	end
end

CreateFrame('Frame'):SetScript('OnUpdate', OnUpdate)
