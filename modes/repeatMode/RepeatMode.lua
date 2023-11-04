
local BaseMode <const> = require('modes.BaseMode')
local NormalMode <const> = require('modes.NormalMode')
local RunRepeatMode <const> = require('modes.repeatMode.RunRepeatMode')

local RepeatMode <const> = {type = "RepeatMode",number = 0,cmds = {}}
RepeatMode.__index = RepeatMode

setmetatable(RepeatMode,BaseMode)

_ENV = RepeatMode

function RepeatMode.init(number)
	RepeatMode.cmds = {}
	RepeatMode.number = number
	RepeatMode.prevMode = NormalMode
end

function RepeatMode.addInputToCmds(input)
	RepeatMode.cmds[#RepeatMode.cmds + 1] = input
	return RepeatMode
end

function RepeatMode:parseInput(ch,textBuffer,cursor)
	RepeatMode.addInputToCmds(ch)
	RepeatMode.prevMode = RepeatMode.prevMode.parseInput(RepeatMode.prevMode,ch,textBuffer,cursor)
	if RepeatMode.prevMode == NormalMode then return RunRepeatMode.runRepeat(RepeatMode.cmds,RepeatMode.number - 1,textBuffer,cursor) end
	return RepeatMode
end

return RepeatMode
