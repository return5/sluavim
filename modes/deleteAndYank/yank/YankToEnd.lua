local YankMode <const> = require('modes.deleteAndYank.yank.YankMode')

local YankToEnd <const> = {type = "YankToEnd"}
YankToEnd.__index = YankToEnd
setmetatable(YankToEnd,YankMode)

_ENV = YankToEnd

function YankToEnd:yankToEnd(textBuffer,cursor)
	local original <const> = cursor.x
	local returnMode <const> = self:moveCursorAndDoAction(nil,textBuffer,cursor,self.returnLengthOfLine,0)
	cursor:moveXTo(original)
	return returnMode
end

return YankToEnd
