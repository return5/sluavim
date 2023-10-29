local MacroModeBase <const> = require('modes.macro.MacroModeBase')
local NormalMode <const> = require('modes.NormalMode')

local RunMacroMode <const> = {type = "RunMacroMode"}
RunMacroMode.__index = RunMacroMode

setmetatable(RunMacroMode,MacroModeBase)

_ENV = RunMacroMode

function RunMacroMode:doAction(textBuffer,ch,cursor)
	local mode = NormalMode
	local macro <const> = RunMacroMode.registers[ch]
	for i=1,#macro,1 do
		mode = mode:parseInput(macro[i],textBuffer,cursor)
	end
	return mode
end

return RunMacroMode
