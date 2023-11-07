--[[
	class which represents NormalMode in a VIM editor.
--]]

local BaseMode <const> = require('modes.BaseMode')
local InsertMode <const> = require('modes.InsertMode')
local PasteRegisterMode <const> = require('modes.miscModes.PasteRegisterMode')

local toByte <const> = string.byte
local upper <const> = string.upper
local lower <const> = string.lower

local NormalMode <const> = {type = 'NormalMode' }
NormalMode.__index = NormalMode

setmetatable(NormalMode,BaseMode)

_ENV = NormalMode

local aByte <const> = toByte('a',1,1)
local zByte <const> = toByte('z',1,1)
local AByte <const> = toByte('A',1,1)
local ZByte <const> = toByte('Z',1,1)

function NormalMode.default()
	return NormalMode
end

function NormalMode.returnInsertMode()
	return InsertMode
end

function NormalMode.moveToStartReturnInsertMode(_,_,cursor)
	return InsertMode.movementDriver.moveToStartAndREturnInsertMode(cursor)
end

function NormalMode.moveLeft(_,_,cursor)
	return NormalMode.movementDriver.moveLeft(cursor)
end

function NormalMode.moveUp(textBuffer,_,cursor)
	return NormalMode.movementDriver.moveUp(textBuffer,cursor)
end

function NormalMode.moveRight(textBuffer,_,cursor)
	return NormalMode.movementDriver.moveRight(textBuffer,cursor)
end

function NormalMode.moveDown(textBuffer,_,cursor)
	return NormalMode.movementDriver.moveDown(textBuffer,cursor)
end

function NormalMode.moveRightAndReturnInsertMode(textBuffer,_,cursor)
	return NormalMode.movementDriver.moveRightAndReturnInsertMode(textBuffer,cursor)
end

--TODO check this in movementdriver
function NormalMode.moveToEndAndReturnInsertMode(textBuffer,_,cursor)
	cursor:setX(textBuffer:getLengthOfLine(cursor.y) + 1)
	return InsertMode
end

function NormalMode.returnNormalMode()
	return NormalMode
end

function NormalMode.delete()
	return NormalMode.deleteModeDriver
end

function NormalMode.yank()
	return NormalMode.yankModeDriver
end

function NormalMode.deleteCurrentChar(textBuffer,_,cursor)
	NormalMode.deleteModeDriver.deleteCurrentChar(textBuffer,cursor)
	return NormalMode
end

function NormalMode.deletePrevChar(textBuffer,_,cursor)
	NormalMode.deleteModeDriver.deletePrevChar(textBuffer,cursor)
	return NormalMode
end

function NormalMode.insertNewLineBelowAndReturnInsertMode(textBuffer,_,cursor)
	return NormalMode.returnInsertMode().insertNewLineBelowAndReturnInsertMode(textBuffer,nil,cursor)
end

function NormalMode.insertNewLineAbove(textBuffer,_,cursor)
	return NormalMode.returnInsertMode().newLineAbove(textBuffer,nil,cursor)
end

function NormalMode:moveToEndOfLine(textBuffer,cursor)
	cursor:moveToEndOfLine(textBuffer)
	return NormalMode.returnNormalMode()
end

function NormalMode:moveToStartOfLine(_,cursor)
	cursor:moveToStartOfLine()
	return NormalMode.returnNormalMode()
end

function NormalMode.deleteTilEnd(textBuffer,_,cursor)
	return NormalMode.deleteModeDriver.deleteToEnd(textBuffer,_,cursor)
end

function NormalMode.pasteRegister(textBuffer,_,cursor)
	PasteRegisterMode:pasteRegister(textBuffer,cursor)
	return NormalMode
end

function NormalMode.pasteRegisterAbove(textBuffer,_,cursor)
	NormalMode.insertNewLineAbove(textBuffer,nil,cursor)
	return NormalMode.pasteRegister(textBuffer,nil,cursor)
end

function NormalMode.moveCursorToBottomOfFile(textBuffer,_,cursor)
	return NormalMode.movementDriver.moveCursorToBottomOfFile(textBuffer,cursor)
end

function NormalMode.returnGoToMode()
	return NormalMode.movementDriver.returnGoToMode()
end

