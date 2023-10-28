--[[
	Parent class for NormalMode, InputMode, VisualSelect mode.
--]]

local Input <const> = require('localIO.Input')

local BaseMode <const> = {type = 'basemode',keyBindings = {},macros = {},currentRegister = "",registers = {{}}}
BaseMode.__index = BaseMode

_ENV = BaseMode

function BaseMode.default()
	return BaseMode
end

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

function BaseMode.addToMacro(ch)
	BaseMode.macros[BaseMode.currentRegister][#BaseMode.macros[BaseMode.currentRegister] + 1] = ch
	return BaseMode
end

function BaseMode:macroParseInput(ch,textBuffer,cursor)
	if ch ~= 'q' then BaseMode.addToMacro(ch) end
	return self:regularParseInput(ch,textBuffer,cursor)
end

function BaseMode:macroParseInputSetRegister(ch)
	BaseMode.macros[ch] = {}
	BaseMode.currentRegister = ch
	BaseMode.parseInput = BaseMode.macroParseInput
	return self
end

function BaseMode:regularParseInput(ch,textBuffer,cursor)
	if self.keyBindings[ch] then
		return self.keyBindings[ch](textBuffer,ch,cursor)
	else
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

--TODO make macroMode class
function BaseMode:runMacro(textBuffer,cursor)
	local ch <const> = Input.getCh()
	local mode = self
	for i=1,#BaseMode.macros[ch],1 do
		mode = mode:parseInput(BaseMode.macros[ch][i],textBuffer,cursor)
	end
	return mode
end

BaseMode.parseInput = BaseMode.regularParseInput

return BaseMode
