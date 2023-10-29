local MacroYankMovements <const> = require('modes.macro.macroYank.MacroYankMovements')

local MacroYankFrom <const> = {type = "MacroYankFrom"}
MacroYankFrom.__index = MacroYankFrom

_ENV = MacroYankFrom

function MacroYankFrom:takeInput(textBuffer,cursor)
	return MacroYankMovements:moveCursorAndCopyChars(textBuffer,cursor,textBuffer.findForward,0)
end

return MacroYankFrom
