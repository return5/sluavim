--[[
	class which represents NormalMode in a VIM editor.
--]]

local BaseMode <const> = require('modes.BaseMode')
local InsertMode <const> = require('modes.InsertMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')

local NormalMode <const> = {
		type = 'NormalMode', deleteModeDriver = "please remember to set this before using this class.",
		yankModeDriver = "please remember to set this before using this class.",
		macroModeDriver = "please remember to set this before using this class."
	}
NormalMode.__index = NormalMode
setmetatable(NormalMode,BaseMode)

_ENV = NormalMode

--TODO delete this once i change is os takeInput is no longer getting reassigned
function NormalMode.reset()
	NormalMode.takeInput = nil
	return NormalMode
end

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

function NormalMode.moveToEndAndReturnInsertMode(textBuffer,_,cursor)
	cursor.x = textBuffer:getLengthOfLine(cursor.y) + 1
	return InsertMode
end


local function moveCursor(findFunc,offset)
	return function(_,textBuffer,cursor)
		local ch <const> = BaseMode.grabInput()
		if ch == KeyMap.ESC then return NormalMode.reset() end
		local stop <const> = findFunc(textBuffer,cursor,ch)
		if stop == -1 then return NormalMode.reset() end
		cursor.x = stop + offset
		return NormalMode.reset()
	end
end

--make these MovementModes
function NormalMode.from(textBuffer)
	NormalMode.takeInput = moveCursor(textBuffer.findForward,0)
	return NormalMode
end

function NormalMode.to(textBuffer)
	NormalMode.takeInput = moveCursor(textBuffer.findForward,-1)
	return NormalMode
end

function NormalMode.fromBackwards(textBuffer)
	NormalMode.takeInput = moveCursor(textBuffer.findBackwards,0)
	return NormalMode
end

function NormalMode.toBackwards(textBuffer)
	NormalMode.takeInput = moveCursor(textBuffer.findBackwards,1)
	return NormalMode
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
	return NormalMode.reset()
end

--make this a ReplaceCharMode
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
		return NormalMode.reset()
	end
	if cursor.x > textBuffer:getLengthOfLine(cursor.y) then
		NormalMode.reset()
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
	return NormalMode.reset()
end

function NormalMode:moveToStartOfLine(_,cursor)
	cursor:moveToStartOfLine()
	return NormalMode.reset()
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

return NormalMode

