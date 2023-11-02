local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')
local NormalMode <const> = require('modes.NormalMode')

local DeleteWord <const> = {type = "DeleteWord"}
DeleteWord.__index = DeleteWord

_ENV = DeleteWord

function DeleteWord:takeInput(textBuffer,cursor)
	local startX <const> = DeleteMode:findForward(textBuffer,cursor,-1)
	DeleteMode:deleteOrYankCharacters(textBuffer,cursor,startX)
	cursor:setX(startX)
	return NormalMode
end

return DeleteWord
