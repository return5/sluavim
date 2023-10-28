local DeleteMode <const> = require('modes.delete.DeleteMode')

local DeleteTo <const> = {}
DeleteMode.__index = DeleteTo

_ENV = DeleteTo

function DeleteTo:takeInput(textBuffer,cursor)
	return DeleteMode:takeInputAndMoveThenDoAction(textBuffer,cursor,textBuffer.findForward,-1)
end

return DeleteTo
