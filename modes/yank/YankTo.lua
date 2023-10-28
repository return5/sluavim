local YankMode <const> = require('modes.yank.YankMode')

local YankTo <const> = {}
YankMode.__index = YankTo

_ENV = YankTo

function YankTo:takeInput(textBuffer,cursor)
	return YankMode:takeInputAndMoveThenDoAction(textBuffer,cursor,textBuffer.findForward,-1)
end

return YankTo
