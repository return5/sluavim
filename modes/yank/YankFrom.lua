local YankMode <const> = require('modes.yank.YankMode')

local YankFrom <const> = {}
YankMode.__index = YankFrom

_ENV = YankFrom

function YankFrom:takeInput(textBuffer,cursor)
	return YankMode:takeInputAndMoveThenDoAction(textBuffer,cursor,textBuffer.findForward,0)
end

return YankFrom
