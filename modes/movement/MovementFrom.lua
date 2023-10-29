local MovementMode <const> = require('modes.movement.MovementMode')

local MovementFrom <const> = {type = "MovementFrom"}
MovementFrom.__index = MovementFrom

setmetatable(MovementFrom,MovementMode)

_ENV = MovementFrom

function MovementFrom:findFunction(textBuffer,cursor,ch)
	local stop <const> = textBuffer:findForward(cursor,ch)
	return stop,0
end

return MovementFrom
