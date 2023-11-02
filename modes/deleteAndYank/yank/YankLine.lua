local YankMode <const> = require('modes.deleteAndYank.yank.YankMode')

local YankLine <const> = {type = "YankLine"}
YankLine.__index = YankLine
setmetatable(YankLine,YankMode)

_ENV = YankLine

function YankLine:yankLine(textBuffer,cursor)
	local originalX <const> = cursor.x
	cursor:setX(self.returnStartOfLine(textBuffer,cursor))
	local returnMode <const> = self:moveCursorAndDoAction(nil,textBuffer,cursor,self.returnLengthOfLine,0)
	cursor:moveXTo(originalX)
	return returnMode
end

return YankLine