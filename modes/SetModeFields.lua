local NormalMode <const> = require('modes.NormalMode')
local InsertMode <const> = require('modes.InsertMode')
local DeleteMode <const> = require('modes.DeleteMode')

local SetModeFields <const> = {}
SetModeFields.__index = SetModeFields

_ENV = SetModeFields

function SetModeFields.setModes()
	InsertMode.normalMode = NormalMode
	NormalMode.deleteMode = DeleteMode
end

return SetModeFields
