local BaseMode <const> = require('modes.BaseMode')
local NormalMode <const> = require('modes.NormalMode')

local RunRepeatMode <const> = {type = "RunRepeatMode"}
RunRepeatMode.__index = RunRepeatMode

setmetatable(RunRepeatMode,BaseMode)

_ENV = RunRepeatMode

function RunRepeatMode.runRepeat(cmds,number,textBuffer,cursor)
	for i=1,number,1 do
		local currentMode = NormalMode
		for j=1,#cmds,1 do
			currentMode = currentMode:parseInput(cmds[j],textBuffer,cursor)
		end
	end
	return NormalMode
end

return RunRepeatMode
