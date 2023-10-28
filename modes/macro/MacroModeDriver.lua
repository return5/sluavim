local BaseMode <const> = require('modes.BaseMode')
local SetMacroRegisterMode <const> = require('modes.macro.SetMacroRegisterMode')
local RunMacroMode <const> = require('modes.macro.RunMacroMode')

local MacroModeDriver <const> = {type = "MacroModeDriver"}
MacroModeDriver.__index = MacroModeDriver

setmetatable(MacroModeDriver,BaseMode)

_ENV = MacroModeDriver

function MacroModeDriver.runMacro()
	return RunMacroMode
end

function MacroModeDriver.setRegister()
	return SetMacroRegisterMode
end

return MacroModeDriver
