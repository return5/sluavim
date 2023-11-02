local MovementMode <const> = require('modes.movement.MovementMode')
local io = io

local MovementFromBackwards <const> = {type = "MovementFromBackwards"}
MovementFromBackwards.__index = MovementFromBackwards

setmetatable(MovementFromBackwards,MovementMode)

_ENV = MovementFromBackwards

function MovementFromBackwards:findFunction(textBuffer,cursor,ch)
	local stop <const> = textBuffer:findBackwards(cursor,ch)
	io.write("start is: ",cursor.x," stop is: ",stop,"\n")
	return stop,0
end

return MovementFromBackwards
