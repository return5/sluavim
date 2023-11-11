local MovementMode <const> = require('modes.movement.MovementMode')

local GoToBottomOfFile <const> = {type = "GoToBottomOfFile"}
GoToBottomOfFile.__index = GoToBottomOfFile
setmetatable(GoToBottomOfFile,MovementMode)

function GoToBottomOfFile:findFunction(textBuffer,cursor)
	local bottom <const> = textBuffer:getSize()
	cursor:moveYTo(bottom,bottom)
	return 1,0
end

return GoToBottomOfFile
