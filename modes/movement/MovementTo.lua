local MovementMode <const> = require('modes.movement.MovementMode')

local MovementTo <const> = {type = "MovementTo"}
MovementTo.__index = MovementTo

setmetatable(MovementTo,MovementMode)

_ENV = MovementTo

function MovementTo:findFunction(textBuffer,cursor,ch)
	local stop <const> = textBuffer:findForward(cursor,ch)
	return stop,-1
end

return MovementTo
