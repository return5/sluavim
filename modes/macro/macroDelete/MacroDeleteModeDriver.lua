local MacroDeleteTo <const> = require('modes.macro.macroDelete.MacroDeleteTo')
local MacroDeleteFrom <const> = require('modes.macro.macroDelete.MacroDeleteFrom')
local MacroDeleteToBackwards <const> = require('modes.macro.macroDelete.MacroDeleteToBackwards')
local MacroDeleteFromBackwards <const> = require('modes.macro.macroDelete.MacroDeleteFromBackwards')
local MacroDeleteLine <const> = require('modes.macro.macroDelete.MacroDeleteLine')
local MacroDeleteToStart <const> = require('modes.macro.macroDelete.MacroDeleteToStart')
local MacroDeleteToEnd <const> = require('modes.macro.macroDelete.MacroDeleteToEnd')
local MacroDeleteWord <const> = require('modes.macro.macroDelete.MacroDeleteWord')
local MacroDeleteWordBackwards <const> = require('modes.macro.macroDelete.MacroDeleteWordBackwards')
local BaseMode <const> = require('modes.BaseMode')

local MacroDeleteModeDriver <const> = {type = "MacroDeleteModeDriver"}
MacroDeleteModeDriver.__index = MacroDeleteModeDriver

setmetatable(MacroDeleteModeDriver,BaseMode)

_ENV = MacroDeleteModeDriver

function MacroDeleteModeDriver.to()
	return MacroDeleteTo
end

function MacroDeleteModeDriver.toBackwards()
	return MacroDeleteToBackwards
end

function MacroDeleteModeDriver.fromBackwards()
	return MacroDeleteFromBackwards
end

function MacroDeleteModeDriver.from()
	return MacroDeleteFrom
end

function MacroDeleteModeDriver.deleteEntireLine(textBuffer,_,cursor)
	return MacroDeleteLine:takeInput(textBuffer,cursor)
end

function MacroDeleteModeDriver.deleteToStart(textBuffer,_,cursor)
	return MacroDeleteToStart:takeInput(textBuffer,cursor)
end

function MacroDeleteModeDriver.deleteToEnd(textBuffer,_,cursor)
	return MacroDeleteToEnd:takeInput(textBuffer,cursor)
end

function MacroDeleteModeDriver.deleteWordForward(textBuffer,_,cursor)
	return MacroDeleteWord:takeInput(textBuffer,cursor)
end

function MacroDeleteModeDriver.deleteWordForward(textBuffer,_,cursor)
	return MacroDeleteWordBackwards:takeInput(textBuffer,cursor)
end

MacroDeleteModeDriver.keyBindings = {
	t = MacroDeleteModeDriver.to,
	T = MacroDeleteModeDriver.toBackwards,
	f = MacroDeleteModeDriver.from,
	F = MacroDeleteModeDriver.fromBackwards,
	d = MacroDeleteModeDriver.deleteEntireLine,
	['$'] = MacroDeleteModeDriver.deleteToEnd,
	['^'] = MacroDeleteModeDriver.deleteToStart,
	w = MacroDeleteModeDriver.deleteWordForward,
	W = MacroDeleteModeDriver.deleteWordBackwards
	--add dw
}

return MacroDeleteModeDriver
