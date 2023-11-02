local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')

local DeleteWordBackwards <const> = {type = "DeleteWordBackwards"}
DeleteWordBackwards.__index = DeleteWordBackwards
setmetatable(DeleteWordBackwards,DeleteMode)

_ENV = DeleteWordBackwards

function DeleteWordBackwards:deleteWordBackwards(textBuffer,cursor)
	return self:moveCursorAndDoAction(nil,textBuffer,cursor,self.findBackwardsPattern,1)
end

return DeleteWordBackwards
