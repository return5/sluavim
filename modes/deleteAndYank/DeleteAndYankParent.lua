--[[
	parent class for delete and yank modes. handles common functionality between them
--]]

local NormalMode <const> = require('modes.NormalMode')
local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('localIO.KeyMapper')

local DeleteAndYankParent <const> = {type = "DeleteAndYankParent",wordPattern = "[^a-zA-Z]"}
DeleteAndYankParent.__index = DeleteAndYankParent

setmetatable(DeleteAndYankParent,BaseMode)

_ENV = DeleteAndYankParent

function DeleteAndYankParent:action()
	return DeleteAndYankParent
end

function DeleteAndYankParent:deleteOrYankCharacters(textBuffer,cursor,start)
	local register <const> = {}
	local startChar <const> = start <= cursor:getX() and start or cursor:getX()
	local stopChar <const> = cursor:getX() >= start and cursor:getX() or start
	self.action(textBuffer,startChar,stopChar,cursor:getY(),register)
	BaseMode.setCurrentRegister(register)
	cursor:setX(startChar)
	self.resetCurrentRegister()
	return NormalMode
end

function DeleteAndYankParent:moveCursorAndDoAction(ch,textBuffer,cursor,findFunction,offset)
	if not textBuffer:doesLineExistAndHaveLength(cursor:getY()) then return NormalMode end
	local start <const> = cursor:getX()
	if ch == KeyMap.ESC then return NormalMode.returnNormalMode() end
	local stop <const> = findFunction(textBuffer,cursor,ch)
	if stop == -1 then return NormalMode.returnNormalMode() end
	cursor:setX(stop + offset)
	return self:deleteOrYankCharacters(textBuffer,cursor,start)
end

function DeleteAndYankParent.returnLengthOfLine(textBuffer,cursor)
	return textBuffer:getLengthOfLine(cursor:getY())
end

function DeleteAndYankParent.returnStartOfLine(textBuffer,cursor)
	return textBuffer:getLengthOfLine(cursor:getY()) > 0 and 1 or 0
end

function DeleteAndYankParent:parseInput(ch,textBuffer,cursor)
	if self.keyBindings[ch] then
		return self.keyBindings[ch](textBuffer,cursor)
	else
		return self:default(ch,textBuffer,cursor)
	end
end

function DeleteAndYankParent.findForwardPattern(textBuffer,cursor)
	return textBuffer:findForwardPattern(cursor,DeleteAndYankParent.wordPattern)
end

function DeleteAndYankParent.findBackwardsPattern(textBuffer,cursor)
	return textBuffer:findBackwardsPattern(cursor,DeleteAndYankParent.wordPattern)
end

function DeleteAndYankParent.returnNormalMode()
	return NormalMode
end

DeleteAndYankParent.keyBindings = {
	[KeyMap.ESC] = DeleteAndYankParent.returnNormalMode,
	[KeyMap.ENTER] = DeleteAndYankParent.returnNormalMode,
	[KeyMap.BACK] = DeleteAndYankParent.returnNormalMode
}
return DeleteAndYankParent
