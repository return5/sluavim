local BaseMode <const> = require('modes.BaseMode')
local InsertMode <const> = require('modes.InsertMode')

local NormalMode <const> = {type = 'normal'}
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

NormalMode.keyBindings = {
	i = NormalMode.returnInsertMode,
	j = NormalMode.default,
	k = NormalMode.returnInsertMode
}

return NormalMode

