local MacroDeleteMode <const> = require('modes.macro.macroDelete.MacroDeleteMode')

local MacroDeleteFromBackwards <const> = {}
MacroDeleteFromBackwards.__index = MacroDeleteFromBackwards


_ENV = MacroDeleteFromBackwards

function MacroDeleteFromBackwards:takeInput(textBuffer,cursor)
	return MacroDeleteMode:takeInputAndMoveThenDoAction(textBuffer,cursor,textBuffer.findBackwards,0)
end

return MacroDeleteFromBackwards
