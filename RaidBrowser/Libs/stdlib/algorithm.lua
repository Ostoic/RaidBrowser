-- STD is a small lua rendition of the C++ standard template library.
-- algorithm.lua aims to provide similar functonality to that of <algorithm>

if not std then std = {} end;
std.algorithm = {};

function std.algorithm.identity(x)
	return x;
end

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

-- Given a table of values and a function, return the transformed table
function std.algorithm.transform_if(values, fn, pred)
	local t = {}
	 
	for _, v in ipairs(values) do
		local result = fn(v);
		if pred(result) then
			table.insert(t, result)
		end
	end
	 
	return t;
end

-- Given a table of values, and a function, return a table of the transformed table
function std.algorithm.transform(values, fn)
	return std.algorithm.transform_if(values, fn, function(i) return true end);
end

function std.algorithm.filter(values, pred)
	return std.algorithm.transform_if(values, std.algorithm.identity, pred);
end

function std.algorithm.generate_n(n, gen)
	local t = {};
	
	for i = 1, n do 
		table.insert(t, gen(i));
	end
	
	return t;
end

function std.algorithm.fold(values, init, fn)
	for i, v in ipairs(values) do
		init = fn(init, v);
	end
	
	return init;
end

std.algorithm.foldl = std.algorithm.fold;
std.algorithm.accumulate = std.algorithm.fold;

function std.algorithm.foldr(values, init, fn)
	for i, v in ipairs(values) do
		init = fn(v, init);
	end
	
	return init;
end

local function count_if_iterator(it, pred)
	local count = 0;
	
	for x in it do
		if pred(x) then
			count = count + 1;
		end
	end
	
	return count;
end

local function count_if_table(t, pred)
	local count = 0;
	for _, v in ipairs(t) do
		if pred(v) then 
			count = count + 1;
		end
	end
	
	return count;
end

-- Count the number of values that match the given predicate "pred".
-- t is a table of values to count
function std.algorithm.count_if(t, pred)
	-- type dispatch
	if type(t) == 'table' then 
		return count_if_table(t, pred);
	elseif type(t) == 'function' then
		return count_if_iterator(t, pred);
	end
end

-- Count the number of values in a table "t" that match the given value "value".
-- t is a table, value is possible value contained in the table "t".
function std.algorithm.count(t, value)
	return std.algorithm.count_if(t, function(v) 
		return v == value 
	end);
end

local function find_if_table(t, pred)
	for i, v in ipairs(t) do
		if pred(v) then
			return i;
		end
	end
	
	return nil
end

local function find_if_iterator(it, pred)
	for v in it do
		if pred(v) then
			return it; -- return the iterator?
		end
	end
	
	return nil
end

function std.algorithm.find_if(t, pred)
	
	-- type dispatch
	if type(t) == 'table' then 
		return find_if_table(t, pred);
		
	elseif type(t) == 'function' then
		return find_if_iterator(t, pred);
	end
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

local function copy_n_iterator(it, n)
	local t = {};
	
	local i = 1;
	for v in it do
		if i > n then break end
		table.insert(t, v);
		i = i + 1;
	end
	
	return t;
end

local function copy_n_table(s, n)
	local t = {};
	
	for i = 1, n do
		table.insert(t, s[i]);
	end
	
	return t;
end

function std.algorithm.copy_n(t, n)

	if type(t) == 'table' then
		return copy_n_table(t, n);
		
	elseif type(t) == 'function' then
		return copy_n_iterator(t, n);
	end
	
	return nil;
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

-- Fills a table [first, last) with sequentially increasing values, starting with first, and ending with last - 1.
function std.algorithm.iota(first, last)
	local t = {};
	
	while first ~= last do
		table.insert(t, first);
		first = first + 1;
	end
	
	return t;
end

function std.algorithm.copy_back(target, source)
	for _, v in ipairs(source) do
		table.insert(target, v);
	end
	
	return target;
end