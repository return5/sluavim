local YankMovements <const> = require('modes.yank.YankMovements')

local YankTo <const> = {}
YankTo.__index = YankTo

_ENV = YankTo

function YankTo:takeInput(textBuffer,cursor)
	return YankMovements:moveCursorAndCopyChars(textBuffer,cursor,textBuffer.findForward,-1)
end

return YankTo
