local NormalMode <const> = require('modes.NormalMode')
local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')
local io = io

local DeleteAndYankParent <const> = {type = "deleteandyankparent"}
DeleteAndYankParent.__index = DeleteAndYankParent

_ENV = DeleteAndYankParent

function DeleteAndYankParent:action()
	return DeleteAndYankParent.returnDeleteAndYankParent()
end

function DeleteAndYankParent.returnNormalMode()
	return NormalMode
end

function DeleteAndYankParent:deleteOrYankCharacters(textBuffer,cursor,start)
	BaseMode.adjustRegister()
	local register <const> = {}
	local startChar <const> = start <= cursor.x and start or cursor.x
	local stopChar <const> = cursor.x >= start and cursor.x or start
	self.action(textBuffer,startChar,stopChar,cursor.y,register)
	BaseMode.setFirstRegister(register)
	self.doAfter(textBuffer,cursor)
	cursor:limitXToLengthOfLine(textBuffer)
	return DeleteAndYankParent.reset()
end

function DeleteAndYankParent:doAction(textBuffer,cursor)
	local start <const> = cursor.x
	local nextStep <const> = NormalMode:takeInput(textBuffer,cursor)
	return nextStep(self,textBuffer,cursor,start)
end

function DeleteAndYankParent.returnDeleteAndYankParent()
	return DeleteAndYankParent
end

function DeleteAndYankParent.reset()
	DeleteAndYankParent.doAfter = DeleteAndYankParent.returnDeleteAndYankParent
	return NormalMode.reset()
end

function DeleteAndYankParent.doAfterSelectEntireLine(textBuffer,cursor)
	DeleteAndYankParent.doAfter = DeleteAndYankParent.returnDeleteAndYankParent
	textBuffer:removeLineAt(cursor.y)
	cursor:limitYToSizeOfTextBuffer(textBuffer)
	return DeleteAndYankParent.returnDeleteAndYankParent()
end

local function moveCursor(findFunction,offset)
	return function(_,textBuffer,cursor)
		local ch <const> = BaseMode.grabInput()
		if ch == KeyMap.ESC then return DeleteAndYankParent.reset end
		local stop <const> = findFunction(textBuffer,cursor,ch)
		if stop == -1 then return DeleteAndYankParent.reset end
		cursor.x = stop + offset
		return DeleteAndYankParent.deleteOrYankCharacters
	end
end

function DeleteAndYankParent.moveToEndOfLineThenReturnDeleteOrYankCharacter(_,textBuffer,cursor)
	NormalMode:moveToEndOfLine(textBuffer,cursor)
	return DeleteAndYankParent.deleteOrYankCharacters
end

function DeleteAndYankParent.selectEntireLine(_,cursor)
	cursor:moveXTo(1)
	DeleteAndYankParent.doAfter = DeleteAndYankParent.doAfterSelectEntireLine
	NormalMode.takeInput = DeleteAndYankParent.moveToEndOfLineThenReturnDeleteOrYankCharacter
	return DeleteAndYankParent
end

function DeleteAndYankParent.from(textBuffer)
	NormalMode.takeInput = moveCursor(textBuffer.findForward,0)
	return NormalMode
end

function DeleteAndYankParent.to(textBuffer)
	NormalMode.takeInput = moveCursor(textBuffer.findForward,-1)
	return NormalMode
end

function DeleteAndYankParent.fromBackwards(textBuffer)
	NormalMode.takeInput = moveCursor(textBuffer.findBackwards,0)
	return NormalMode
end

function DeleteAndYankParent.toBackwards(textBuffer)
	NormalMode.takeInput = moveCursor(textBuffer.findBackwards,1)
	return NormalMode
end

function DeleteAndYankParent:takeInput(textBuffer,cursor)
	local ch <const> = BaseMode.grabInput()
	if self.keyBindings[ch] then
		self.keyBindings[ch](textBuffer,cursor,self)
		self:doAction(textBuffer,cursor)
	end
	return NormalMode
end

DeleteAndYankParent.doAfter = DeleteAndYankParent.returnDeleteAndYankParent

DeleteAndYankParent.keyBindings = {
	t = DeleteAndYankParent.to,
	T = DeleteAndYankParent.toBackwards,
	f = DeleteAndYankParent.from,
	F = DeleteAndYankParent.fromBackwards,
	d = DeleteAndYankParent.selectEntireLine,
	['$'] = NormalMode.setTakeInputToMoveToEndOfLine,
	['^'] = NormalMode.setTakeInputToMoveToStartOfLine
}

return DeleteAndYankParent
