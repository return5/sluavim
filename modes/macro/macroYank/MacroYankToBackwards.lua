local MacroYankMovements <const> = require('modes.macro.macroYank.MacroYankMovements')

local MacroYankToBackwards <const> = {type = "MacroYankToBackwards"}
MacroYankToBackwards.__index = MacroYankToBackwards

_ENV = MacroYankToBackwards

function MacroYankToBackwards:takeInput(textBuffer,cursor)
	return MacroYankMovements:moveCursorAndCopyChars(textBuffer,cursor,textBuffer.findBackwards,1)
end

return MacroYankToBackwards
