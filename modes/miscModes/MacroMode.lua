
local BaseMode <const> = require('modes.BaseMode')
local SetRegisterMode <const> = require('modes.miscModes.SetRegisterMode')
local NormalMode <const> = require('modes.NormalMode')

local MacroMode <const> = {type = "MacroMode"}
MacroMode.__index = MacroMode

setmetatable(MacroMode,BaseMode)


function MacroMode:setMacroLoop(textBuffer,cursor)
	local register <const> = {}
	local currentMode = NormalMode
	while true do
		local input <const> = self.grabInput()
		if currentMode == NormalMode and input == 'q' then break end
		register[#register + 1] = input
		currentMode = currentMode:parseInput(input,textBuffer,cursor)
	end
	return register
end

function MacroMode:setMacro(textBuffer,cursor)
	local ch <const> = self.grabInput()
	if not SetRegisterMode:setRegister(ch) then return NormalMode end
	local register <const> = MacroMode:setMacroLoop(textBuffer,cursor)
	SetRegisterMode:setRegister(ch) --because some of the commands in the loop might set CurrentRegister, we need to set it here.
	self.setCurrentRegister(register)
	self.resetCurrentRegister()
	return NormalMode
end

function MacroMode.runMacroLoop(textBuffer,cursor,macroRegister)
	local currentMode = NormalMode
	for i=1,#macroRegister,1 do
		currentMode = currentMode:parseInput(macroRegister[i],textBuffer,cursor)
	end
	return MacroMode
end

function MacroMode:runMacro(textBuffer,cursor)
	local ch <const> = self.grabInput()
	if not SetRegisterMode:setRegister(ch) then return NormalMode end
	local macroRegister <const> = self.getCurrentRegister()
	if macroRegister then
		MacroMode.runMacroLoop(textBuffer,cursor,macroRegister)
	end
	return NormalMode
end

return MacroMode
