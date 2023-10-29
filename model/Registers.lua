--[[
	class which represents a collection of registers.
--]]

local Registers <const> = {type = "Registers",registers = {},currentRegister = ""}
Registers.__index = Registers

_ENV = Registers

function Registers:getRegister(ch)
	return self.registers[ch]
end

function Registers:getCurrentRegister()
	return self:getRegister(self.currentRegister)
end

function Registers:setFirstRegister(register)
	self.registers[1] = register
	return self
end

function Registers:adjustRegister()
	local i = 1
	while self.registers[i] and i < 9 do
		self.registers[i + 1] = self.registers[i]
		i = i + 1
	end
	return self
end

function Registers:setRegister(ch)
	self.registers[ch] = {}
	self.currentRegister = ch
	return self
end

function Registers:setCurrentRegister(ch)
	self.currentRegister = ch
	return self:setRegister(ch)
end

function Registers:addToCurrentRegister(ch)
	local reg <const> = self:getCurrentRegister()
	reg[#reg + 1] = ch
	return self
end

return Registers
