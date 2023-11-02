local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')

local DeleteToBackwards <const> = {}
setmetatable(DeleteToBackwards,DeleteMode)

_ENV = DeleteToBackwards

function DeleteToBackwards:default(ch,textBuffer,cursor)
	return DeleteMode:moveCursorAndDoAction(ch,textBuffer,cursor,textBuffer.findBackwards,1)
end

return DeleteToBackwards
