local DeleteMode <const> = require('modes.delete.DeleteMode')

local DeleteToBackwards <const> = {type = "DeleteToBackwards"}
DeleteToBackwards.__index = DeleteToBackwards


_ENV = DeleteToBackwards

function DeleteToBackwards:takeInput(textBuffer,cursor)
	return DeleteMode:takeInputAndMoveThenDoAction(textBuffer,cursor,textBuffer.findBackwards,1)
end

return DeleteToBackwards
