local MovementMode <const> = require('modes.movement.MovementMode')

local GoToTopOfFile <const> = {type = "GoToTopOfFile"}
GoToTopOfFile.__index = GoToTopOfFile
setmetatable(GoToTopOfFile,MovementMode)

_ENV = GoToTopOfFile

function GoToTopOfFile:findFunction(_,cursor)
	cursor:moveYTo(1,1)
	return 1,0
end

function GoToTopOfFile:goToTopOfFile(cursor)
	return self:move(nil,cursor)
end

return GoToTopOfFile
