local MacroYankTo <const> = require('modes.macro.macroYank.MacroYankTo')
local MacroYankFrom <const> = require('modes.macro.macroYank.MacroYankFrom')
local MacroYankToBackwards <const> = require('modes.macro.macroYank.MacroYankToBackwards')
local MacroYankFromBackwards <const> = require('modes.macro.macroYank.MacroYankFromBackwards')
local MacroYankLine <const> = require('modes.macro.macroYank.MacroYankLine')
local MacroYankToStart <const> = require('modes.macro.macroYank.MacroYankToStart')
local MacroYankToEnd <const> = require('modes.macro.macroYank.MacroYankToEnd')
local BaseMode <const> = require('modes.BaseMode')

local MacroYankModeDriver <const> = {type = "MacroYankModeDriver"}
MacroYankModeDriver.__index = MacroYankModeDriver

setmetatable(MacroYankModeDriver,BaseMode)

_ENV = MacroYankModeDriver

function MacroYankModeDriver.to(_,ch)
	MacroYankModeDriver.insertIntoCurrentRegister(ch)
	return MacroYankTo
end

function MacroYankModeDriver.toBackwards(_,ch)
	MacroYankModeDriver.insertIntoCurrentRegister(ch)
	return MacroYankToBackwards
end

function MacroYankModeDriver.fromBackwards(_,ch)
	MacroYankModeDriver.insertIntoCurrentRegister(ch)
	return MacroYankFromBackwards
end

function MacroYankModeDriver.from(_,ch)
	MacroYankModeDriver.insertIntoCurrentRegister(ch)
	return MacroYankFrom
end

function MacroYankModeDriver.yankEntireLine(textBuffer,ch,cursor)
	MacroYankModeDriver.insertIntoCurrentRegister(ch)
	return MacroYankLine:takeInput(textBuffer,cursor)
end

function MacroYankModeDriver.yankToStart(textBuffer,ch,cursor)
	MacroYankModeDriver.insertIntoCurrentRegister(ch)
	return MacroYankToStart:takeInput(textBuffer,cursor)
end

function MacroYankModeDriver.yankToEnd(textBuffer,ch,cursor)
	MacroYankModeDriver.insertIntoCurrentRegister(ch)
	return MacroYankToEnd:takeInput(textBuffer,cursor)
end

MacroYankModeDriver.keyBindings = {
	t = MacroYankModeDriver.to,
	T = MacroYankModeDriver.toBackwards,
	f = MacroYankModeDriver.from,
	F = MacroYankModeDriver.fromBackwards,
	y = MacroYankModeDriver.yankEntireLine,
	['$'] = MacroYankModeDriver.yankToEnd,
	['^'] = MacroYankModeDriver.yankToStart,
}

return MacroYankModeDriver
