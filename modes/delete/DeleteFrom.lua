local DeleteMode <const> = require('modes.delete.DeleteMode')

local DeleteFrom <const> = {}
DeleteMode.__index = DeleteFrom

_ENV = DeleteFrom

function DeleteFrom:takeInput(textBuffer,cursor)
	return DeleteMode:takeInputAndMoveThenDoAction(textBuffer,cursor,textBuffer.findForward,0)
end

return DeleteFrom
