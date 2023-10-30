local MacroDeleteMode <const> = require('modes.macro.macroDelete.MacroDeleteMode')
local MacroNormalMode <const> = require('modes.macro.macroNormalAndInsert.MacroNormalMode')

local MacroDeleteWord <const> = {type = "MacroDeleteWord"}
MacroDeleteWord.__index = MacroDeleteWord

_ENV = MacroDeleteWord

function MacroDeleteWord:takeInput(textBuffer,cursor)
	local startX <const> = MacroDeleteMode:findForward(textBuffer,cursor,-1)
	MacroDeleteMode:deleteOrYankCharacters(textBuffer,cursor,startX)
	cursor:setX(startX)
	return MacroNormalMode
end

return MacroDeleteWord
