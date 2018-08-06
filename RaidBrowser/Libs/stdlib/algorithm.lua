-- STD is a small lua rendition of the C++ standard template library.
-- algorithm.lua aims to provide similar functonality to that of <algorithm>

if not std then std = {} end;
std.algorithm = {};

-- Returns the (i, v) pair max of the given table
function std.algorithm.max_of(t)
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
function std.algorithm.transform(values, fn)
	local t = {}
	 
	for _, v in ipairs(values) do
		local result = fn(v);
		table.insert(t, result)
	end
	 
	return t;
end

-- Count the number of values that match the given predicate "pred".
-- t is a table of values to count
function std.algorithm.count_if(t, pred)
	local count = 0;
	for _, v in ipairs(t) do
		if pred(v) then 
			count = count + 1;
		end
	end
	
	return count;
end

-- Count the number of values in a table "t" that match the given value "value".
-- t is a table, value is possible value contained in the table "t".
function std.algorithm.count(t, value)
	return std.algorithm.count_if(t, function(v) 
		return v == value 
	end);
end

function std.algorithm.find_if(t, pred)
	for i, v in ipairs(t) do
		if pred(v) then
			return i;
		end
	end
	
	return nil
end

function std.algorithm.find(t, value)
	return std.algorithm.find_if(t, function(v)
		return v == value;
	end);
end

-- Create a copy of the given table "source"
-- Note: This is the functional equivalent of a function that would take source and target tables as arguments.
-- Returns a copy of the given table.
function std.algorithm.copy(source)
	local target = {};
	
	for k, v in pairs(source) do
		target[k] = v;
	end
	
	return target;
end

function std.algorithm.equal(first, second)
	if #first ~= #second then 
		return false;
	end
	
	for i, v in ipairs(first) do
		if v ~= second[i] then
			return false;
		end
	end
	
	return true;
end

function std.algorithm.copy_back(target, source)
	for _, v in ipairs(source) do
		table.insert(target, v);
	end
	
	return target;
end

