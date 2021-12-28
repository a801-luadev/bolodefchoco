tfm.exec.setRoomMaxPlayers(1)

function fuckoff()
	local found = false
	for k in next, tfm.get.room.playerList do
		if k == "D_shades#0780" or k == "Bolodefchoco#0015" then
			found = true
			break
		end
	end
	if not found then
		system.exit()
	end
end

local json = (function()
	local json = { _version = "0.1.1" }

	-------------------------------------------------------------------------------
	-- Encode
	-------------------------------------------------------------------------------

	local encode

	local escape_char_map = {
		[ "\\" ] = "\\\\",
		[ "\"" ] = "\\\"",
		[ "\b" ] = "\\b",
		[ "\f" ] = "\\f",
		[ "\n" ] = "\\n",
		[ "\r" ] = "\\r",
		[ "\t" ] = "\\t",
	}

	local escape_char_map_inv = { [ "\\/" ] = "/" }
	for k, v in pairs(escape_char_map) do
		escape_char_map_inv[v] = k
	end


	local function escape_char(c)
		return escape_char_map[c] or string.format("\\u%04x", c:byte())
	end


	local function encode_nil(val)
		return "null"
	end


	local function encode_table(val, stack)
		local res = {}
		stack = stack or {}

		-- Circular reference?
		if stack[val] then error("circular reference") end

		stack[val] = true

		if val[1] ~= nil or next(val) == nil then
			-- Treat as array -- check keys are valid and it is not sparse
			local n = 0
			for k in pairs(val) do
				if type(k) ~= "number" then
					error("invalid table: mixed or invalid key types")
				end
				n = n + 1
			end
			if n ~= #val then
				error("invalid table: sparse array")
			end
			-- Encode
			for i, v in ipairs(val) do
				table.insert(res, encode(v, stack))
			end
			stack[val] = nil
			return "[" .. table.concat(res, ",") .. "]"
		else
			-- Treat as an object
			for k, v in pairs(val) do
				if type(k) ~= "string" then
					error("invalid table: mixed or invalid key types")
				end
				table.insert(res, encode(k, stack) .. ":" .. encode(v, stack))
			end
			stack[val] = nil
			return "{" .. table.concat(res, ",") .. "}"
		end
	end

	local function encode_string(val)
		return '"' .. val:gsub('[%z\1-\31\\"]', escape_char) .. '"'
	end


	local function encode_number(val)
		-- Check for NaN, -inf and inf
		if val ~= val or val <= -math.huge or val >= math.huge then
			error("unexpected number value '" .. tostring(val) .. "'")
		end
		return string.format("%.14g", val)
	end


	local type_func_map = {
 [ "nil"     ] = encode_nil,
 [ "table"   ] = encode_table,
 [ "string"  ] = encode_string,
 [ "number"  ] = encode_number,
 [ "boolean" ] = tostring,
	}


	encode = function(val, stack)
 local t = type(val)
 local f = type_func_map[t]
 if f then
		return f(val, stack)
 end
 error("unexpected type '" .. t .. "'")
	end


	function json.encode(val)
 return ( encode(val) )
	end


	-------------------------------------------------------------------------------
	-- Decode
	-------------------------------------------------------------------------------

	local parse

	local function create_set(...)
 local res = {}
 for i = 1, select("#", ...) do
		res[ select(i, ...) ] = true
 end
 return res
	end

	local space_chars   = create_set(" ", "\t", "\r", "\n")
	local delim_chars   = create_set(" ", "\t", "\r", "\n", "]", "}", ",")
	local escape_chars  = create_set("\\", "/", '"', "b", "f", "n", "r", "t", "u")
	local literals      = create_set("true", "false", "null")

	local literal_map = {
 [ "true"  ] = true,
 [ "false" ] = false,
 [ "null"  ] = nil,
	}


	local function next_char(str, idx, set, negate)
 for i = idx, #str do
		if set[str:sub(i, i)] ~= negate then
	 return i
		end
 end
 return #str + 1
	end


	local function decode_error(str, idx, msg)
 local line_count = 1
 local col_count = 1
 for i = 1, idx - 1 do
		col_count = col_count + 1
		if str:sub(i, i) == "\n" then
	 line_count = line_count + 1
	 col_count = 1
		end
 end
 error( string.format("%s at line %d col %d", msg, line_count, col_count) )
	end


	local function codepoint_to_utf8(n)
 -- http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=iws-appendixa
 local f = math.floor
 if n <= 0x7f then
		return string.char(n)
 elseif n <= 0x7ff then
		return string.char(f(n / 64) + 192, n % 64 + 128)
 elseif n <= 0xffff then
		return string.char(f(n / 4096) + 224, f(n % 4096 / 64) + 128, n % 64 + 128)
 elseif n <= 0x10ffff then
		return string.char(f(n / 262144) + 240, f(n % 262144 / 4096) + 128,
					  f(n % 4096 / 64) + 128, n % 64 + 128)
 end
 error( string.format("invalid unicode codepoint '%x'", n) )
	end


	local function parse_unicode_escape(s)
 local n1 = tonumber( s:sub(3, 6),  16 )
 local n2 = tonumber( s:sub(9, 12), 16 )
 -- Surrogate pair?
 if n2 then
		return codepoint_to_utf8((n1 - 0xd800) * 0x400 + (n2 - 0xdc00) + 0x10000)
 else
		return codepoint_to_utf8(n1)
 end
	end


	local function parse_string(str, i)
 local has_unicode_escape = false
 local has_surrogate_escape = false
 local has_escape = false
 local last
 for j = i + 1, #str do
		local x = str:byte(j)

		if x < 32 then
	 decode_error(str, j, "control character in string")
		end

		if last == 92 then -- "\\" (escape char)
	 if x == 117 then -- "u" (unicode escape sequence)
			local hex = str:sub(j + 1, j + 5)
			if not hex:find("%x%x%x%x") then
		 decode_error(str, j, "invalid unicode escape in string")
			end
			if hex:find("^[dD][89aAbB]") then
		 has_surrogate_escape = true
			else
		 has_unicode_escape = true
			end
	 else
			local c = string.char(x)
			if not escape_chars[c] then
		 decode_error(str, j, "invalid escape char '" .. c .. "' in string")
			end
			has_escape = true
	 end
	 last = nil

		elseif x == 34 then -- '"' (end of string)
	 local s = str:sub(i + 1, j - 1)
	 if has_surrogate_escape then
			s = s:gsub("\\u[dD][89aAbB]..\\u....", parse_unicode_escape)
	 end
	 if has_unicode_escape then
			s = s:gsub("\\u....", parse_unicode_escape)
	 end
	 if has_escape then
			s = s:gsub("\\.", escape_char_map_inv)
	 end
	 return s, j + 1

		else
	 last = x
		end
 end
 decode_error(str, i, "expected closing quote for string")
	end


	local function parse_number(str, i)
 local x = next_char(str, i, delim_chars)
 local s = str:sub(i, x - 1)
 local n = tonumber(s)
 if not n then
		decode_error(str, i, "invalid number '" .. s .. "'")
 end
 return n, x
	end


	local function parse_literal(str, i)
 local x = next_char(str, i, delim_chars)
 local word = str:sub(i, x - 1)
 if not literals[word] then
		decode_error(str, i, "invalid literal '" .. word .. "'")
 end
 return literal_map[word], x
	end


	local function parse_array(str, i)
 local res = {}
 local n = 1
 i = i + 1
 while 1 do
		local x
		i = next_char(str, i, space_chars, true)
		-- Empty / end of array?
		if str:sub(i, i) == "]" then
	 i = i + 1
	 break
		end
		-- Read token
		x, i = parse(str, i)
		res[n] = x
		n = n + 1
		-- Next token
		i = next_char(str, i, space_chars, true)
		local chr = str:sub(i, i)
		i = i + 1
		if chr == "]" then break end
		if chr ~= "," then decode_error(str, i, "expected ']' or ','") end
 end
 return res, i
	end


	local function parse_object(str, i)
 local res = {}
 i = i + 1
 while 1 do
		local key, val
		i = next_char(str, i, space_chars, true)
		-- Empty / end of object?
		if str:sub(i, i) == "}" then
	 i = i + 1
	 break
		end
		-- Read key
		if str:sub(i, i) ~= '"' then
	 decode_error(str, i, "expected string for key")
		end
		key, i = parse(str, i)
		-- Read ':' delimiter
		i = next_char(str, i, space_chars, true)
		if str:sub(i, i) ~= ":" then
	 decode_error(str, i, "expected ':' after key")
		end
		i = next_char(str, i + 1, space_chars, true)
		-- Read value
		val, i = parse(str, i)
		-- Set
		res[key] = val
		-- Next token
		i = next_char(str, i, space_chars, true)
		local chr = str:sub(i, i)
		i = i + 1
		if chr == "}" then break end
		if chr ~= "," then decode_error(str, i, "expected '}' or ','") end
 end
 return res, i
	end


	local char_func_map = {
 [ '"' ] = parse_string,
 [ "0" ] = parse_number,
 [ "1" ] = parse_number,
 [ "2" ] = parse_number,
 [ "3" ] = parse_number,
 [ "4" ] = parse_number,
 [ "5" ] = parse_number,
 [ "6" ] = parse_number,
 [ "7" ] = parse_number,
 [ "8" ] = parse_number,
 [ "9" ] = parse_number,
 [ "-" ] = parse_number,
 [ "t" ] = parse_literal,
 [ "f" ] = parse_literal,
 [ "n" ] = parse_literal,
 [ "[" ] = parse_array,
 [ "{" ] = parse_object,
	}


	parse = function(str, idx)
 local chr = str:sub(idx, idx)
 local f = char_func_map[chr]
 if f then
		return f(str, idx)
 end
 decode_error(str, idx, "unexpected character '" .. chr .. "'")
	end


	function json.decode(str)
 if type(str) ~= "string" then
		error("expected argument of type string, got " .. type(str))
 end
 local res, idx = parse(str, next_char(str, 1, space_chars, true))
 idx = next_char(str, idx, space_chars, true)
 if idx <= #str then
		decode_error(str, idx, "trailing garbage")
 end
 return res
	end


	return json
end)()

