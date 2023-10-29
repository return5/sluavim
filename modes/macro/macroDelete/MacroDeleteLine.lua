local MacroDeleteMode <const> = require('modes.macro.macroDelete.MacroDeleteMode')
local MacroNormalMode <const> = require('modes.macro.macroNormalAndInsert.MacroNormalMode')

local MacroDeleteLine <const> = {type = "MacroDeleteLine"}
MacroDeleteLine.__index = MacroDeleteLine

_ENV = MacroDeleteLine

function MacroDeleteLine:takeInput(textBuffer,cursor)
	MacroDeleteMode.moveCursorToStartOfLine(cursor)
	local start <const> = cursor.x
	MacroDeleteMode.moveCursorToEndOfLine(textBuffer,cursor)
	MacroDeleteMode:deleteOrYankCharacters(textBuffer,cursor,start)
	cursor:moveXTo(1)
	textBuffer:removeLineAt(cursor.y)
	cursor:limitYToSizeOfTextBuffer(textBuffer)
	return MacroNormalMode
end

return MacroDeleteLine