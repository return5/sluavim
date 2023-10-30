--[[
	parent class for delete and yank modes. handles common functionality between them
--]]

local NormalMode <const> = require('modes.NormalMode')
local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')

local DeleteAndYankParent <const> = {type = "DeleteAndYankParent",wordPattern = "[^a-zA-Z]"}
DeleteAndYankParent.__index = DeleteAndYankParent

setmetatable(DeleteAndYankParent,BaseMode)

_ENV = DeleteAndYankParent

function DeleteAndYankParent:action()
	return DeleteAndYankParent
end

function DeleteAndYankParent:deleteOrYankCharacters(textBuffer,cursor,start)
	BaseMode.adjustRegister()
	local register <const> = {}
	local startChar <const> = start <= cursor.x and start or cursor.x
	local stopChar <const> = cursor.x >= start and cursor.x or start
	self.action(textBuffer,startChar,stopChar,cursor.y,register)
	BaseMode.setFirstRegister(register)
	cursor:setX(startChar)
	return NormalMode
end

function DeleteAndYankParent:doAction(textBuffer,cursor)
	local start <const> = cursor.x
	local nextStep <const> = NormalMode:takeInput(textBuffer,cursor)
	return nextStep(self,textBuffer,cursor,start)
end

function DeleteAndYankParent:moveCursor(textBuffer,cursor,findFunction,offset)
	local ch <const> = BaseMode.grabInput()
	if ch == KeyMap.ESC then return NormalMode.returnNormalMode end
	local stop <const> = findFunction(textBuffer,cursor,ch)
	if stop == -1 then return NormalMode.returnNormalMode end
	cursor:setX(stop + offset)
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

local function findTilPattern(textBuffer,cursor,offset,findFunction)
	local startX <const> = cursor.x
	local stop <const> = findFunction(textBuffer,cursor,DeleteAndYankParent.wordPattern)
	cursor:setX(stop + offset)
	return startX
end

function DeleteAndYankParent:findForward(textBuffer,cursor,offset)
	return findTilPattern(textBuffer,cursor,offset,textBuffer.findForwardPattern)
end

function DeleteAndYankParent:findBackwards(textBuffer,cursor,offset)
	return findTilPattern(textBuffer,cursor,offset,textBuffer.findBackwardsPattern)
end

function DeleteAndYankParent:takeInputAndMoveThenDoAction(textBuffer,cursor,findFunc,offset)
	local start <const> = cursor.x
	local nextFunc <const> = self:moveCursor(textBuffer,cursor,findFunc,offset)
	return nextFunc(self,textBuffer,cursor,start)
end

return DeleteAndYankParent
