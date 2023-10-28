--[[
	parent class for delete and yank modes. handles common functionality between them
--]]

local NormalMode <const> = require('modes.NormalMode')
local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')
local io = io

local DeleteAndYankParent <const> = {type = "deleteandyankparent"}
DeleteAndYankParent.__index = DeleteAndYankParent

setmetatable(DeleteAndYankParent,BaseMode)

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
	cursor.x = startChar
	return NormalMode.reset()
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
	return NormalMode.reset()
end

function DeleteAndYankParent.doAfterSelectEntireLine(textBuffer,cursor)
	DeleteAndYankParent.doAfter = DeleteAndYankParent.returnDeleteAndYankParent
	textBuffer:removeLineAt(cursor.y)
	cursor:limitYToSizeOfTextBuffer(textBuffer)
	cursor:moveToEndOfLine(textBuffer)
	return DeleteAndYankParent.returnDeleteAndYankParent()
end

function DeleteAndYankParent:moveCursor(textBuffer,cursor,findFunction,offset)
	local ch <const> = BaseMode.grabInput()
	if ch == KeyMap.ESC then return NormalMode.reset end
	local stop <const> = findFunction(textBuffer,cursor,ch)
	if stop == -1 then return NormalMode.reset end
	cursor.x = stop + offset
	return DeleteAndYankParent.deleteOrYankCharacters
end

function DeleteAndYankParent.moveCursorToEndOfLine(textBuffer,cursor)
	NormalMode:moveToEndOfLine(textBuffer,cursor)
	return DeleteAndYankParent
end

function DeleteAndYankParent.moveCursorToStartOfLine(cursor)
	cursor:moveXTo(1)
	return DeleteAndYankParent
end

function DeleteAndYankParent:takeInput(textBuffer,cursor)
	local ch <const> = DeleteAndYankParent.grabInput()
	if self.keyBindings[ch] then
		self.keyBindings[ch](textBuffer,cursor,self)
		self:doAction(textBuffer,cursor)
	end
	return NormalMode
end

function DeleteAndYankParent:takeInputAndMoveThenDoAction(textBuffer,cursor,findFunc,offset)
	local start <const> = cursor.x
	local nextFunc <const> = self:moveCursor(textBuffer,cursor,findFunc,offset)
	return nextFunc(self,textBuffer,cursor,start)
end

return DeleteAndYankParent
