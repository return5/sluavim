--[[
	Class which represents InsertMode of a VIM editor.
--]]

local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')

local InsertMode <const> = {type = 'InsertMode', normalMode = "please remember to set this before using this class"}
InsertMode.__index = InsertMode
setmetatable(InsertMode,BaseMode)

_ENV = InsertMode

function InsertMode.returnNormal()
	return InsertMode.normalMode
end

function InsertMode.escape(_,_,cursor)
	cursor:moveLeft()
	return InsertMode.returnNormal()
end

function InsertMode.backSpace(textBuffer,_,cursor)
	cursor:moveLeft()
	textBuffer:removeCharAt(cursor:getY(),cursor:getX())
	return InsertMode
end

function InsertMode.insertChar(textBuffer,ch,cursor)
	textBuffer:insert(cursor:getY(),ch,cursor:getX())
	cursor:moveRight()
	return InsertMode
end

function InsertMode.newLineAbove(textBuffer,_,cursor)
	textBuffer:addLineAt(cursor:getY(),cursor:getY(),"\n")
	cursor:moveXTo(1)
	textBuffer:addEndingNewLine(cursor:getY(),"\n")
	return InsertMode
end

local function addNewLine(textBuffer,ch,cursor)
	local oldY <const> = cursor:getY()
	cursor:newLine()
	textBuffer:newLine(cursor:getY(),oldY,ch)
end

function InsertMode.insertNewLineBelowAndReturnInsertMode(textBuffer,_,cursor)
	addNewLine(textBuffer,"\n",cursor)
	return InsertMode
end

function InsertMode.newLine(textBuffer,ch,cursor)
	local newHead <const> = textBuffer:grabRowFrom(cursor)
	addNewLine(textBuffer,ch,cursor)
	if newHead then
		--get the line at y, then insert at the beginning any characters which were present behind the added newline character.
		textBuffer:insertAtStart(cursor:getY(),newHead)
	end
	return InsertMode
end

function InsertMode.default(textBuffer,ch,cursor)
	return InsertMode.insertChar(textBuffer,ch,cursor)
end

InsertMode.keyBindings = {
	[KeyMap.ESC] = InsertMode.escape,
	[KeyMap.ENTER] = InsertMode.newLine,
	[KeyMap.BACK] = InsertMode.backSpace,
}

return InsertMode

