local YankMode <const> = require('modes.deleteAndYank.yank.YankMode')

local YankWordBackwards <const> = {type = "YankWordBackwards"}
YankWordBackwards.__index = YankWordBackwards
setmetatable(YankWordBackwards,YankMode)

function YankWordBackwards:yankWordBackwards(textBuffer,cursor)
	return self:yank(nil,textBuffer,cursor,self.findBackwardsPattern,1)
end

return YankWordBackwards
