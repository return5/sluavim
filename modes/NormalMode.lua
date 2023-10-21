local BaseMode <const> = require('modes.BaseMode')
local InsertMode <const> = require('modes.InsertMode')

local NormalMode <const> = {type = 'normalmode'}
NormalMode.__index = NormalMode
setmetatable(NormalMode,BaseMode)

_ENV = NormalMode

function NormalMode.default()
	return NormalMode
end

function NormalMode.returnInsertMode()
	return InsertMode
end

function NormalMode.moveToStartReturnInsertMode(_,_,cursor)
	cursor:moveToStartOfLine()
	return InsertMode
end

function NormalMode.moveLeft(_,_,cursor)
	cursor:moveLeft()
	return NormalMode
end

function NormalMode.moveUp(_,_,cursor)
	cursor:moveUp()
	return NormalMode
end

function NormalMode.moveRight(textBuffer,_,cursor)
	local limit <const> = textBuffer:getLengthOfLine(cursor.y) + 1
	cursor:moveRightWithLimit(limit)
	return NormalMode
end

function NormalMode.moveDown(textBuffer,_,cursor)
	local limit <const> = textBuffer:getSize()
	cursor:modeDownWithLimit(limit)
	return NormalMode
end

function NormalMode.moveRightAndReturnInsertMode(textBuffer,_,cursor)
	NormalMode.moveRight(textBuffer,nil,cursor)
	return InsertMode
end

function NormalMode.returnInsertMode()
	return InsertMode
end

function NormalMode.moveToEndAndReturnInsertMode(textBuffer,_,cursor)
	cursor.x = textBuffer:getLengthOfLine(cursor.y) + 1
	return InsertMode
end

function NormalMode.endMacro()
	BaseMode.parseInput = BaseMode.regularParseInput
	NormalMode.keyBindings['q'] = NormalMode.setMacro
	return NormalMode
end

function NormalMode.setMacro()
	BaseMode.parseInput = BaseMode.macroParseInputSetRegister
	NormalMode.keyBindings['q'] = NormalMode.endMacro
	return NormalMode
end

function NormalMode.runMacro(textBuffer,_,cursor)
	BaseMode.runMacro(NormalMode,textBuffer,cursor)
	return NormalMode
end

NormalMode.keyBindings = {
	a = NormalMode.moveRightAndReturnInsertMode,
	A = NormalMode.moveToEndAndReturnInsertMode,
	i = NormalMode.returnInsertMode,
	I = NormalMode.moveToStartReturnInsertMode,
	h = NormalMode.moveLeft,
	j = NormalMode.moveDown,
	k = NormalMode.moveUp,
	l = NormalMode.moveRight,
	q = NormalMode.setMacro,
	['@'] = NormalMode.runMacro
	--TODO d,y,:,f,t,p,P
}

return NormalMode

