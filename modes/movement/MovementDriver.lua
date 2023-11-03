local BaseMode <const> = require('modes.BaseMode')
local MovementFrom <const> = require('modes.movement.MovementFrom')
local MovementFromBackwards <const> = require('modes.movement.MovementFromBackwards')
local MovementTo <const> = require('modes.movement.MovementTo')
local MovementToBackwards <const> = require('modes.movement.MovementToBackwards')
local GoToBottomOfFile <const> = require('modes.movement.GoToBottomOfFile')
local GoToMode <const> = require('modes.movement.GoToMode')

local MovementDriver <const> = {type = "MovementDriver"}
MovementDriver.__index = MovementDriver

setmetatable(MovementDriver,BaseMode)

_ENV = MovementDriver

function MovementDriver.from()
	return MovementFrom
end

function MovementDriver.to()
	return MovementTo
end

function MovementDriver.fromBackwards()
	return MovementFromBackwards
end

function MovementDriver.toBackwards()
	return MovementToBackwards
end

function MovementDriver.moveCursorToBottomOfFile(textBuffer,cursor)
	return GoToBottomOfFile:move(textBuffer,cursor)
end

function MovementDriver.returnGoToMode()
	return GoToMode
end

return MovementDriver
