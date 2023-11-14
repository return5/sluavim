local BaseMode <const> = require('modes.BaseMode')
local NormalMode <const> = require('modes.NormalMode')
local SetRegisterMode <const> = require('modes.miscModes.SetRegisterMode')

local RunMacroMode <const> = {type ="RunMacroMode"}
RunMacroMode.__index = RunMacroMode

setmetatable(RunMacroMode,BaseMode)


function RunMacroMode.runMacroLoop(textBuffer,cursor,macroRegister)
	local currentMode = NormalMode
	for i=1,#macroRegister,1 do
		currentMode = currentMode:parseInput(macroRegister[i],textBuffer,cursor)
	end
	return RunMacroMode
end


function RunMacroMode:parseInput(ch,textBuffer,cursor)
	if not SetRegisterMode.setRegisterName(ch) then return NormalMode end
	local macroRegister <const> = RunMacroMode.getRegister(ch)
	if macroRegister then
		RunMacroMode.runMacroLoop(textBuffer,cursor,macroRegister)
	end
	return NormalMode
end

return RunMacroMode
