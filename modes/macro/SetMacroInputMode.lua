local BaseMode <const> = require('modes.BaseMode')
local NormalMode <const> = require('modes.NormalMode')

local SetMacroInputMode <const> = {type = "SetMacroInputMode",register = {}}
SetMacroInputMode.__index = SetMacroInputMode

setmetatable(SetMacroInputMode,BaseMode)

_ENV = SetMacroInputMode

function SetMacroInputMode.initRegister()
	SetMacroInputMode.register = {}
	return SetMacroInputMode,NormalMode
end

function SetMacroInputMode:parseInput(ch,textBuffer,cursor,currentMode)
	if ch == 'q' and currentMode == NormalMode then
		self.setCurrentRegister(SetMacroInputMode.register)
		return NormalMode
	end
	SetMacroInputMode.register[#SetMacroInputMode.register + 1] = ch
	local returnMode <const> = currentMode:parseInput(ch,textBuffer,cursor)
	return SetMacroInputMode,returnMode
end


return SetMacroInputMode
