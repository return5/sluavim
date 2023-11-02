local YankMovements <const> = require('modes.yank.YankMovements')

local YankFromBackwards <const> = {}
YankFromBackwards.__index = YankFromBackwards

_ENV = YankFromBackwards

function YankFromBackwards:takeInput(textBuffer,cursor)
	return YankMovements:moveCursorAndCopyChars(textBuffer,cursor,textBuffer.findBackwards,0)
end

return YankFromBackwards
