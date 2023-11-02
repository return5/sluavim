local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')
local DeleteChar <const> = {type = 'DeleteChar'}
DeleteChar.__index = DeleteChar
setmetatable(DeleteChar,DeleteMode)

_ENV = DeleteChar

local function returnCurrentX(cursor)
	return function() return cursor:getX() end
end

function DeleteChar:deleteChar(textBuffer,cursor)
	if cursor:xIsLessThan(1) then return self.returnNormalMode() end
	return self:moveCursorAndDoAction(nil,textBuffer,cursor,returnCurrentX(cursor),0)
end

return DeleteChar
