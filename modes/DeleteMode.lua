local NormalMode <const> = require('modes.NormalMode')
local BaseMode <const> = require('modes.BaseMode')

local DeleteMode <const> = {type = "deletemode"}
DeleteMode.__index = DeleteMode

_ENV = DeleteMode

function DeleteMode.deleteChars(textBuffer,start,cursor)
	local register <const> = {}
	local startChar <const> = start <= cursor.x and start or cursor.x
	local stopChar <const> = cursor.x >= start and cursor.x or start
	textBuffer:removeChars(startChar,stopChar,cursor.y,register)
	BaseMode.setFirstRegister(register)
	return DeleteMode
end

function DeleteMode.delete(textBuffer,cursor)
	local start <const> = cursor.x
	local returnMode <const> = NormalMode:takeInput(textBuffer,cursor)
	if cursor.x ~= start then
		BaseMode.adjustRegister()
		DeleteMode.deleteChars(textBuffer,start,cursor)
	end
	return returnMode
end

function DeleteMode.deleteCurrentChar(textBuffer,cursor)
	DeleteMode.deleteChars(textBuffer,cursor.x,cursor)
	return NormalMode
end

function DeleteMode:takeInput(textBuffer,cursor)
	local ch <const> = BaseMode.grabInput()
	if DeleteMode.keyBindings[ch] then
		DeleteMode.keyBindings[ch](textBuffer,cursor)
		DeleteMode.delete(textBuffer,cursor)
	end
	return NormalMode
end

DeleteMode.keyBindings = {
	t = NormalMode.keyBindings.t,
	T = NormalMode.keyBindings.T,
	f = NormalMode.keyBindings.f,
	F = NormalMode.keyBindings.F,
	d = DeleteMode.deleteEntireLine,
	['$'] = NormalMode.setTakeInputToMoveToEndOfLine,
	['^'] = DeleteMode.selectTilStart,
}

return DeleteMode
