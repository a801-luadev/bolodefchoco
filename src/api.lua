math.randomseed(os.time())
local owners = {
	["Bolodefchoco#0000"] = true
}

local _TEAM = { _loaded = false }

system.looping = function(f, tick)
	local s = 1000 / tick
	local t = { }

	local bar = 0
	local fooTimer = function()
		bar = bar + 1
		t[bar] = system.newTimer(f, 1000, true)
	end

	for timer = 0, 1000 - s, s do
		system.newTimer(fooTimer, 1000 + timer, false)
	end
	return t
end

math.pythag = function(x1, y1, x2, y2, range)
	return (x1 - x2) ^ 2 + (y1 - y2) ^ 2 <= (range ^ 2)
end

math.clamp = function(value, min, max)
	return value < min and min or value > max and max or value
end

string.split = function(str, pat)
	local out, counter = { }, 0

	string.gsub(str, pat, function(value)
		counter = counter + 1
		out[counter] = tonumber(value) or value
	end)

	return out
end

string.nick = function(playerName)
	if not string.find(playerName, '#') then
		playerName = playerName .. "#0000"
	end

	return (string.gsub(string.lower(playerName), "%a", string.upper, 1))
end

string.trim = function(str)
	return (string.gsub(tostring(str), "^ *(.*) *$", "%1"))
end

ui.banner = function(image, aX, aY, n, time)
	time = time or 5
	aX = aX or 100
	aY = aY or 100

	local img = tfm.exec.addImage(image, "&0", aX, aY, n)
	system.newTimer(function()
		tfm.exec.removeImage(img)
	end, time * 1000, false)
end

local pairsByIndexes = function(list, f)
	local out = {}
	for index in next, list do
		out[#out + 1] = index
	end
	table.sort(out, f)

	local i = 0
	return function()
		i = i + 1
		if out[i] ~= nil then
			return out[i], list[out[i]]
		end
    end
end

table.remove = function(list, pos)
	local len, out = #list

	if not pos or pos == len then
		out = list[len]
		list[len] = nil
	elseif pos < len then
		out = list[pos]
		list[pos] = nil

		for i = pos, len do
			list[i] = list[i + 1]
		end
	end
	return out
end

table.random = function(tbl)
	return tbl[math.random(#tbl)]
end

local PLAYERDATA = { }

local modules, tribeModule = { }, { }