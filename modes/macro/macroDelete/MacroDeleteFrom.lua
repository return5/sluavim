local MacroDeleteMode <const> = require('modes.macro.macroDelete.MacroDeleteMode')

local MacroDeleteFrom <const> = {}
MacroDeleteMode.__index = MacroDeleteFrom

_ENV = MacroDeleteFrom

function MacroDeleteFrom:takeInput(textBuffer,cursor)
	return MacroDeleteMode:takeInputAndMoveThenDoAction(textBuffer,cursor,textBuffer.findForward,0)
end

return MacroDeleteFrom
