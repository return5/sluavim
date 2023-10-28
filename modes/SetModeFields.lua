--[[
	class which inserts a copy of one mode inside another.
	needed because some of these modes have a dependency on the other mode which has a dependency on the first mode.
	this creates a circular dependency loop which crashed the program.
	what is needed is some post constructor injection. or refactoring to remove the dependency loop.
	until i can work out a better solution this class will have to do.
--]]

local NormalMode <const> = require('modes.NormalMode')
local InsertMode <const> = require('modes.InsertMode')
local DeleteModeDriver <const> = require('modes.delete.DeleteModeDriver')
local YankModeDriver <const> = require('modes.yank.YankModeDriver')

local SetModeFields <const> = {}
SetModeFields.__index = SetModeFields

_ENV = SetModeFields

function SetModeFields.setModes()
	InsertMode.normalMode = NormalMode
	NormalMode.setDeleteModeDriver(DeleteModeDriver)
	NormalMode.setYankModeDriver(YankModeDriver)
end

return SetModeFields
