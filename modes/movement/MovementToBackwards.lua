local MovementMode <const> = require('modes.movement.MovementMode')

local MovementToBackwards <const> = {type = "MovementToBackwards"}
MovementToBackwards.__index = MovementToBackwards

setmetatable(MovementToBackwards,MovementMode)

_ENV = MovementToBackwards

function MovementToBackwards:findFunction(textBuffer,cursor,ch)
	local stop <const> = textBuffer:findBackwards(cursor,ch)
	return stop,1
end

return MovementToBackwards
