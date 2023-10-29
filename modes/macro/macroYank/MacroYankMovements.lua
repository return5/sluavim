local MacroYankMode <const> = require('modes.macro.macroYank.MacroYankMode')

local MacroYankMovements <const> = {type = "MacroYankMovements"}
MacroYankMovements.__index = MacroYankMovements

_ENV = MacroYankMovements

function MacroYankMovements:moveCursorAndCopyChars(textBuffer,cursor,findFunction,offSet)
	local start <const> = cursor.x
	local returnMode <const> = MacroYankMode:takeInputAndMoveThenDoAction(textBuffer,cursor,findFunction,offSet)
	cursor:moveXTo(start)
	return returnMode
end

return MacroYankMovements
