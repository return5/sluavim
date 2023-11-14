local BaseMode <const> = require('modes.BaseMode')
local NormalMode <const> = require('modes.NormalMode')
local setmetatable <const> = setmetatable

local SetMacroInputMode <const> = {type = "SetMacroInputMode",register = {}}
SetMacroInputMode.__index = SetMacroInputMode

setmetatable(SetMacroInputMode,BaseMode)

_ENV = SetMacroInputMode

function SetMacroInputMode:parseInput(ch,textBuffer,cursor,currentMode)
	if ch == 'q' and currentMode == NormalMode then
		self.setCurrentRegister(self.register)
		return NormalMode
	end
	self.register[#self.register + 1] = ch
	self.currentMode = self.currentMode.parseInput(self.currentMode,ch,textBuffer,cursor)
	return self.currentMode
end


function SetMacroInputMode:new()
	return setmetatable({register = {},currentMode = NormalMode},self)
end

return SetMacroInputMode
