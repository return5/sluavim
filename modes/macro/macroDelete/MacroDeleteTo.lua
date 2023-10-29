local MacroDeleteMode <const> = require('modes.macro.macroDelete.MacroDeleteMode')

local MacroDeleteTo <const> = {}
MacroDeleteMode.__index = MacroDeleteTo

_ENV = MacroDeleteTo

function MacroDeleteTo:takeInput(textBuffer,cursor)
	return MacroDeleteMode:takeInputAndMoveThenDoAction(textBuffer,cursor,textBuffer.findForward,-1)
end

return MacroDeleteTo
