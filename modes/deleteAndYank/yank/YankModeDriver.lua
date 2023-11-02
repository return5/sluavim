local YankTo <const> = require('modes.deleteAndYank.yank.YankTo')
local YankFrom <const> = require('modes.deleteAndYank.yank.YankFrom')
local YankToBackwards <const> = require('modes.deleteAndYank.yank.YankToBackwards')
local YankFromBackwards <const> = require('modes.deleteAndYank.yank.YankFromBackwards')
local YankLine <const> = require('modes.deleteAndYank.yank.YankLine')
local YankToStart <const> = require('modes.deleteAndYank.yank.YankToStart')
local YankToEnd <const> = require('modes.deleteAndYank.yank.YankToEnd')
local YankWord <const> = require('modes.deleteAndYank.yank.YankWord')
local YankWordBackwards <const> = require('modes.deleteAndYank.yank.YankWordBackwards')
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
	return YankLine:yankLine(textBuffer,cursor)
end

function YankModeDriver.yankToStart(textBuffer,_,cursor)
	return YankToStart:yankToStart(textBuffer,cursor)
end

function YankModeDriver.yankToEnd(textBuffer,_,cursor)
	return YankToEnd:yankToEnd(textBuffer,cursor)
end

function YankModeDriver.yankWord(textBuffer,_,cursor)
	return YankWord:yankWord(textBuffer,cursor)
end

function YankModeDriver.yankWOrdBackwards(textBuffer,_,cursor)
	return YankWordBackwards:yankWordBackwards(textBuffer,cursor)
end

YankModeDriver.keyBindings = {
	t = YankModeDriver.to,
	T = YankModeDriver.toBackwards,
	f = YankModeDriver.from,
	F = YankModeDriver.fromBackwards,
	y = YankModeDriver.yankEntireLine,
	['$'] = YankModeDriver.yankToEnd,
	['^'] = YankModeDriver.yankToStart,
	w = YankModeDriver.yankWord,
	W = YankModeDriver.yankWOrdBackwards
}

return YankModeDriver
