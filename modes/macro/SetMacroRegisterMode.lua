local MacroModeBase <const> = require('modes.macro.MacroModeBase')
local MacroMode <const> = require('modes.macro.MacroMode')
local BaseMode <const> = require('modes.BaseMode')
local io = io

local SetMacroRegisterMode <const> = {type = "SetMacroRegisterMode"}
SetMacroRegisterMode.__index = SetMacroRegisterMode

setmetatable(SetMacroRegisterMode,MacroModeBase)

_ENV = SetMacroRegisterMode

function SetMacroRegisterMode:doAction(_,ch)
	io.write("setting macro: ",ch,"\n")
	BaseMode.macros[ch] = {}
	BaseMode.currentRegister = ch
	io.write("basemade current: ",BaseMode.currentRegister,"\n")
	return MacroMode
end

return SetMacroRegisterMode
