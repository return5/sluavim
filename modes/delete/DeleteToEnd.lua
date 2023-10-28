local DeleteMode <const> = require('modes.delete.DeleteMode')
local NormalMode <const> = require('modes.NormalMode')

local DeleteToEnd <const> = {type = "DeleteToEnd"}
DeleteToEnd.__index = DeleteToEnd

_ENV = DeleteToEnd

function DeleteToEnd:takeInput(textBuffer,cursor)
	local start <const> = cursor.x
	cursor:moveToEndOfLine(textBuffer)
	DeleteMode:deleteOrYankCharacters(textBuffer,cursor,start)
	cursor:moveToEndOfLine(textBuffer)
	return NormalMode
end

return DeleteToEnd
