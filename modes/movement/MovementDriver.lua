local BaseMode <const> = require('modes.BaseMode')
local MovementFrom <const> = require('modes.movement.MovementFrom')
local MovementFromBackwards <const> = require('modes.movement.MovementFromBackwards')
local MovementTo <const> = require('modes.movement.MovementTo')
local MovementToBackwards <const> = require('modes.movement.MovementToBackwards')
local GoToBottomOfFile <const> = require('modes.movement.GoToBottomOfFile')
local GoToMode <const> = require('modes.movement.GoToMode')
local InsertMode <const> = require('modes.InsertMode')
local NormalMode <const> = require('modes.NormalMode')

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

function MovementDriver.moveToEndAndReturnInsertMode(textBuffer,cursor)
	cursor:setX(textBuffer:getLengthOfLine(cursor.y) + 1)
	return InsertMode
end

function MovementDriver.moveToStartReturnInsertMode(cursor)
	cursor:moveToStartOfLine()
	return InsertMode
end

function MovementDriver.moveLeft(cursor)
	cursor:moveLeft()
	return NormalMode
end

function MovementDriver.moveUp(textBuffer,cursor)
	cursor:moveUp()
	cursor:moveXIfOverLimit(textBuffer:getLengthOfLine(cursor:getY()))
	return NormalMode
end

function MovementDriver.moveRight(textBuffer,cursor)
	local limit <const> = textBuffer:getLengthOfLine(cursor.y) + 1
	cursor:moveRightWithLimit(limit)
	return NormalMode
end

function MovementDriver.moveDown(textBuffer,cursor)
	cursor:moveDownWithLimit(textBuffer:getSize())
	cursor:moveXIfOverLimit(textBuffer:getLengthOfLine(cursor:getY()))
	return NormalMode
end

function MovementDriver.moveRightAndReturnInsertMode(textBuffer,cursor)
	MovementDriver.moveRight(textBuffer,cursor)
	return InsertMode
end

return MovementDriver
