local Output <const> = require('localIO.Output')
local Input <const> = require('localIO.Input')
local NormalMode <const> = require('modes.NormalMode')
local KeyMapping <const> = require('ncurses.NcursesKeyMap')

local InsertMode <const> = {}
InsertMode.__index = InsertMode

_ENV = InsertMode

--TODO

InsertMode.keyBindings = {
	[KeyMapping.ESC] = InsertMode.returnNormal,
	[KeyMapping.ENTER] = InsertMode.newLine,
	[KeyMapping.BACK] = InsertMode.backSpace
}

function InsertMode.backSpace(textBuffer,_,cursor)
	cursor:moveLeft()
	textBuffer:replaceCharAt()
	return InsertMode
end

function InsertMode.newLine(textBuffer,ch,cursor)
	textBuffer:insert(cursor.y,ch,cursor.x)
	textBuffer:addNewLine(cursor.y)
	cursor:moveDown()
	return InsertMode
end

function InsertMode.returnNormal()
	return NormalMode
end

return InsertMode

