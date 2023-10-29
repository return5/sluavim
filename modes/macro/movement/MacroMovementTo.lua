local MacroMovementMode <const> = require('modes.macro.movement.MacroMovementMode')

local MacroMovementTo <const> = {type = "MacroMovementTo"}
MacroMovementTo.__index = MacroMovementTo

setmetatable(MacroMovementTo,MacroMovementMode)

_ENV = MacroMovementTo

function MacroMovementTo:findFunction(textBuffer,cursor,ch)
	local stop <const> = textBuffer:findForward(cursor,ch)
	return stop,-1
end

return MacroMovementTo
