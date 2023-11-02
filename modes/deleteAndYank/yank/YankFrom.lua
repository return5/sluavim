local YankMode <const> = require('modes.deleteAndYank.yank.YankMode')

local YankFrom <const> = {type = "YankFrom"}
YankFrom.__index = YankFrom
setmetatable(YankFrom, YankMode)

_ENV = YankFrom

function YankFrom:default(ch,textBuffer,cursor)
	return self:moveCursorAndDoAction(ch,textBuffer,cursor,textBuffer.findForward,0)
end

return YankFrom
