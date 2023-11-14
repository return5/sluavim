local BaseMode <const> = require('modes.BaseMode')
local NormalMode <const> = require('modes.NormalMode')
local SetRegisterMode <const> = require('modes.miscModes.SetRegisterMode')
local SetMacroModeInput <const> = require('modes.macro.SetMacroInputMode')

local SetMacroMode <const> = {type = "SetMacroMode"}
SetMacroMode.__index = SetMacroMode

setmetatable(SetMacroMode,BaseMode)

_ENV = SetMacroMode

function SetMacroMode:parseInput(ch)
	if SetRegisterMode:setRegisterName(ch) then
		return SetMacroModeInput:new()
	end
	return NormalMode
end

return SetMacroMode
