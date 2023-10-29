local MacroDeleteMode <const> = require('modes.macro.macroDelete.MacroDeleteMode')

local MacroDeleteToBackwards <const> = {type = "MacroDeleteToBackwards"}
MacroDeleteToBackwards.__index = MacroDeleteToBackwards


_ENV = MacroDeleteToBackwards

function MacroDeleteToBackwards:takeInput(textBuffer,cursor)
	return MacroDeleteMode:takeInputAndMoveThenDoAction(textBuffer,cursor,textBuffer.findBackwards,1)
end

return MacroDeleteToBackwards
