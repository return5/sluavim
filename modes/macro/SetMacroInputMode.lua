local BaseMode <const> = require('modes.BaseMode')
local NormalMode <const> = require('modes.NormalMode')
local setmetatable <const> = setmetatable

local SetMacroInputMode <const> = {type = "SetMacroInputMode"}
SetMacroInputMode.__index = SetMacroInputMode

setmetatable(SetMacroInputMode,BaseMode)

_ENV = SetMacroInputMode

function SetMacroInputMode:parseInput(ch,textBuffer,cursor)
	if ch == 'q' and self.currentMode == NormalMode then
		SetMacroInputMode.setRegister(self.registerName,self.register)
		return NormalMode
	end
	self.register[#self.register + 1] = ch
	self.currentMode = self.currentMode.parseInput(self.currentMode,ch,textBuffer,cursor)
	return self
end


function SetMacroInputMode:new(registerName)
	return setmetatable({registerName = registerName,register = {},currentMode = NormalMode},self)
end

return SetMacroInputMode
