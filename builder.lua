string.split = function(str, pat)
	local out, counter = { }, 0

	string.gsub(str, pat, function(value)
		counter = counter + 1
		out[counter] = tonumber(value) or value
	end)

	return out
end

local insertTabInEveryLine = function(str, tabs)
	tabs = string.rep("\t", tabs)

	str = string.split(str, "([^\n]*)\n?")
	for i = 1, #str do
		str[i] = tabs .. str[i]
	end

	return table.concat(str, "\n")
end

local readFile = function(fileName)
	local file = io.open(fileName, 'r')
	local content = file:read("*a")
	file:close()
	return content
end

local modeMetaInfo = { }

local getMode = function(path, src, srcName, notOptimize)
	local file, module, package

	package = readFile(path .. "package.lua")
	module = readFile(path .. "module.lua")

	local name = load("return " .. package)().name
	if not notOptimize then
		module = string.format("\t%s[%q] = (modeName == %q) and function()\n%s\n\tend", srcName, name, name, insertTabInEveryLine(module, 2))
	else
		module = string.format("\t%s[%q] = function()\n%s\n\tend", srcName, name, insertTabInEveryLine(module, 2))
	end

	modeMetaInfo[#modeMetaInfo + 1] = insertTabInEveryLine(string.format("[%q] = %s", name, package), 1) .. ","

	if src then
		src[#src + 1] = module
	else
		return module
	end
end

local getModes = function(folder, ...)
	local file = io.popen("ls \"src/" .. folder .. "\"")
	local list = string.split(file:read("*a"), "[^\r\n]+")
	file:close()

	local path = "src/" .. folder .. "/"
	local src = { }

	for i = 1, #list do
		if list[i] ~= "main" then
			i = path .. list[i] .. "/"

			getMode(i, src, ...)
		end
	end

	return table.concat(src, "\n\n")
end

----------------------------------------------

local main = getMode("src/roomModes/main/", nil, "modules", true)

local modules = getModes("roomModes", "modules")
local tribeModule = getModes("tribeModes", "tribeModule")
modeMetaInfo = "{\n" .. table.concat(modeMetaInfo, "\n") .. "\n}"

local modes = string.format([=[local modeMetaInfo = %s

do -- Main
%s
end

local roomModes = function(modeName)
%s
end

local tribeModes = function(modeName)
%s
end]=], modeMetaInfo, main, modules, tribeModule)

----------------------------------------------

local api = readFile("src/api.lua")
local wrapper = readFile("src/wrapper.lua")

local module = string.format([=[--[[ API ]]--
%s

--[[ Modes ]]--
%s

--[[ Wrapper ]]--
%s
]=], api, modes, wrapper)

print(io.popen("ls builds"):read("*a"))
local file, _, __ = io.open("builds/" .. os.date("%d_%m_%y") .. ".lua", "w+")
print(io.popen("ls builds"):read("*a"))
print(file, _, __)
do return end
file:write(module)
file:close()