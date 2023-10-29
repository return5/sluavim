local MacroMovementMode <const> = require('modes.macro.movement.MacroMovementMode')

local MacroMovementToBackwards <const> = {type = "MacroMovementToBackwards"}
MacroMovementToBackwards.__index = MacroMovementToBackwards

setmetatable(MacroMovementToBackwards,MacroMovementMode)

_ENV = MacroMovementToBackwards

function MacroMovementToBackwards:findFunction(textBuffer,cursor,ch)
	local stop <const> = textBuffer:findBackwards(cursor,ch)
	return stop,1
end

return MacroMovementToBackwards
