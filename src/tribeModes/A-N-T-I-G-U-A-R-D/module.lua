local keys = { [8] = "Backspace", [9] = "Tab", [13] = "Enter", [16] = "Shift", [17] = "Control", [18] = "Alt", [19] = "Pause/break", [20] = "Caps Lock", [27] = "Escape", [32] = "Spacebar", [33] = "Page Up", [34] = "Page Down", [35] = "End", [36] = "Home", [37] = "Left Arrow", [38] = "Up Arrow", [39] = "Right Arrow", [40] = "Down Arrow", [45] = "Insert", [46] = "Delete", [48] = "0", [49] = "1", [50] = "2", [51] = "3", [52] = "4", [53] = "5", [54] = "6", [55] = "7", [56] = "8", [57] = "9", [65] = "A", [66] = "B", [67] = "C", [68] = "D", [69] = "E", [70] = "F", [71] = "G", [72] = "H", [73] = "I", [74] = "K", [75] = "J", [76] = "L", [77] = "M", [78] = "N", [79] = "O", [80] = "P", [81] = "Q", [82] = "R", [83] = "S", [84] = "T", [85] = "U", [86] = "V", [87] = "W", [88] = "X", [89] = "Y", [90] = "Z", [91] = "Windows (Left)", [92] = "Windows (Right)", [93] = "Application Key", [96] = "0 (Numbpad)", [97] = "1 (Numbpad)", [98] = "2 (Numbpad)", [99] = "3 (Numbpad)", [100] = "4 (Numbpad)", [101] = "5 (Numbpad)", [102] = "6 (Numbpad)", [103] = "7 (Numbpad)", [104] = "8 (Numbpad)", [105] = "9 (Numbpad)", [106] = "* Asterix (Numbpad)", [107] = "+ Plus (Numbpad)", [109] = "- Minus (Numbpad)", [110] = ". (or ,) Decimal Point", [111] = "/ Forward Slash (Numbpad)", [112] = "F1", [113] = "F2", [114] = "F3", [115] = "F4", [116] = "F5", [117] = "F6", [118] = "F7", [119] = "F8", [120] = "F9", [121] = "F10", [122] = "F11", [123] = "F12", [144] = "Numlock", [145] = "Scroll Lock", [186] = "; Semicolon", [187] = "= Equals", [188] = ", Comma", [189] = "- Hyphen", [190] = ". Period", [191] = "/ Forward Slash", [192] = "` Grave Accent", [193] = "Unknown", [219] = "[ Open Bracket", [220] = "\\ Backslash", [221] = "] Close Bracket", [222] = "' Single quote" }

local admin

ui.addTextArea(0, '', nil, 5, 10, 790, 390, 0xffffff, 0xffffff)
ui.addTextArea(1, "<p align='center'><font size='80' color='#000000'>Keyboard Codes<br><font size='16'>Press any key to start", nil, 5, 160, 790, nil, 0)

function eventChatCommand(name, cmd)
	if (cmd == 'admin' and not admin) then
		admin = name;for k in next, keys do system.bindKeyboard(name, k, true) end
		ui.addTextArea(2, "<font size='12' color='#000000'>Admin: " .. name, nil, 0, 20, nil, nil, 0)
	end
end

function eventKeyboard(name, key)
	local skey, str = -1, "<p align='center'><font size='80' color='#000000'>%s<br><font size='24'>%s"
	skey = (key == 37 and 0 or key == 65 and 0 or key == 81 and 0 or key == 38 and 1 or key == 90 and 1 or key == 39 and 2 or key == 68 and 2 or key == 40 and 3 or key == 83 and 3 or key == 87 and 1 or nil)
	str = (skey and "<p align='center'><font size='80' color='#000000'>%s or %s<br><font size='24'>%s" or str)
	ui.updateTextArea(1, string.format(str, key, (skey ~= -1 and skey or keys[key]), keys[key]))
end