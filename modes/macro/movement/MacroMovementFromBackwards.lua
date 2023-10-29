local MacroMovementMode <const> = require('modes.macro.movement.MacroMovementMode')

local MacroMovementFromBackwards <const> = {type = "MacroMovementFromBackwards"}
MacroMovementFromBackwards.__index = MacroMovementFromBackwards

setmetatable(MacroMovementFromBackwards,MacroMovementMode)

_ENV = MacroMovementFromBackwards

function MacroMovementFromBackwards:findFunction(textBuffer,cursor,ch)
	local stop <const> = textBuffer:findBackwards(cursor,ch)
	return stop,0
end

return MacroMovementFromBackwards
