local MacroYankMovements <const> = require('modes.macro.macroYank.MacroYankMovements')

local MacroYankFromBackwards <const> = {type = "MacroYankFromBackwards"}
MacroYankFromBackwards.__index = MacroYankFromBackwards

_ENV = MacroYankFromBackwards

function MacroYankFromBackwards:takeInput(textBuffer,cursor)
	return MacroYankMovements:moveCursorAndCopyChars(textBuffer,cursor,textBuffer.findBackwards,0)
end

return MacroYankFromBackwards
