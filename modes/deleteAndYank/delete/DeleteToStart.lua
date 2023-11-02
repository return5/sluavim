local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')

local DeleteToStart <const> = {type = "DeleteToStart"}
setmetatable(DeleteToStart,DeleteMode)
DeleteToStart.__index = DeleteToStart

_ENV = DeleteToStart

function DeleteToStart:deleteToStart(textBuffer,cursor)
	if cursor:getX() <= 1 then
		return self.returnNormalMode
	end
	cursor:moveLeft()
	return self:moveCursorAndDoAction(nil,textBuffer,cursor,self.returnStartOfLine,0)
end

return DeleteToStart
