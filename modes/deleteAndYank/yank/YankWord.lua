local YankMode <const> = require('modes.deleteAndYank.yank.YankMode')

local YankWord <const> = {type = "YankWord"}
YankWord.__index = YankWord
setmetatable(YankWord,YankMode)

function YankWord:yankWord(textBuffer,cursor)
	local originalX <const> = cursor:getX()
	local returnMode <const> = self:moveCursorAndDoAction(nil,textBuffer,cursor,self.findForwardPattern,-1)
	cursor:moveXTo(originalX)
	return returnMode
end

return YankWord
