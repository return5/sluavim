local BaseMode <const> = require('modes.BaseMode')
local NormalMode <const> = require('modes.NormalMode')

local SetMacroInputMode <const> = {type = "SetMacroInputMode",registerNames = {}}
SetMacroInputMode.__index = SetMacroInputMode

setmetatable(SetMacroInputMode,BaseMode)

_ENV = SetMacroInputMode


function SetMacroInputMode.addRegisterName(name)
	SetMacroInputMode.registerNames[#SetMacroInputMode.registerNames + 1] = name
	return SetMacroInputMode
end

function SetMacroInputMode.removeLastRegisterName()
	if #SetMacroInputMode.registerNames > 0 then
		SetMacroInputMode.registerNames[#SetMacroInputMode.registerNames] = nil
	end
	return SetMacroInputMode
end

function SetMacroInputMode:parseInput(ch,textBuffer,cursor)
	local register <const> = {ch}
	local currentMode = NormalMode
	while not (ch == 'q' and currentMode == NormalMode) do
		currentMode = currentMode:parseInput(ch,textBuffer,cursor)
		ch = self.grabInput()
		register[#register + 1] = ch
	end
	register[#register] = nil
	self.setRegister(self.registerNames[#self.registerNames],register)
	self.removeLastRegisterName()
	return NormalMode
end


return SetMacroInputMode
