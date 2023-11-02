local DeleteChar <const> = require('modes.deleteAndYank.delete.DeleteChar')

local DeletePrevChar <const> = {type = 'DeletePrevChar'}
DeletePrevChar.__index = DeletePrevChar
setmetatable(DeletePrevChar,DeleteChar)

_ENV = DeletePrevChar

function DeletePrevChar:deletePrevChar(textBuffer,cursor)
	return self:deleteChar(textBuffer,cursor,2,0,cursor.moveLeft)
end

return DeletePrevChar
