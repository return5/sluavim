--[[
	class which represents a collection of registers.
--]]


local Registers <const> = {type = "Registers",registers = {},currentRegister = 1}
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
	if self.currentRegister == 1 then
		local i = 1
		while self.registers[i] and i < 9 do
			self.registers[i + 1] = self.registers[i]
			i = i + 1
		end
	end
	return self
end

function Registers:setRegister(ch,register)
	self.registers[ch] = register
	return self
end

function Registers:getCurrentRegisterName()
	return self.currentRegister
end

function Registers:setCurrentRegister(register)
	self.registers[self.currentRegister] = register
end

function Registers:addToCurrentRegister(ch)
	local reg <const> = self:getCurrentRegister()
	reg[#reg + 1] = ch
	return self
end

function Registers:setCurrentRegisterName(name)
	self.currentRegister = name
	return self
end

function Registers:resetCurrentRegister()
	self.currentRegister = 1
end

return Registers
