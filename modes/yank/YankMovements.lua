local YankMode <const> = require('modes.yank.YankMode')

local YankMovements <const> = {type = "YankMovements"}
YankMovements.__index = YankMovements

_ENV = YankMovements

function YankMovements:moveCursorAndCopyChars(textBuffer,cursor,findFunction,offSet)
	local start <const> = cursor.x
	local returnMode <const> = YankMode:takeInputAndMoveThenDoAction(textBuffer,cursor,findFunction,offSet)
	cursor:moveXTo(start)
	return returnMode
end

return YankMovements
