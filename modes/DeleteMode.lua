local NormalMode <const> = require('modes.NormalMode')
local BaseMode <const> = require('modes.BaseMode')

local DeleteMode <const> = {type = "deletemode"}
DeleteMode.__index = DeleteMode

_ENV = DeleteMode



function DeleteMode.delete(textBuffer,cursor,deleteCharactersFunction)
	local register <const> = {}
	local start <const> = cursor.x
	deleteCharactersFunction(textBuffer,nil,cursor)
	if cursor.x ~= start then
		textBuffer:removeChars(start,cursor,register)
		BaseMode.setFirstRegister(register)
	end
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
	['$'] = DeleteMode.deleteTilEnd,
	['^'] = DeleteMode.deleteTilStart,
}

return DeleteMode
