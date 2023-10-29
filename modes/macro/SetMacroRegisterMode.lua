local MacroModeBase <const> = require('modes.macro.MacroModeBase')
local MacroNormalMode <const> = require('modes.macro.macroNormalAndInsert.MacroNormalMode')
local BaseMode <const> = require('modes.BaseMode')

local SetMacroRegisterMode <const> = {type = "SetMacroRegisterMode"}
SetMacroRegisterMode.__index = SetMacroRegisterMode

setmetatable(SetMacroRegisterMode,MacroModeBase)

_ENV = SetMacroRegisterMode

function SetMacroRegisterMode:doAction(_,ch)
	BaseMode.setRegister(ch)
	return MacroNormalMode
end

return SetMacroRegisterMode
