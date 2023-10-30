local DeleteMode <const> = require('modes.delete.DeleteMode')
local NormalMode <const> = require('modes.NormalMode')

local DeleteWordBackwards <const> = {type = "DeleteWordBackwards"}
DeleteWordBackwards.__index = DeleteWordBackwards

_ENV = DeleteWordBackwards

function DeleteWordBackwards:takeInput(textBuffer,cursor)
	local startX <const> = DeleteMode:findBackwards(textBuffer,cursor,1)
	DeleteMode:deleteOrYankCharacters(textBuffer,cursor,startX)
	return NormalMode
end

return DeleteWordBackwards
