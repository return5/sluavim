local NormalMode <const> = require('modes.NormalMode')
local MacroModeBase <const> = require('modes.macro.MacroModeBase')
local BaseMode <const> = require('modes.BaseMode')
local io = io

local MacroMode <const> = {type = "MacroMode"}
MacroMode.__index = MacroMode

setmetatable(MacroMode,MacroModeBase)

--make a defensive copy
MacroMode.keyBindings = {}
for k,v in pairs(NormalMode.keyBindings) do
	MacroMode.keyBindings[k] = v
end

_ENV = MacroMode

function MacroMode.addToMacro(ch)
	local currentMacro <const> = MacroMode.macros[MacroMode.currentRegister]
	currentMacro[#currentMacro + 1] = ch
	return MacroMode
end

function MacroMode:doAction(textBuffer,ch,cursor)
	MacroMode.addToMacro(ch)
	return self:parseInput(ch,textBuffer,cursor)
end

function MacroMode.endMacro()
	io.write("ending macro\n")
	MacroMode.removeEndOfRegister()
	MacroMode.currentRegister = ""
	return NormalMode
end

function MacroMode:returnAfterEsc()
	io.write("returning after esc\n")
	return MacroMode
end

MacroMode.keyBindings['q'] = MacroMode.endMacro

return MacroMode
