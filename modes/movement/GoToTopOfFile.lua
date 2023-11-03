local MovementMode <const> = require('modes.movement.MovementMode')
local io = io


local GoToTopOfFile <const> = {type = "GoToTopOfFile"}
GoToTopOfFile.__index = GoToTopOfFile
setmetatable(GoToTopOfFile,MovementMode)

_ENV = GoToTopOfFile

function GoToTopOfFile:findFunction(_,cursor)
	cursor:moveYTo(1)
	return 1,0
end

function GoToTopOfFile:goToTopOfFile(cursor)
	io.write("going to top\n")
	return self:move(nil,cursor)
end

return GoToTopOfFile
