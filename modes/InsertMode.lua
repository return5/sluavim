local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')
local io = io

local InsertMode <const> = {type = 'insertmode'}
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

function InsertMode.newLine(textBuffer,_,cursor)
	--cursor:moveX(1)
	local newHead <const> = textBuffer:grabRowFrom(cursor)
	cursor:newLine()
	textBuffer:addLineAt(cursor.y)
	if newHead then
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

