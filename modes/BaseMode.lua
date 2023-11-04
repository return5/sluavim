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

function BaseMode.getCurrentRegister()
	return BaseMode.registers:getCurrentRegister()
end

function BaseMode.setCurrentRegisterName(ch)
	BaseMode.registers:setCurrentRegisterName(ch)
	return BaseMode
end

function BaseMode.setCurrentRegister(register)
	BaseMode.registers:setCurrentRegister(register)
	return BaseMode
end

function BaseMode.resetCurrentRegister()
	BaseMode.registers:resetCurrentRegister()
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

function BaseMode.setRegister(ch,register)
	BaseMode.registers:setRegister(ch,register)
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

function BaseMode.grabInput()
	return Input:getCh()
end

return BaseMode
