local YankTo <const> = require('modes.yank.YankTo')
local YankFrom <const> = require('modes.yank.YankFrom')
local YankToBackwards <const> = require('modes.yank.YankToBackwards')
local YankFromBackwards <const> = require('modes.yank.YankFromBackwards')
local YankLine <const> = require('modes.yank.YankLine')
local YankToStart <const> = require('modes.yank.YankToStart')
local YankToEnd <const> = require('modes.yank.YankToEnd')
local BaseMode <const> = require('modes.BaseMode')

local YankModeDriver <const> = {type = "YankModeDriver"}
YankModeDriver.__index = YankModeDriver

setmetatable(YankModeDriver,BaseMode)

_ENV = YankModeDriver

function YankModeDriver.to()
	return YankTo
end

function YankModeDriver.toBackwards()
	return YankToBackwards
end

function YankModeDriver.fromBackwards()
	return YankFromBackwards
end

function YankModeDriver.from()
	return YankFrom
end

function YankModeDriver.yankEntireLine(textBuffer,_,cursor)
	return YankLine:takeInput(textBuffer,cursor)
end

function YankModeDriver.yankToStart(textBuffer,_,cursor)
	return YankToStart:takeInput(textBuffer,cursor)
end

function YankModeDriver.yankToEnd(textBuffer,_,cursor)
	return YankToEnd:takeInput(textBuffer,cursor)
end

YankModeDriver.keyBindings = {
	t = YankModeDriver.to,
	T = YankModeDriver.toBackwards,
	f = YankModeDriver.from,
	F = YankModeDriver.fromBackwards,
	y = YankModeDriver.yankEntireLine,
	['$'] = YankModeDriver.yankToEnd,
	['^'] = YankModeDriver.yankToStart,
}

return YankModeDriver
