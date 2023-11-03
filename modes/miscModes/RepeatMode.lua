
local BaseMode <const> = require('modes.BaseMode')
local NormalMode <const> = require('modes.NormalMode')
local KeyMap <const> = require('localIO.KeyMapper')
local tonumber <const> = tonumber

local RepeatMode <const> = {type = "RepeatMode"}
RepeatMode.__index = RepeatMode

setmetatable(RepeatMode,BaseMode)

_ENV = RepeatMode

--TODO rewrite this to work with macros

function RepeatMode:repl(textBuffer,cursor,number,cmds)
	local currentMode = NormalMode
	for i=1,number - 1,1 do
		for j=1,#cmds,1 do
			currentMode = currentMode:parseInput(cmds[j],textBuffer,cursor)
		end
	end
	return currentMode
end

function RepeatMode:buildCmd(textBuffer,cursor,number,ch)
	local cmds <const> = {ch}
	local currentMode = NormalMode:parseInput(ch,textBuffer,cursor)
	while currentMode ~= NormalMode do
		ch = self.grabInput()
		if ch == KeyMap.ESC then return NormalMode end
		cmds[#cmds + 1] = ch
		currentMode = currentMode:parseInput(ch,textBuffer,cursor)
	end
	return self:repl(textBuffer,cursor,number,cmds)
end

function RepeatMode:takeNumber(textBuffer,cursor,ch)
	local number = ch
	while true do
		local input <const> = self.grabInput()
		if input == KeyMap.ESC then return NormalMode end
		if tonumber(input) then
			number = number .. input
		else
			return self:buildCmd(textBuffer,cursor,tonumber(number),input)
		end
	end
end

return RepeatMode
