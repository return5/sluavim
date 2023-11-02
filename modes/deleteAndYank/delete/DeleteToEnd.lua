local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')
local NormalMode <const> = require('modes.NormalMode')

local DeleteToEnd <const> = {type = "DeleteToEnd"}
setmetatable(DeleteToEnd,DeleteMode)
DeleteToEnd.__index = DeleteToEnd

_ENV = DeleteToEnd

function DeleteToEnd:deleteToEnd(textBuffer,cursor)
	return self:moveCursorAndDoAction(nil,textBuffer,cursor,self.returnLengthOfLine,0)
end

return DeleteToEnd
