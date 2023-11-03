local YankMode <const> = require('modes.deleteAndYank.yank.YankMode')

local YankTo <const> = {type = "YankTo"}
YankTo.__index = YankTo
setmetatable(YankTo,YankMode)

_ENV = YankTo

function YankTo:default(ch,textBuffer,cursor)
	return self:yank(ch,textBuffer,cursor,textBuffer.findForward,-1)

end

return YankTo
