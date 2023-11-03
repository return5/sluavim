local YankMode <const> = require('modes.deleteAndYank.yank.YankMode')

local YankFromBackwards <const> = {type = "YankFromBackwards"}
YankFromBackwards.__index = YankFromBackwards
setmetatable(YankFromBackwards,YankMode)

_ENV = YankFromBackwards

function YankFromBackwards:default(ch,textBuffer,cursor)
	return self:yank(ch,textBuffer,cursor,textBuffer.findBackwards,0)
end

return YankFromBackwards
