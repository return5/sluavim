local DeleteMode <const> = require('modes.delete.DeleteMode')

local DeleteToStart <const> = {type = "DeleteToStart"}
DeleteToStart.__index = DeleteToStart

_ENV = DeleteToStart

function DeleteToStart:takeInput(textBuffer,cursor)
	return DeleteMode:deleteOrYankCharacters(textBuffer,cursor,1)
end

return DeleteToStart
