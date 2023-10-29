--[[
	class which represents NormalMode in a VIM editor.
--]]

local BaseMode <const> = require('modes.BaseMode')
local InsertMode <const> = require('modes.InsertMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')
local io = io

local NormalMode <const> = {
		type = 'NormalMode', deleteModeDriver = "please remember to set this before using this class.",
		yankModeDriver = "please remember to set this before using this class.",
		macroModeDriver = "please remember to set this before using this class.",
		movementDriver = "please remember to set this before using this class."
	}
NormalMode.__index = NormalMode

setmetatable(NormalMode,BaseMode)

_ENV = NormalMode

function NormalMode.default()
	return NormalMode
end

function NormalMode.returnInsertMode()
	return InsertMode
end

function NormalMode.moveToStartReturnInsertMode(_,_,cursor)
	cursor:moveToStartOfLine()
	return InsertMode
end

function NormalMode.moveLeft(_,_,cursor)
	cursor:moveLeft()
	return NormalMode
end

function NormalMode.moveUp(_,_,cursor)
	cursor:moveUp()
	return NormalMode
end

function NormalMode.moveRight(textBuffer,_,cursor)
	local limit <const> = textBuffer:getLengthOfLine(cursor.y) + 1
	cursor:moveRightWithLimit(limit)
	return NormalMode
end

function NormalMode.moveDown(textBuffer,_,cursor)
	local limit <const> = textBuffer:getSize()
	cursor:moveDownWithLimit(limit)
	return NormalMode
end

function NormalMode.moveRightAndReturnInsertMode(textBuffer,_,cursor)
	NormalMode.moveRight(textBuffer,nil,cursor)
	return InsertMode
end

function NormalMode.returnInsertMode()
	return InsertMode
end

function NormalMode.returnNormalMode()
	return NormalMode
end

function NormalMode.moveToEndAndReturnInsertMode(textBuffer,_,cursor)
	cursor.x = textBuffer:getLengthOfLine(cursor.y) + 1
	return InsertMode
end
--make these MovementModes
function NormalMode.from()
	return NormalMode.movementDriver.from()
end

function NormalMode.to()
	return NormalMode.movementDriver.to()
end

function NormalMode.fromBackwards()
	return NormalMode.movementDriver.fromBackwards()
end

function NormalMode.toBackwards()
	return NormalMode.movementDriver.toBackwards()
end

function NormalMode.delete()
	return NormalMode.deleteModeDriver
end

function NormalMode.yank()
	return NormalMode.yankModeDriver
end

function NormalMode.deleteCurrentChar(textBuffer,_,cursor)
	NormalMode.deleteMode.deleteCurrentChar(textBuffer,cursor)
	cursor:limitXToLengthOfLine(textBuffer)
	return NormalMode
end

function NormalMode.deletePrevChar(textBuffer,_,cursor)
	cursor:moveLeft()
	if cursor.x <= 0 then cursor.x = 1 end
	NormalMode.deleteMode.deleteCurrentChar(textBuffer,cursor)
	return NormalMode
end

local function replaceChar(textBuffer,cursor)
	local ch <const> = BaseMode.grabInput()
	if ch ~= KeyMap.ESC then
		textBuffer:replaceCharAt(ch,cursor)
		return true
	end
	return false
end

function NormalMode:takeInputReplaceChar(textBuffer,cursor)
	replaceChar(textBuffer,cursor)
	return NormalMode.returnNormalMode()
end

--TODO make this a ReplaceCharMode
function NormalMode.replaceCurrentChar()
	 NormalMode.takeInput = NormalMode.takeInputReplaceChar
	return NormalMode
end

--make this a ContinuousReplaceMode
function NormalMode:takeInputContinualReplaceChars(textBuffer,cursor)
	local returnVal <const> = replaceChar(textBuffer,cursor)
	if returnVal then
		cursor:moveRight()
	else
		return NormalMode.returnNormalMode()
	end
	if cursor.x > textBuffer:getLengthOfLine(cursor.y) then
		NormalMode.returnNormalMode()
		return NormalMode.returnInsertMode()
	end
	return NormalMode
end

function NormalMode.replaceCharacters()
	NormalMode.takeInput = NormalMode.takeInputContinualReplaceChars
	return NormalMode
end

function NormalMode.insertNewLine(textBuffer,_,cursor)
	return NormalMode.returnInsertMode().newLine(textBuffer,nil,cursor)
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

function NormalMode.returnSetMacroRegisterMode()
	return NormalMode.macroModeDriver.setRegister()
end

function NormalMode.runMacro()
	return NormalMode.macroModeDriver.runMacro()
end

--TODO test this.  move pasting to a mode
function NormalMode.pasteRegister(textBuffer,_,cursor)
	local registerName <const> = BaseMode.currentRegister ~= "" and BaseMode.currentRegister or 1
	local register <const> = BaseMode.registers[registerName]
	local insertMode <const> = NormalMode.returnInsertMode()
	if #register > 0 then
		cursor:moveRight()
	end
	for i=1,#register,1 do
		insertMode.insertChar(textBuffer,register[i],cursor)
	end
	return NormalMode
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
	q = NormalMode.returnSetMacroRegisterMode,
	['@'] = NormalMode.runMacro,
	t = NormalMode.to,
	T = NormalMode.toBackwards,
	f = NormalMode.from,
	F = NormalMode.fromBackwards,
	d = NormalMode.delete,
	D = NormalMode.deleteTilEnd,
	x = NormalMode.deleteCurrentChar,
	X = NormalMode.deletePrevChar,
	r = NormalMode.replaceCurrentChar,
	R = NormalMode.replaceCharacters,
	o = NormalMode.insertNewLine,
	O = NormalMode.insertNewLineAbove,
	p = NormalMode.pasteRegister,
	['$'] = NormalMode.moveToEndOfLine,
	['^'] = NormalMode.moveToStartOfLine,
	y = NormalMode.yank
	--TODO :,y,P,~,"
}

function NormalMode.setDeleteModeDriver(deleteModeDriver)
	NormalMode.deleteModeDriver = deleteModeDriver
	return NormalMode
end

function NormalMode.setYankModeDriver(yankModeDriver)
	NormalMode.yankModeDriver = yankModeDriver
	return NormalMode
end

function NormalMode.setMacroModeDriver(macroModeDriver)
	NormalMode.macroModeDriver = macroModeDriver
	return NormalMode
end

function NormalMode.setMovementDriver(movementDriver)
	NormalMode.movementDriver = movementDriver
	return NormalMode
end

return NormalMode

