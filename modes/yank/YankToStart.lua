local YankMode <const> = require('modes.yank.YankMode')

local YankToStart <const> = {type = "YankToStart"}
YankToStart.__index = YankToStart

_ENV = YankToStart

function YankToStart:takeInput(textBuffer,cursor)
	return YankMode:deleteOrYankCharacters(textBuffer,cursor,1)
end

return YankToStart
