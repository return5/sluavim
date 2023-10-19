--[[
	easy mode is a mode which makes the text editor behave like a traditional text editor.
	there is no different modes, just one special type of insert mode.
--]]

local InsertMode <const> = require('modes.InsertMode')
local KeyMappings <const> = require('ncurses.NcursesKeyMap')
local pairs <const> = pairs

local EasyMode <const> = {type = 'easy'}
EasyMode.__index = EasyMode
setmetatable(EasyMode,InsertMode)

_ENV = EasyMode


EasyMode.keyBindings = {}

--making a defensive copy of keyBindings.
for k,v in pairs(InsertMode.keyBindings) do
	EasyMode.keyBindings[k] = v
end

--for EasyMode disable the escape key, it should not return
EasyMode.keyBindings[KeyMappings.ESC] = nil

return EasyMode

