--[[
	Parent class for NormalMode, InputMode, VisualSelect mode.
--]]

local Input <const> = require('localIO.Input')
local Registers <const> = require('model.Registers')

local BaseMode <const> = {type = 'basemode',keyBindings = {},registers = Registers}
BaseMode.__index = BaseMode

_ENV = BaseMode

function BaseMode.default()
	return BaseMode
end

function BaseMode.adjustRegister()
	BaseMode.registers:adjustRegister()
	return BaseMode
end

function BaseMode.setFirstRegister(register)
	BaseMode.registers:setFirstRegister(register)
	return BaseMode
end

function BaseMode.insertIntoCurrentRegister(ch)
	BaseMode.registers:addToCurrentRegister(ch)
	return BaseMode
end

function BaseMode.setRegister(ch)
	BaseMode.registers:setRegister(ch)
	return BaseMode
end

function BaseMode.getRegister(ch)
	return BaseMode.registers:getRegister(ch)
end

function BaseMode:parseInput(ch,textBuffer,cursor)
	if self.keyBindings[ch] then
		return self.keyBindings[ch](textBuffer,ch,cursor)
	end
	return self.default(textBuffer,ch,cursor)
end

function BaseMode:takeInput(textBuffer,cursor)
	local ch <const> = BaseMode.grabInput()
	return self:parseInput(ch,textBuffer,cursor)
end

function BaseMode.grabInput()
	return Input:getCh()
end

return BaseMode