local split_message_at = 600

local function splitMessage(msg)
	local messagesIndex = 0
	local messages = {}

	for index = 1, #msg, split_message_at do
		messagesIndex = messagesIndex + 1
		messages[messagesIndex] = string.sub(msg, index, index + split_message_at - 1)
	end

	return messages
end

local function chatMessage(msgId, msg)
	local messages
	if #msg > split_message_at then
		messages = splitMessage(msg)
	else
		messages = {msg}
	end

	local messagesLength = #messages
	for index = 1, messagesLength do
		tfm.exec.chatMessage(msgId .. " " .. (messagesLength - index) .. " " .. messages[index])
	end
end

local eventLoopCount = 0
local staff_teams

local set_staff_teams = function()
	staff_teams = {
		["fashion_squad"] = _TEAM.fs,
		["module_team"] = _TEAM.mt,
		["funcorp"] = _TEAM.fc,
		["sentinel"] = _TEAM.sent,
		["shades_helpers"] = _TEAM.sh,
		["flash_squad"] = _TEAM.fla
	}
end

local check_teams_load = function()
	if _TEAM._loaded then
		set_staff_teams()
		return true
	end
	return false
end

local online_players = {}
local player_requests = {}
local commands = {
	["get_team"] = function(args)
		local result = {success = true, message = nil, members = {}}

		for member, community in next, staff_teams[args[3]] do
			result.members[member] = online_players[member] and tostring(community) or nil -- only sends online ones now, and includes the community, not true/false.
		end

		chatMessage(args[1], json.encode(result))
	end,

	["online"] = function(args)
		local result = {success = true, message = nil, online = {}}

		local onlineIndex = 0
		for member, isIn in next, staff_teams[args[3]] do
			if isIn then
				if online_players[member] then
					onlineIndex = onlineIndex + 1
					result.online[onlineIndex] = member
				end
			end
		end

		chatMessage(args[1], json.encode(result))
	end,

	["get_user"] = function(args)
		if not player_requests[args[3]] then
			player_requests[args[3]] = {{args[1]}, 0}
		else
			player_requests[args[3]][1][#player_requests[args[3]][1]] = args[1]
		end
	end,

	["team_add"] = function(args)
		for index = 4, #args do
			staff_teams[args[3]][args[index]] = true
		end

		chatMessage(args[1], '{"success":true,"message":null}')
	end,

	["team_remove"] = function(args)
		for index = 4, #args do
			staff_teams[args[3]][args[index]] = nil
		end

		chatMessage(args[1], '{"success":true,"message":null}')
	end
}

function eventPlayerDataLoaded(player)
	online_players[player] = true
end

local timer = 0
function eventLoop()
	if timer > 0 then
		timer = timer + .5
		if timer == 1 then
			timer = 0
			fuckoff()
		end
		return
	end

	if not staff_teams then
		if not check_teams_load() then
			return
		end
	end

	local rem = {}

	for player, request in next, player_requests do
		request[2] = request[2] + 1

		if request[2] == 2 then
			local result = {success = true, message = nil, roles = {}, isOnline = online_players[player] or false}

			local rolesIndex = 0
			for teamName, teamData in next, staff_teams do
				if teamData[player] then
					rolesIndex = rolesIndex + 1
					result.roles[rolesIndex] = teamName
				end
			end

			result = json.encode(result)

			for index, msgId in next, request[1] do
				chatMessage(msgId, result)
			end

			rem[player] = true
		elseif request[2] == 1 then
			system.loadPlayerData(player)
		end
	end

	for player in next, rem do
		player_requests[player] = nil
	end

	eventLoopCount = eventLoopCount + 1

	if eventLoopCount == 20 then
		eventLoopCount = 0
		local onlinePlayersTable = {}

		for teamName, team in next, staff_teams do
			for member, isIn in next, team do
				if isIn then
					onlinePlayersTable[member] = false
				end
			end
		end

		online_players = onlinePlayersTable
		for member in next, online_players do
			system.loadPlayerData(member)
		end
	end
end

eventTextAreaCallback = function(id, name, data)
	if name == "D_shades#0780" or name == "Bolodefchoco#0015" then
		system.saveFile(data, id)
		tfm.exec.chatMessage("[shades_id] Save file @" .. id)
	else
		tfm.exec.chatMessage("[shades_id] Save file @" .. id .. " [undo] " .. name .. " TRYING TO HACK MODULE!")
	end
end

local listener = 0
local listenerData = { }
function eventChatMessage(player, msg)
	if player == "D_shades#0780" or player == "Bolodefchoco#0015" then
		if listener > 0 then
			listener = listener - 1
			listenerData[#listenerData + 1] = msg

			if listener == 0 then
				--system.saveFile(table.concat(listenerData), 4)
			end
			return
		end

		local spl = string.split(msg, "%S+")

		if commands[spl[2]] then
			commands[spl[2]](spl)
		else
			if spl[1] == "listener" then
				listenerData = { }
				listener = tonumber(spl[2])
			elseif spl[1] == "maxplayers" then
				tfm.exec.setRoomMaxPlayers(tfm.get.room.uniquePlayers + (tonumber(spl[2]) or 1))
			end
		end
	end
end

tfm.exec.disableAutoNewGame()

tfm.exec.chatMessage("<J>/!\\")