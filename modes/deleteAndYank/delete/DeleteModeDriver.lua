--[[
	class for delete mode. handles deleting text from a textBuffer when using 'd' commands in NormalMode and VisualSelect mode
--]]

--local DeleteFrom <const> = require('modes.deleteAndYank.delete.DeleteFrom')
local DeleteToBackwards <const> = require('modes.deleteAndYank.delete.DeleteToBackwards')
local DeleteFromBackwards <const> = require('modes.deleteAndYank.delete.DeleteFromBackwards')
local DeleteMode <const> = require('modes.deleteAndYank.delete.DeleteMode')
--local ToDelete <const> = require('modes.deleteAndYank.delete.ToDelete')
--local DeleteLine <const> = require('modes.delete.DeleteLine')
--local DeleteToStart <const> = require('modes.delete.DeleteToStart')
--local DeleteToEnd <const> = require('modes.delete.DeleteToEnd')
--local DeleteWord <const> = require('modes.delete.DeleteWord')
--local DeleteWordBackwards <const> = require('modes.delete.DeleteWordBackwards')
local DeleteAndYankParent <const> = require('modes.deleteAndYank.DeleteAndYankParent')
local BaseMode <const> = require('modes.BaseMode')
local NormalMode <const> = require('modes.NormalMode')
local pairs <const> = pairs

local DeleteModeDriver <const> = {type = "DeleteModeDriver"}
DeleteModeDriver.__index = DeleteModeDriver
setmetatable(DeleteModeDriver,BaseMode)

_ENV = DeleteModeDriver

function DeleteModeDriver.action()
	return NormalMode
--	textBuffer:removeChars(startChar,stopChar,y,register)
	--return DeleteModeDriver
end

function DeleteModeDriver:default()
	return NormalMode
end

function DeleteModeDriver.deleteTo()
	return ToDelete
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

function DeleteModeDriver.deleteLine()
	return DeleteLine
end

function DeleteModeDriver.deleteTilStart()
	return DeleteToStart
end

function DeleteModeDriver.deleteTilEnd()
	return DeleteToEnd
end

function DeleteModeDriver.deleteWord()
	return DeleteWord
end

function DeleteModeDriver.deleteWordBackwards()
	return DeleteWordBackwards
end

DeleteModeDriver.keyBindings = {
	d = DeleteModeDriver.deleteLine,
	t = DeleteModeDriver.deleteTo,
	T = DeleteModeDriver.deleteToBackwards,
	f = DeleteModeDriver.deleteFrom,
	F = DeleteModeDriver.deleteFromBackwards,
	['$'] = DeleteModeDriver.deleteTilEnd,
	['^'] = DeleteModeDriver.deleteTileStart,
	w = DeleteModeDriver.deleteWord,
	W = DeleteModeDriver.deleteWordBackwards
}

for key,func in pairs(DeleteAndYankParent.keyBindings) do
	DeleteModeDriver.keyBindings[key] = func
end

return DeleteModeDriver
