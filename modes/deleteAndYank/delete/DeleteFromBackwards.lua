local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')

local DeleteFromBackwards <const> = {}
setmetatable(DeleteFromBackwards,DeleteMode)
DeleteFromBackwards.__index = DeleteFromBackwards

_ENV = DeleteFromBackwards

function DeleteFromBackwards:default(ch,textBuffer,cursor)
	return self:moveCursorAndDoAction(ch,textBuffer,cursor,textBuffer.findBackwards,0)
end

return DeleteFromBackwards
