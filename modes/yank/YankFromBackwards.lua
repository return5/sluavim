local YankMode <const> = require('modes.yank.YankMode')

local YankFromBackwards <const> = {}
YankFromBackwards.__index = YankFromBackwards

_ENV = YankFromBackwards

function YankFromBackwards:takeInput(textBuffer,cursor)
	return YankMode:takeInputAndMoveThenDoAction(textBuffer,cursor,textBuffer.findBackwards,0)
end

return YankFromBackwards
