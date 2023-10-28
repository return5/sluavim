local DeleteMode <const> = require('modes.delete.DeleteMode')

local DeleteToEnd <const> = {type = "DeleteToEnd"}
DeleteToEnd.__index = DeleteToEnd

_ENV = DeleteToEnd

function DeleteToEnd:takeInput(textBuffer,cursor)
	local start <const> = cursor.x
	cursor:moveToEndOfLine(textBuffer)
	return DeleteMode:deleteOrYankCharacters(textBuffer,cursor,start)
end

return DeleteToEnd
