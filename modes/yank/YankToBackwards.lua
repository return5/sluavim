local YankMode <const> = require('modes.yank.YankMode')

local YankToBackwards <const> = {type = "YankToBackwards"}
YankToBackwards.__index = YankToBackwards


_ENV = YankToBackwards

function YankToBackwards:takeInput(textBuffer,cursor)
	return YankMode:takeInputAndMoveThenDoAction(textBuffer,cursor,textBuffer.findBackwards,1)
end

return YankToBackwards
