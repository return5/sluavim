local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')

local DeleteTo <const> = {type = "DeleteTo"}
DeleteTo.__index = DeleteTo
setmetatable(DeleteTo,DeleteMode)

_ENV = DeleteTo

function DeleteTo:default(ch,textBuffer,cursor)
	return self:moveCursorAndDoAction(ch,textBuffer,cursor,textBuffer.findForward,-1)
end

return DeleteTo
