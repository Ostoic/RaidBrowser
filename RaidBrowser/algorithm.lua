raid_browser.algorithm = {};

-- Returns the (i, v) pair max of the given table
function raid_browser.algorithm.max_of(t)
	local result = -math.huge;
	local index = 1;
	 
	for i, v in ipairs(t) do
		if v and v > result then
			result = v;
			index = i;
		end
	end
	 
	return index, result;
end

-- Given a table of values, and a function, return a table of the transformed table
function raid_browser.algorithm.transform(values, fn)
	local t = {}
	 
	for _, v in ipairs(values) do
		local result = fn(v);
		table.insert(t, result)
	end
	 
	return t;
end