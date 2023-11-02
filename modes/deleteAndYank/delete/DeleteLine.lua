local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')

local DeleteLine <const> = {type = "DeleteLine"}
setmetatable(DeleteLine,DeleteMode)
DeleteLine.__index = DeleteLine

_ENV = DeleteLine

function DeleteLine:deleteLine(textBuffer,cursor)
	cursor:setX(self.returnStartOfLine(textBuffer,cursor))
	local returnMode <const> = self:moveCursorAndDoAction(nil,textBuffer,cursor,self.returnLengthOfLine,0)
	--TODO check if bottom of line and move up
	return returnMode
end

return DeleteLine