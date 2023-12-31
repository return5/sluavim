local BaseMode <const> = require('modes.BaseMode')
local NormalMode <const> = require('modes.NormalMode')
local KeyMap <const> = require('localIO.KeyMapper')

local ReplaceMode <const> = {type = "ReplaceMode"}
ReplaceMode.__index = ReplaceMode

setmetatable(ReplaceMode,BaseMode)

_ENV = ReplaceMode

function ReplaceMode:returnAfterReplacement()
	return NormalMode
end

function ReplaceMode:replace(textBuffer,ch,cursor)
	textBuffer:replaceCharAt(ch,cursor)
	return self
end

function ReplaceMode:parseInput(ch,textBuffer,cursor)
	if ch == KeyMap.ESC then return NormalMode end
	self:replace(textBuffer,ch,cursor)
	return self:returnAfterReplacement()
end

return ReplaceMode
