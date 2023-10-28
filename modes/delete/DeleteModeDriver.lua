local DeleteTo <const> = require('modes.delete.DeleteTo')
local DeleteFrom <const> = require('modes.delete.DeleteFrom')
local DeleteToBackwards <const> = require('modes.delete.DeleteToBackwards')
local DeleteFromBackwards <const> = require('modes.delete.DeleteFromBackwards')
local DeleteLine <const> = require('modes.delete.DeleteLine')
local DeleteToStart <const> = require('modes.delete.DeleteToStart')
local DeleteToEnd <const> = require('modes.delete.DeleteToEnd')
local BaseMode <const> = require('modes.BaseMode')

local DeleteModeDriver <const> = {type = "DeleteModeDriver"}
DeleteModeDriver.__index = DeleteModeDriver

setmetatable(DeleteModeDriver,BaseMode)

_ENV = DeleteModeDriver

function DeleteModeDriver.to()
	return DeleteTo
end

function DeleteModeDriver.toBackwards()
	return DeleteToBackwards
end

function DeleteModeDriver.fromBackwards()
	return DeleteFromBackwards
end

function DeleteModeDriver.from()
	return DeleteFrom
end

function DeleteModeDriver.deleteEntireLine(textBuffer,_,cursor)
	return DeleteLine:takeInput(textBuffer,cursor)
end

function DeleteModeDriver.deleteToStart(textBuffer,_,cursor)
	return DeleteToStart:takeInput(textBuffer,cursor)
end

function DeleteModeDriver.deleteToEnd(textBuffer,_,cursor)
	return DeleteToEnd:takeInput(textBuffer,cursor)
end

DeleteModeDriver.keyBindings = {
	t = DeleteModeDriver.to,
	T = DeleteModeDriver.toBackwards,
	f = DeleteModeDriver.from,
	F = DeleteModeDriver.fromBackwards,
	d = DeleteModeDriver.deleteEntireLine,
	['$'] = DeleteModeDriver.deleteToEnd,
	['^'] = DeleteModeDriver.deleteToStart,
}

return DeleteModeDriver
