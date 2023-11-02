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

function DeleteAndYankParent:moveCursorAndDoAction(ch,textBuffer,cursor,findFunction,offset)
	local start <const> = cursor.x
	if ch == KeyMap.ESC then return NormalMode.returnNormalMode() end
	local stop <const> = findFunction(textBuffer,cursor,ch)
	if stop == -1 then return NormalMode.returnNormalMode() end
	cursor:setX(stop + offset)
	return self:deleteOrYankCharacters(textBuffer,cursor,start)
end

function DeleteAndYankParent.returnLengthOfLine(textBuffer,cursor)
	return textBuffer:getLengthOfLine(cursor.y)
end

function DeleteAndYankParent.returnStartOfLine(textBuffer,cursor)
	return textBuffer:getLengthOfLine(cursor.y) > 0 and 1 or 0
end

function DeleteAndYankParent:parseInput(ch,textBuffer,cursor)
	if self.keyBindings[ch] then
		return self.keyBindings[ch](textBuffer,cursor)
	else
		return self:default(ch,textBuffer,cursor)
	end
end

function DeleteAndYankParent:takeInput(textBuffer,cursor)
	local ch <const> = DeleteAndYankParent.grabInput()
	return self:parseInput(ch,textBuffer,cursor)
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
