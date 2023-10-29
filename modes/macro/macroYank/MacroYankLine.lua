local MacroYankMode <const> = require('modes.macro.macroYank.MacroYankMode')
local MacroNormalMode <const> = require('modes.macro.macroNormalAndInsert.MacroNormalMode')

local MacroYankLine <const> = {type = "MacroYankLine"}
MacroYankLine.__index = MacroYankLine

_ENV = MacroYankLine

function MacroYankLine:takeInput(textBuffer,cursor)
	local start <const> = cursor.x
	MacroYankMode.moveCursorToStartOfLine(cursor)
	local startOfLine <const> = cursor.x
	MacroYankMode.moveCursorToEndOfLine(textBuffer,cursor)
	MacroYankMode:deleteOrYankCharacters(textBuffer,cursor,startOfLine)
	cursor:moveXTo(start)
	return MacroNormalMode
end

return MacroYankLine