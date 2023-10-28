local MacroInsertAndNormalModeParent <const> = require('modes.macro.MacroInsertAndNormalModeParent')
local NormalMode <const> = require('modes.NormalMode')
local pairs <const> = pairs

local MacroNormalMode <const> = {type = "MacroNormalMode", macroInsertMode = "please remember to set this value before using this class."}
MacroNormalMode.__index = MacroNormalMode

setmetatable(MacroNormalMode, MacroInsertAndNormalModeParent)

_ENV = MacroNormalMode

function MacroNormalMode.default()
	return MacroNormalMode
end

local function wrapFunctionsToReturnMacroInsertMode()
	local chars <const> = {'a','A','i','I'}
	for i=1,#chars,1 do
		MacroNormalMode.keyBindings[chars[i]] = MacroInsertAndNormalModeParent.wrapInsertOrNormalModeFunction(NormalMode.keyBindings[chars[i]],MacroNormalMode.macroInsertMode)
	end
end

function MacroNormalMode.setMacroInsertMode(macroInsertMode)
	MacroNormalMode.macroInsertMode = macroInsertMode
	wrapFunctionsToReturnMacroInsertMode()
	return MacroNormalMode
end

function MacroNormalMode.endMacro()
	MacroNormalMode.currentRegister = ""
	return NormalMode
end

--make defensive copy
MacroNormalMode.keyBindings = {}
for k,v in pairs(NormalMode.keyBindings) do
	MacroNormalMode.keyBindings[k] = MacroNormalMode.wrapInsertOrNormalModeFunction(v,MacroNormalMode)
end

MacroNormalMode.keyBindings['q'] = MacroNormalMode.endMacro

return MacroNormalMode
