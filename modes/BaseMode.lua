--[[
	Parent class for NormalMode, InputMode, VisualSelect mode.
--]]

local Input <const> = require('localIO.Input')

local BaseMode <const> = {type = 'basemode',keyBindings = {},macros = {},currentRegister = "current",registers = {{}}}
BaseMode.__index = BaseMode

_ENV = BaseMode

function BaseMode.default()
	return BaseMode
end

--TODO create register class
function BaseMode.adjustRegister()
	local i = 1
	while BaseMode.registers[i] and i < 9 do
		BaseMode.registers[i + 1] = BaseMode.registers[i]
		i = i + 1
	end
end

function BaseMode.setFirstRegister(register)
	BaseMode.registers[1] = register
end

function BaseMode.removeEndOfRegister()
	local register <const> = BaseMode.registers[BaseMode.currentRegister]
	if register and register[#register]then
		register[#register] = nil
	end
	return BaseMode
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
