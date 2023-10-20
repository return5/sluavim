local BaseMode <const> = require('modes.BaseMode')
local InsertMode <const> = require('modes.InsertMode')

local NormalMode <const> = {type = 'normalmode'}
NormalMode.__index = NormalMode

setmetatable(NormalMode,BaseMode)

_ENV = NormalMode

--TODO

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

NormalMode.keyBindings = {
	a = NormalMode.returnInsertMode,
	I = NormalMode.moveToStartReturnInsertMode
}

return NormalMode

