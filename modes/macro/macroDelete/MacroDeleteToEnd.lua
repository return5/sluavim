local MacroDeleteMode <const> = require('modes.macro.macroDelete.MacroDeleteMode')
local MacroNormalMode <const> = require('modes.macro.macroNormalAndInsert.MacroNormalMode')

local MacroDeleteToEnd <const> = {type = "MacroDeleteToEnd"}
MacroDeleteToEnd.__index = MacroDeleteToEnd

_ENV = MacroDeleteToEnd

function MacroDeleteToEnd:takeInput(textBuffer,cursor)
	local start <const> = cursor.x
	cursor:moveToEndOfLine(textBuffer)
	MacroDeleteMode:deleteOrYankCharacters(textBuffer,cursor,start)
	cursor:moveToEndOfLine(textBuffer)
	return MacroNormalMode
end

return MacroDeleteToEnd
