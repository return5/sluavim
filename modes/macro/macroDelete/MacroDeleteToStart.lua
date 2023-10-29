local MacroDeleteMode <const> = require('modes.macro.macroDelete.MacroDeleteMode')

local MacroDeleteToStart <const> = {type = "MacroDeleteToStart"}
MacroDeleteToStart.__index = MacroDeleteToStart

_ENV = MacroDeleteToStart

function MacroDeleteToStart:takeInput(textBuffer,cursor)
	return MacroDeleteMode:deleteOrYankCharacters(textBuffer,cursor,1)
end

return MacroDeleteToStart
