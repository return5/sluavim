local MacroModeBase <const> = require('modes.macro.MacroModeBase')
local NormalMode <const> = require('modes.NormalMode')
local io = io

local RunMacroMode <const> = {type = "RunMacroMode"}
RunMacroMode.__index = RunMacroMode

setmetatable(RunMacroMode,MacroModeBase)

_ENV = RunMacroMode

function RunMacroMode:doAction(textBuffer,ch,cursor)
	local mode = NormalMode
	io.write("macro register is: ",ch,"\n")
	local macro <const> = RunMacroMode.macros[ch]
	io.write("length of macro is: ",#macro,"\n")
	for i=1,#macro,1 do
		io.write("macro letter is: ",macro[i],"\n")
		mode = mode:parseInput(macro[i],textBuffer,cursor)
	end
	return mode
end

return RunMacroMode
