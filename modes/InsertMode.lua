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
	textBuffer:removeCharAt(cursor.y,cursor.x)
	return InsertMode
end

function InsertMode.insertChar(textBuffer,ch,cursor)
	textBuffer:insert(cursor.y,ch,cursor.x)
	cursor:moveRight()
	return InsertMode
end

function InsertMode.newLineAbove(textBuffer,_,cursor)
	textBuffer:addLineAt(cursor.y)
	cursor:moveXTo(1)
	return InsertMode
end

function InsertMode.newLine(textBuffer,ch,cursor)
	textBuffer:insert(cursor.y,ch,cursor.x)
	local newHead <const> = textBuffer:grabRowFrom(cursor)
	cursor:newLine()
	textBuffer:addLineAt(cursor.y)
	if newHead then
		textBuffer:removeCharAtEnd(cursor.y - 1,ch)
		newHead:addPrevChar(ch)
		--get the line at y, then insert at the beginning any characters which were present behind the added newline character.
		textBuffer:getLine(cursor.y):getItem():insertNodeAtStart(newHead)
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

