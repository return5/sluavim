local YankMode <const> = require('modes.deleteAndYank.yank.YankMode')

local YankToBackwards <const> = {type = "YankToBackwards"}
YankToBackwards.__index = YankToBackwards
setmetatable(YankToBackwards,YankMode)

_ENV = YankToBackwards

function YankToBackwards:default(ch,textBuffer,cursor)
	return self:moveCursorAndDoAction(ch,textBuffer,cursor,textBuffer.findBackwards,1)
end

return YankToBackwards
