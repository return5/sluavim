local DeleteChar <const> = require('modes.deleteAndYank.delete.DeleteChar')

local DeleteCurrentChar <const> = {type = "DeleteCurrentChar"}
DeleteCurrentChar.__index = DeleteCurrentChar
setmetatable(DeleteCurrentChar,DeleteChar)

function DeleteCurrentChar:deleteCurrentChar(textBuffer,cursor)
	return self:deleteChar(textBuffer,cursor,1,0,cursor.doNothing)
end

return DeleteCurrentChar
