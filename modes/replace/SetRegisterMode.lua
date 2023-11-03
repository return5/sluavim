local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('localIO.KeyMapper')
local NormalMode <const> = require('modes.NormalMode')

local SetRegisterMode <const> = {type = "SetRegisterMode"}
SetRegisterMode.__index = SetRegisterMode
setmetatable(SetRegisterMode,BaseMode)

_ENV = SetRegisterMode

function SetRegisterMode:takeInput()
	local ch <const> = self.grabInput()
	if not KeyMap[ch] then
		self.setCurrentRegisterName(ch)
	end
	return NormalMode
end

return SetRegisterMode
