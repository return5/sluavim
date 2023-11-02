local YankMode <const> = require('modes.deleteAndYank.yank.YankMode')

local YankWordBackwards <const> = {type = "YankWordBackwards"}
YankWordBackwards.__index = YankWordBackwards
setmetatable(YankWordBackwards,YankMode)

function YankWordBackwards:yankWordBackwards(textBuffer,cursor)
	local originalX <const> = cursor.x
	local returnMode <const> = self:moveCursorAndDoAction(nil,textBuffer,cursor,self.findBackwardsPattern,1)
	cursor:moveXTo(originalX)
	return returnMode
end

return YankWordBackwards
