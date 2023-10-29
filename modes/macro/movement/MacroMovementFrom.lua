local MacroMovementMode <const> = require('modes.macro.movement.MacroMovementMode')

local MacroMovementFrom <const> = {type = "MacroMovementFrom"}
MacroMovementFrom.__index = MacroMovementFrom

setmetatable(MacroMovementFrom,MacroMovementMode)

_ENV = MacroMovementFrom

function MacroMovementFrom:findFunction(textBuffer,cursor,ch)
	local stop <const> = textBuffer:findForward(cursor,ch)
	return stop,0
end

return MacroMovementFrom
