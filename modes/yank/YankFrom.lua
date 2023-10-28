local YankMovements <const> = require('modes.yank.YankMovements')

local YankFrom <const> = {}
YankFrom.__index = YankFrom

_ENV = YankFrom

function YankFrom:takeInput(textBuffer,cursor)
	return YankMovements:moveCursorAndCopyChars(textBuffer,cursor,textBuffer.findForward,0)
end

return YankFrom
