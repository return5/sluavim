local DeleteMode <const> = require('modes.delete.DeleteMode')

local DeleteFromBackwards <const> = {}
DeleteFromBackwards.__index = DeleteFromBackwards


_ENV = DeleteFromBackwards

function DeleteFromBackwards:takeInput(textBuffer,cursor)
	return DeleteMode:takeInputAndMoveThenDoAction(textBuffer,cursor,textBuffer.findBackwards,0)
end

return DeleteFromBackwards
