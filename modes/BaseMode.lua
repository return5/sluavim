local Input <const> = require('localIO.Input')

local BaseMode <const> = {type = 'basemode',keyBindings = {},macros = {},currentRegister = ""}
BaseMode.__index = BaseMode

_ENV = BaseMode

function BaseMode.default()
	return BaseMode
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
	end
	return self.default(textBuffer,ch,cursor)
end

function BaseMode:takeInput(textBuffer,cursor)
	local ch <const> = Input.getCh()
	return self:parseInput(ch,textBuffer,cursor)
end

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
