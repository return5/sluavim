local MacroDeleteMode <const> = require('modes.macro.macroDelete.MacroDeleteMode')
local MacroNormalMode <const> = require('modes.macro.macroNormalAndInsert.MacroNormalMode')

local MacroDeleteWordBackwards <const> = {type = "MacroDeleteWordBackwards"}
MacroDeleteWordBackwards.__index = MacroDeleteWordBackwards

_ENV = MacroDeleteWordBackwards

function MacroDeleteWordBackwards:takeInput(textBuffer,cursor)
	local startX <const> = MacroDeleteMode:findBackwards(textBuffer,cursor,1)
	MacroDeleteMode:deleteOrYankCharacters(textBuffer,cursor,startX)
	return MacroNormalMode
end

return MacroDeleteWordBackwards
