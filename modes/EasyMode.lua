--[[
	easy mode is a mode which makes the text editor behave like a traditional text editor.
	there is no different modes, just one special type of insert mode.
--]]

local InsertMode <const> = require('modes.InsertMode')
local KeyMappings <const> = require('ncurses.NcursesKeyMap')

local EasyMode <const> = {}
EasyMode.__index = EasyMode
setmetatable(EasyMode,InsertMode)

_ENV = EasyMode

EasyMode.keyBindings[KeyMappings.ESC] = nil



return EasyMode

