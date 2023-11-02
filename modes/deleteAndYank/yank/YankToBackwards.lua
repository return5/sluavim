local YankMovements <const> = require('modes.yank.YankMovements')

local YankToBackwards <const> = {type = "YankToBackwards"}
YankToBackwards.__index = YankToBackwards

_ENV = YankToBackwards

function YankToBackwards:takeInput(textBuffer,cursor)
	return YankMovements:moveCursorAndCopyChars(textBuffer,cursor,textBuffer.findBackwards,1)
end

return YankToBackwards
