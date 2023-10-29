local MacroYankMovements <const> = require('modes.macro.macroYank.MacroYankMovements')

local MacroYankTo <const> = {type = "MacroYankTo"}
MacroYankTo.__index = MacroYankTo

_ENV = MacroYankTo

function MacroYankTo:takeInput(textBuffer,cursor)
	return MacroYankMovements:moveCursorAndCopyChars(textBuffer,cursor,textBuffer.findForward,-1)
end

return MacroYankTo
