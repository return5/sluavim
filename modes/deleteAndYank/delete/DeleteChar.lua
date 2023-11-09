local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')

local DeleteChar <const> = {type = 'DeleteChar'}
DeleteChar.__index = DeleteChar
setmetatable(DeleteChar,DeleteMode)

_ENV = DeleteChar

local function returnCurrentX(cursor)
	return function() return cursor:getX() end
end

function DeleteChar:deleteChar(textBuffer,cursor,limit,offset,movementFunction)
	if cursor:isXLessThan(limit) then return self.returnNormalMode() end
	movementFunction(cursor)
	return self:moveCursorAndDoAction(nil,textBuffer,cursor,returnCurrentX(cursor),offset)
end

return DeleteChar