local function lowerCaseToUpperAndUpperTOLowerCase(ch)
	local byte <const> = toByte(ch,1,1)
	if byte >= aByte and byte <= zByte then return upper(ch) end
	if byte >= AByte and byte <= ZByte then return lower(ch) end
	return ch
end

function NormalMode.toggleCase(textBuffer,_,cursor)
	local ch <const> = textBuffer:getCharAtCursor(cursor)
	local replacementCh <const> = lowerCaseToUpperAndUpperTOLowerCase(ch)
	textBuffer:replaceCharAt(replacementCh,cursor)
	cursor:moveRightWithLimit(textBuffer:getLengthOfLine(cursor.y))
	return NormalMode
end

function NormalMode.to()
	return NormalMode.movementDriver.to()
end

function NormalMode.toBackwards()
	return NormalMode.movementDriver.toBackwards()
end

function NormalMode.from()
	return NormalMode.movementDriver.from()
end

function NormalMode.fromBackwards()
	return NormalMode.movementDriver.fromBackwards()
end

function NormalMode.returnColonMode()
	return NormalMode.colonMode.startColonMode()
end

function NormalMode.digit(textBuffer,ch,cursor)
	return NormalMode.setRepeatMode:parseInput(ch,textBuffer,cursor)
end

function NormalMode.setCurrentRegisterName()
	return NormalMode.setRegisterMode
end

function NormalMode.replaceCurrentChar()
	return NormalMode.replacementDriver.replaceChar()
end

function NormalMode.continuousReplaceChar()
	return NormalMode.replacementDriver.continuousReplacement()
end

function NormalMode.setMacro()
	return NormalMode.macroMode.returnSetMacroMode()
end

function NormalMode.runMacro()
	return NormalMode.macroMode.returnRunMacroMode()
end

NormalMode.keyBindings = {
	a = NormalMode.moveRightAndReturnInsertMode,
	A = NormalMode.moveToEndAndReturnInsertMode,
	i = NormalMode.returnInsertMode,
	I = NormalMode.moveToStartReturnInsertMode,
	h = NormalMode.moveLeft,
	j = NormalMode.moveDown,
	k = NormalMode.moveUp,
	l = NormalMode.moveRight,
	d = NormalMode.delete,
	D = NormalMode.deleteTilEnd,
	x = NormalMode.deleteCurrentChar,
	X = NormalMode.deletePrevChar,
	o = NormalMode.insertNewLineBelowAndReturnInsertMode,
	O = NormalMode.insertNewLineAbove,
	p = NormalMode.pasteRegister,
	['$'] = NormalMode.moveToEndOfLine,
	['^'] = NormalMode.moveToStartOfLine,
	['~'] = NormalMode.toggleCase,
	y = NormalMode.yank,
	G = NormalMode.moveCursorToBottomOfFile,
	g = NormalMode.returnGoToMode,
	t = NormalMode.to,
	T = NormalMode.toBackwards,
	f = NormalMode.from,
	F = NormalMode.fromBackwards,
	[':'] = NormalMode.returnColonMode,
	['0'] = NormalMode.digit,
	['1'] = NormalMode.digit,
	['2'] = NormalMode.digit,
	['3'] = NormalMode.digit,
	['4'] = NormalMode.digit,
	['5'] = NormalMode.digit,
	['6'] = NormalMode.digit,
	['7'] = NormalMode.digit,
	['8'] = NormalMode.digit,
	['9'] = NormalMode.digit,
	['"'] = NormalMode.setCurrentRegisterName,
	r = NormalMode.replaceCurrentChar,
	R = NormalMode.continuousReplaceChar,
	q = NormalMode.setMacro,
	['@'] = NormalMode.runMacro
} --TODO v,u,^r

function NormalMode.setDrivers(replaceDriver,movementDriver,yankModeDriver,deleteModeDriver,colonMode,setRepeatMode,setRegisterMode,macroMode)
	NormalMode.movementDriver = movementDriver
	NormalMode.replacementDriver = replaceDriver
	NormalMode.deleteModeDriver = deleteModeDriver
	NormalMode.yankModeDriver = yankModeDriver
	NormalMode.colonMode = colonMode
	NormalMode.setRepeatMode = setRepeatMode
	NormalMode.setRegisterMode = setRegisterMode
	NormalMode.macroMode = macroMode
end

return NormalMode

