--[[
	easy mode is a mode which makes the text editor behave like a traditional text editor.
	removes the 'modal' aspect of vim, just one special type of insert mode.
--]]

local InsertMode <const> = require('modes.InsertMode')
local KeyMappings <const> = require('localIO.KeyMapper')
local pairs <const> = pairs

local EasyMode <const> = {type = 'easymode'}
EasyMode.__index = EasyMode
setmetatable(EasyMode,InsertMode)

_ENV = EasyMode

--making a defensive copy of keyBindings.
EasyMode.keyBindings = {}
for k,v in pairs(InsertMode.keyBindings) do
	EasyMode.keyBindings[k] = v
end

--for EasyMode disable the escape key, it should not return
EasyMode.keyBindings[KeyMappings.ESC] = nil

return EasyMode

