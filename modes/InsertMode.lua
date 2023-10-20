local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')
local require <const> = require

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

function InsertMode.newLine(textBuffer,ch,cursor)
	InsertMode.insertChar(textBuffer,ch,cursor)
	cursor:moveX(-1)
	local newHead <const> = textBuffer:grabRowFrom(cursor)
	cursor:newLine()
	textBuffer:addLineAt(cursor.y)
	--get the line at y, then insert at the beginning any characters which were present behind the added newline character.
	textBuffer:getLine(cursor.y):getItem():insertNodeAtStart(newHead)
	return InsertMode
end

function InsertMode.default(textBuffer,ch,cursor)
	return InsertMode.insertChar(textBuffer,ch,cursor)
end

--attempting to avoid circular dependency. need to find a better way.
--since both NormalMode and InsertMode require each other, attempting to 'require' NormalMode creates a circular dependency which crashes when the file is loaded.
function InsertMode.setNormal()
	InsertMode.normalMode = require('modes.NormalMode')
end

InsertMode.keyBindings = {
	[KeyMap.ESC] = InsertMode.escape,
	[KeyMap.ENTER] = InsertMode.newLine,
	[KeyMap.BACK] = InsertMode.backSpace,
}

return InsertMode

