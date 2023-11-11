local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('localIO.KeyMapper')
local NormalMode <const> = require('modes.NormalMode')
local RepeatMode <const> = require('modes.repeatMode.RepeatMode')
local tonumber <const> = tonumber

local SetRepeatNumberMode <const> = {type ="SetRepeatNumberMode",number = ""}
SetRepeatNumberMode.__index = SetRepeatNumberMode

setmetatable(SetRepeatNumberMode,BaseMode)

_ENV = SetRepeatNumberMode


function SetRepeatNumberMode:returnRepeatMode(input,textBuffer,cursor)
	local number <const> = tonumber(self.number)
	self.number = ""
	RepeatMode.init(number)
	return RepeatMode:parseInput(input,textBuffer,cursor)
end

function SetRepeatNumberMode:parseInput(ch,textBuffer,cursor)
	if KeyMap[ch] then
		self.number = ""
		return NormalMode
	end
	if ch == 'g' or ch == 'G' then
		cursor:moveYTo(tonumber(self.number) + 1,textBuffer:getSize())
		self.number = ""
		return NormalMode
	end
	if not tonumber(ch) then return self:returnRepeatMode(ch,textBuffer,cursor) end
	self.number = self.number .. ch
	return self
end

return SetRepeatNumberMode
