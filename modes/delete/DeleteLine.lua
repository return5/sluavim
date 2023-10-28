local DeleteMode <const> = require('modes.delete.DeleteMode')
local NormalMode <const> = require('modes.NormalMode')

local DeleteLine <const> = {type = "DeleteLine"}
DeleteLine.__index = DeleteLine

_ENV = DeleteLine

function DeleteLine:takeInput(textBuffer,cursor)
	DeleteMode.moveCursorToStartOfLine(cursor)
	local start <const> = cursor.x
	DeleteMode.moveCursorToEndOfLine(textBuffer,cursor)
	DeleteMode:deleteOrYankCharacters(textBuffer,cursor,start)
	cursor:moveXTo(1)
	textBuffer:removeLineAt(cursor.y)
	cursor:limitYToSizeOfTextBuffer(textBuffer)
	return NormalMode
end

return DeleteLine