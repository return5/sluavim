--[[
	class for delete mode. handles deleting text from a textBuffer when using 'd' commands in NormalMode and VisualSelect mode
--]]

local DeleteToBackwards <const> = require('modes.deleteAndYank.delete.DeleteToBackwards')
local DeleteFromBackwards <const> = require('modes.deleteAndYank.delete.DeleteFromBackwards')
local DeleteFrom <const> = require('modes.deleteAndYank.delete.DeleteFrom')
local DeleteLine <const> = require('modes.deleteAndYank.delete.DeleteLine')
local DeleteToStart <const> = require('modes.deleteAndYank.delete.DeleteToStart')
local DeleteToEnd <const> = require('modes.deleteAndYank.delete.DeleteToEnd')
local DeleteWord <const> = require('modes.deleteAndYank.delete.DeleteWord')
local DeleteWordBackwards <const> = require('modes.deleteAndYank.delete.DeleteWordBackwards')
local DeleteAndYankParent <const> = require('modes.deleteAndYank.DeleteAndYankParent')
local BaseMode <const> = require('modes.BaseMode')
local NormalMode <const> = require('modes.NormalMode')
local DeleteTo <const> = require('modes.deleteAndYank.delete.DeleteTo')

local pairs <const> = pairs

local DeleteModeDriver <const> = {type = "DeleteModeDriver"}
DeleteModeDriver.__index = DeleteModeDriver
setmetatable(DeleteModeDriver,BaseMode)

_ENV = DeleteModeDriver

function DeleteModeDriver.action()
	return NormalMode
end

function DeleteModeDriver:default()
	return NormalMode
end

function DeleteModeDriver.deleteTo()
	return DeleteTo
end

function DeleteModeDriver.deleteToBackwards()
	return DeleteToBackwards
end

function DeleteModeDriver.deleteFromBackwards()
	return DeleteFromBackwards
end

function DeleteModeDriver.deleteFrom()
	return DeleteFrom
end

function DeleteModeDriver.deleteLine(textBuffer,_,cursor)
	return DeleteLine:deleteLine(textBuffer,cursor)
end

function DeleteModeDriver.deleteTilStart(textBuffer,_,cursor)
	return DeleteToStart:deleteToStart(textBuffer,cursor)
end

function DeleteModeDriver.deleteTilEnd(textBuffer,_,cursor)
	return DeleteToEnd:deleteToEnd(textBuffer,cursor)
end

function DeleteModeDriver.deleteWord(textBuffer,_,cursor)
	return DeleteWord:deleteWord(textBuffer,cursor)
end

function DeleteModeDriver.deleteWordBackwards(textBuffer,_,cursor)
	return DeleteWordBackwards:deleteWordBackwards(textBuffer,cursor)
end

DeleteModeDriver.keyBindings = {
	d = DeleteModeDriver.deleteLine,
	t = DeleteModeDriver.deleteTo,
	T = DeleteModeDriver.deleteToBackwards,
	f = DeleteModeDriver.deleteFrom,
	F = DeleteModeDriver.deleteFromBackwards,
	['$'] = DeleteModeDriver.deleteTilEnd,
	['^'] = DeleteModeDriver.deleteTilStart,
	w = DeleteModeDriver.deleteWord,
	W = DeleteModeDriver.deleteWordBackwards
}

for key,func in pairs(DeleteAndYankParent.keyBindings) do
	DeleteModeDriver.keyBindings[key] = func
end

return DeleteModeDriver
