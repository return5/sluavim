local BaseMode <const> = require('modes.BaseMode')
local InsertMode <const> = require('modes.InsertMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')

local NormalMode <const> = {type = 'normalmode'}
NormalMode.__index = NormalMode
setmetatable(NormalMode,BaseMode)

_ENV = NormalMode

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

function NormalMode.endMacro()
	BaseMode.parseInput = BaseMode.regularParseInput
	NormalMode.keyBindings['q'] = NormalMode.setMacro
	BaseMode.currentRegister = ""
	return NormalMode
end

function NormalMode.setMacro()
	BaseMode.parseInput = BaseMode.macroParseInputSetRegister
	NormalMode.keyBindings['q'] = NormalMode.endMacro
	return NormalMode
end

function NormalMode.runMacro(textBuffer,_,cursor)
	BaseMode.runMacro(NormalMode,textBuffer,cursor)
	return NormalMode
end

local function moveCursor(findFunc,offset)
	return function(_,textBuffer,cursor)
		local ch <const> = BaseMode.grabInput()
		if ch == KeyMap.ESC then return NormalMode.reset() end
		local stop <const> = findFunc(textBuffer,cursor,ch)
		if stop == -1 then return NormalMode end
		cursor.x = stop + offset
		return NormalMode.reset()
	end
end

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
	return NormalMode.deleteMode
end

function NormalMode.deleteCurrentChar(textBuffer,_,cursor)
	NormalMode.deleteMode.deleteCurrentChar(textBuffer,cursor)
	if cursor.x > textBuffer:getLengthOfLine(cursor.y) then
		cursor:moveLeft()
	end
	if cursor.x <= 0 then cursor.x = 1 end
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

function NormalMode.replaceCurrentChar()
	 NormalMode.takeInput = NormalMode.takeInputReplaceChar
	return NormalMode
end

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

local function normalModeMoveToEndOfLine(_,textBuffer,cursor)
	cursor.x = textBuffer:getLengthOfLine(cursor.y)
	return NormalMode.reset()
end

function NormalMode.moveToEndOfLine()
	NormalMode.takeInput = normalModeMoveToEndOfLine
	return NormalMode
end

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
	q = NormalMode.setMacro,
	['@'] = NormalMode.runMacro,
	t = NormalMode.to,
	T = NormalMode.toBackwards,
	f = NormalMode.from,
	F = NormalMode.fromBackwards,
	d = NormalMode.delete,
	x = NormalMode.deleteCurrentChar,
	X = NormalMode.deletePrevChar,
	r = NormalMode.replaceCurrentChar,
	R = NormalMode.replaceCharacters,
	o = NormalMode.insertNewLine,
	O = NormalMode.insertNewLineAbove,
	p = NormalMode.pasteRegister,
	['$'] = NormalMode.moveToEndOfLine
	--TODO :,y,P,~,d
}

return NormalMode

