local YankMode <const> = require('modes.deleteAndYank.yank.YankMode')

local YankToEnd <const> = {type = "YankToEnd"}
YankToEnd.__index = YankToEnd
setmetatable(YankToEnd,YankMode)

_ENV = YankToEnd

function YankToEnd:yankToEnd(textBuffer,cursor)
	self:yank(nil,textBuffer,cursor,self.returnLengthOfLine,0)
end

return YankToEnd
