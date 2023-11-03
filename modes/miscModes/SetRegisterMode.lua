local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('localIO.KeyMapper')
local NormalMode <const> = require('modes.NormalMode')

local SetRegisterMode <const> = {type = "SetRegisterMode"}
SetRegisterMode.__index = SetRegisterMode
setmetatable(SetRegisterMode,BaseMode)

_ENV = SetRegisterMode


function SetRegisterMode:setRegister(ch)
	if KeyMap[ch] then
		return false
	end
	self.setCurrentRegisterName(ch)
	return true
end

function SetRegisterMode:takeInput()
	local ch <const> = self.grabInput()
	SetRegisterMode:setRegister(ch)
	return NormalMode
end

return SetRegisterMode
