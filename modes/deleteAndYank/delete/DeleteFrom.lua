local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')

local DeleteFrom <const> = {type = "DeleteFrom"}
DeleteFrom.__index = DeleteFrom
setmetatable(DeleteFrom,DeleteMode)

_ENV = DeleteFrom

function DeleteFrom:default(ch,textBuffer,cursor)
	return self:moveCursorAndDoAction(ch,textBuffer,cursor,textBuffer.findForward,0)
end

return DeleteFrom
