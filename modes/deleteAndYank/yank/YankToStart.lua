local YankMode <const> = require('modes.deleteAndYank.yank.YankMode')

local YankToStart <const> = {type = "YankToStart"}
YankToStart.__index = YankToStart
setmetatable(YankToStart,YankMode)

_ENV = YankToStart

function YankToStart:yankToStart(textBuffer,cursor)
	return self:yank(nil,textBuffer,cursor,self.returnStartOfLine,0)
end

return YankToStart
