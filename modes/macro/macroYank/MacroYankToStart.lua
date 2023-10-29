local MacroYankMode <const> = require('modes.macro.macroYank.MacroYankMode')

local MacroYankToStart <const> = {type = "MacroYankToStart"}
MacroYankToStart.__index = MacroYankToStart

_ENV = MacroYankToStart

function MacroYankToStart:takeInput(textBuffer,cursor)
	return MacroYankMode:deleteOrYankCharacters(textBuffer,cursor,1)
end

return MacroYankToStart
