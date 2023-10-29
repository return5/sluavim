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
local MacroModeDriver <const> = require('modes.macro.MacroModeDriver')
local MacroNormalMode <const> = require('modes.macro.macroNormalAndInsert.MacroNormalMode')
local MacroInsertMode <const> = require('modes.macro.macroNormalAndInsert.MacroInsertMode')
local MacroDeleteModeDriver <const> = require('modes.macro.macroDelete.MacroDeleteModeDriver')
local MovementDriver <const> = require('modes.movement.MovementDriver')
local MacroMovementDriver <const> = require('modes.macro.movement.MacroMovementDriver')
local ReplacementModeDriver <const> = require('modes.replace.ReplacementModeDriver')
local MacroYankDriver <const> = require('modes.macro.macroYank.MacroYankModeDriver')

local SetModeFields <const> = {}
SetModeFields.__index = SetModeFields

_ENV = SetModeFields

function SetModeFields.setModes()
	InsertMode.normalMode = NormalMode
	NormalMode.setDrivers(ReplacementModeDriver,MovementDriver,MacroModeDriver,YankModeDriver,DeleteModeDriver)
	MacroNormalMode.setDriverModes(MacroInsertMode,MacroDeleteModeDriver,MacroMovementDriver,MacroYankDriver)
	MacroInsertMode.setMacroNormalMode(MacroNormalMode)
	return SetModeFields
end

return SetModeFields
