local YankMode <const> = require('modes.deleteAndYank.yank.YankMode')

local YankToStart <const> = {type = "YankToStart"}
YankToStart.__index = YankToStart
setmetatable(YankToStart,YankMode)

_ENV = YankToStart

function YankToStart:yankToStart(textBuffer,cursor)
	local original <const> = cursor.x
	local returnMode <const> = self:moveCursorAndDoAction(nil,textBuffer,cursor,self.returnStartOfLine,0)
	cursor:moveXTo(original)
	return returnMode
end

return YankToStart
