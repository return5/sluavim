local DeleteChar <const> = require('modes.deleteAndYank.delete.DeleteChar')

local DeleteCurrentChar <const> = {type = "DeleteCurrentChar"}
DeleteCurrentChar.__index = DeleteCurrentChar
setmetatable(DeleteCurrentChar,DeleteChar)

function DeleteCurrentChar:deleteCurrentChar(textBuffer,cursor)
	local returnMode <const> = self:deleteChar(textBuffer,cursor,1,0,cursor.doNothing)
	cursor:moveXIfOverLimit(textBuffer:getLengthOfLine(cursor:getY()))
	return returnMode
end

return DeleteCurrentChar
