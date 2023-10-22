local NormalMode <const> = require('modes.NormalMode')
local BaseMode <const> = require('modes.BaseMode')

local DeleteMode <const> = {type = "deletemode"}
DeleteMode.__index = DeleteMode

_ENV = DeleteMode


function DeleteMode.deleteChars(textBuffer,start,cursor)
	local register <const> = {}
	textBuffer:removeChars(start,cursor,register)
	BaseMode.setFirstRegister(register)
	return DeleteMode
end

function DeleteMode.delete(textBuffer,cursor,deleteCharactersFunction)
	local start <const> = cursor.x
	deleteCharactersFunction(textBuffer,nil,cursor)
	if cursor.x ~= start then
		DeleteMode.deleteChars(textBuffer,start,cursor)
	end
	return NormalMode
end

function DeleteMode.selectTilEnd(textBuffer,_,cursor)
	local stop <const> = textBuffer:getLengthOfLine(cursor.y)
	cursor.x = stop
	return DeleteMode
end

function DeleteMode.deleteCurrentChar(textBuffer,cursor)
	DeleteMode.deleteChars(textBuffer,cursor.x,cursor)
	return NormalMode
end

function DeleteMode:takeInput(textBuffer,cursor)
	local ch <const> = BaseMode.grabInput()
	if DeleteMode.keyBindings[ch] then
		BaseMode.adjustRegister()
		DeleteMode.delete(textBuffer,cursor,DeleteMode.keyBindings[ch])
	end
	return NormalMode
end

DeleteMode.keyBindings = {
	t = NormalMode.keyBindings.t,
	T = NormalMode.keyBindings.T,
	f = NormalMode.keyBindings.f,
	F = NormalMode.keyBindings.F,
	d = DeleteMode.deleteEntireLine,
	['$'] = DeleteMode.selectTilEnd,
	['^'] = DeleteMode.selectTilStart,
}

return DeleteMode