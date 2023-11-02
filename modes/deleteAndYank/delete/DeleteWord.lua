local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')

local DeleteWord <const> = {type = "DeleteWord"}
DeleteWord.__index = DeleteWord
setmetatable(DeleteWord,DeleteMode)

_ENV = DeleteWord

function DeleteWord:deleteWord(textBuffer,cursor)
	return self:moveCursorAndDoAction(nil,textBuffer,cursor,self.findForwardPattern,-1)
end

return DeleteWord
