local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('localIO.KeyMapper')
local NormalMode <const> = require('modes.NormalMode')

local SetRegisterMode <const> = {type = "SetRegisterMode"}
SetRegisterMode.__index = SetRegisterMode
setmetatable(SetRegisterMode,BaseMode)

_ENV = SetRegisterMode


function SetRegisterMode:setRegisterName(ch)
	if KeyMap[ch] then
		return false
	end
	self.setCurrentRegisterName(ch)
	return true
end

function SetRegisterMode:parseInput(ch)
	SetRegisterMode:setRegisterName(ch)
	return NormalMode
end

return SetRegisterMode
