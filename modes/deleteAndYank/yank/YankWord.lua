local YankMode <const> = require('modes.deleteAndYank.yank.YankMode')

local YankWord <const> = {type = "YankWord"}
YankWord.__index = YankWord
setmetatable(YankWord,YankMode)

function YankWord:yankWord(textBuffer,cursor)
	return self:yank(nil,textBuffer,cursor,self.findForwardPattern,-1)
end

return YankWord
