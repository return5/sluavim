local YankMode <const> = require('modes.yank.YankMode')
local NormalMode <const> = require('modes.NormalMode')

local YankToEnd <const> = {type = "YankToEnd"}
YankToEnd.__index = YankToEnd

_ENV = YankToEnd

function YankToEnd:takeInput(textBuffer,cursor)
	local start <const> = cursor.x
	cursor:moveToEndOfLine(textBuffer)
	YankMode:deleteOrYankCharacters(textBuffer,cursor,start)
	return NormalMode
end

return YankToEnd
