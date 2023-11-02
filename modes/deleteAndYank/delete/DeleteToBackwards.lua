local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')

local DeleteToBackwards <const> = {type = "DeleteToBackwards"}
setmetatable(DeleteToBackwards,DeleteMode)
DeleteToBackwards.__index = DeleteToBackwards

_ENV = DeleteToBackwards

function DeleteToBackwards:default(ch,textBuffer,cursor)
	return self:moveCursorAndDoAction(ch,textBuffer,cursor,textBuffer.findBackwards,1)
end

return DeleteToBackwards
