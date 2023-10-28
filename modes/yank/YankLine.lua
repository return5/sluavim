local YankMode <const> = require('modes.yank.YankMode')
local NormalMode <const> = require('modes.NormalMode')

local YankLine <const> = {type = "YankLine"}
YankLine.__index = YankLine

_ENV = YankLine

function YankLine:takeInput(textBuffer,cursor)
	YankMode.moveCursorToStartOfLine(cursor)
	local start <const> = cursor.x
	YankMode.moveCursorToEndOfLine(textBuffer,cursor)
	YankMode:deleteOrYankCharacters(textBuffer,cursor,start)
	return NormalMode
end

return YankLine