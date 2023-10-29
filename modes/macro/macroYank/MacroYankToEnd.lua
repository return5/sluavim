local MacroYankMode <const> = require('modes.macro.macroYank.MacroYankMode')
local MacroNormalMode <const> = require('modes.macro.macroNormalAndInsert.MacroNormalMode')

local MacroYankToEnd <const> = {type = "MacroYankToEnd"}
MacroYankToEnd.__index = MacroYankToEnd

_ENV = MacroYankToEnd

function MacroYankToEnd:takeInput(textBuffer,cursor)
	local start <const> = cursor.x
	cursor:moveToEndOfLine(textBuffer)
	MacroYankMode:deleteOrYankCharacters(textBuffer,cursor,start)
	return MacroNormalMode
end

return MacroYankToEnd
