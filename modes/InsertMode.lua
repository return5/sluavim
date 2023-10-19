local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')
local require <const> = require

local InsertMode <const> = {type = 'insert'}
InsertMode.__index = InsertMode
setmetatable(InsertMode,BaseMode)

_ENV = InsertMode

function InsertMode.returnNormal()
	return InsertMode.normalMode
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
	cursor:newLine()
	textBuffer:addLineAt(cursor.y)
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
	[KeyMap.ESC] = InsertMode.returnNormal,
	[KeyMap.ENTER] = InsertMode.newLine,
	[KeyMap.BACK] = InsertMode.backSpace,
}

return InsertMode

