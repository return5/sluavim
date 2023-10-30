--[[
	parent class for delete and yank modes. handles common functionality between them
--]]

local MacroNormalMode <const> = require('modes.macro.macroNormalAndInsert.MacroNormalMode')
local DeleteAndYankParent <const> = require('modes.DeleteAndYankParent')
local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')

local MacroDeleteAndYankParent <const> = {type = "MacroDeleteAndYankParent",wordPattern = "[^a-zA-Z]"}
MacroDeleteAndYankParent.__index = MacroDeleteAndYankParent

setmetatable(MacroDeleteAndYankParent,BaseMode)

_ENV = MacroDeleteAndYankParent

function MacroDeleteAndYankParent:action()
	return MacroDeleteAndYankParent
end

function MacroDeleteAndYankParent:deleteOrYankCharacters(textBuffer,cursor,start)
	DeleteAndYankParent.deleteOrYankCharacters(self,textBuffer,cursor,start)
	return MacroNormalMode
end

function MacroDeleteAndYankParent:doAction(textBuffer,cursor)
	local start <const> = cursor.x
	local nextStep <const> = MacroNormalMode:takeInput(textBuffer,cursor)
	return nextStep(self,textBuffer,cursor,start)
end

function MacroDeleteAndYankParent:moveCursor(textBuffer,cursor,findFunction,offset)
	local ch <const> = BaseMode.grabInput()
	if ch == KeyMap.ESC then return MacroNormalMode.reset end
	local stop <const> = findFunction(textBuffer,cursor,ch)
	if stop == -1 then return MacroNormalMode.reset end
	cursor:setX(stop + offset)
	return MacroDeleteAndYankParent.deleteOrYankCharacters
end

function MacroDeleteAndYankParent.moveCursorToEndOfLine(textBuffer,cursor)
	DeleteAndYankParent.moveCursorToEndOfLine(textBuffer,cursor)
	return MacroDeleteAndYankParent
end

function MacroDeleteAndYankParent.moveCursorToStartOfLine(cursor)
	DeleteAndYankParent.moveCursorToStartOfLine(cursor)
	return MacroDeleteAndYankParent
end

function MacroDeleteAndYankParent:takeInput(textBuffer,cursor)
	local ch <const> = MacroDeleteAndYankParent.grabInput()
	if self.keyBindings[ch] then
		self.keyBindings[ch](textBuffer,cursor,self)
		self:doAction(textBuffer,cursor)
	end
	return MacroNormalMode
end

local function findTilPattern(textBuffer,cursor,offset,findFunction)
	local startX <const> = cursor.x
	local stop <const> = findFunction(textBuffer,cursor,MacroDeleteAndYankParent.wordPattern)
	cursor:setX(stop + offset)
	return startX
end

function MacroDeleteAndYankParent:findForward(textBuffer,cursor,offset)
	return findTilPattern(textBuffer,cursor,offset,textBuffer.findForwardPattern)
end

function MacroDeleteAndYankParent:findBackwards(textBuffer,cursor,offset)
	return findTilPattern(textBuffer,cursor,offset,textBuffer.findBackwardsPattern)
end


function MacroDeleteAndYankParent:takeInputAndMoveThenDoAction(textBuffer,cursor,findFunc,offset)
	return DeleteAndYankParent.takeInputAndMoveThenDoAction(self,textBuffer,cursor,findFunc,offset)
end

return MacroDeleteAndYankParent
