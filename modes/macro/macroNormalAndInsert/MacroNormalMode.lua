local MacroInsertAndNormalModeParent <const> = require('modes.macro.macroNormalAndInsert.MacroInsertAndNormalModeParent')
local NormalMode <const> = require('modes.NormalMode')
local pairs <const> = pairs

local MacroNormalMode <const> = {type = "MacroNormalMode"}
MacroNormalMode.__index = MacroNormalMode

setmetatable(MacroNormalMode, MacroInsertAndNormalModeParent)

_ENV = MacroNormalMode

function MacroNormalMode.default()
	return MacroNormalMode
end

local function wrapFunctionsToReturnMacroMode(chars,returnMode)
	for i=1,#chars,1 do
		MacroNormalMode.keyBindings[chars[i]] = MacroInsertAndNormalModeParent.wrapInsertOrNormalModeFunction(NormalMode.keyBindings[chars[i]],returnMode)
	end
end

function MacroNormalMode.setMacroInsertMode(macroInsertMode)
	wrapFunctionsToReturnMacroMode({'a','A','i','I'},macroInsertMode)
	return MacroNormalMode
end

function MacroNormalMode.setMacroDeleteModeDriver(macroDeleteModeDriver)
	wrapFunctionsToReturnMacroMode({'d'},macroDeleteModeDriver)
	return MacroNormalMode
end

local function setMacroMovementFuncs(macroMoveDriver)
	MacroNormalMode.keyBindings.f = macroMoveDriver.from
	MacroNormalMode.keyBindings.F = macroMoveDriver.fromBackwards
	MacroNormalMode.keyBindings.T = macroMoveDriver.toBackwards
	MacroNormalMode.keyBindings.t = macroMoveDriver.to
end

function MacroNormalMode.setMacroMoveDriver(macroMoveDriver)
	setMacroMovementFuncs(macroMoveDriver)
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

function MacroNormalMode.setDriverModes(macroInsertMode,macroDeleteModeDriver,macroMovementDriver)
	MacroNormalMode.setMacroInsertMode(macroInsertMode)
	MacroNormalMode.setMacroDeleteModeDriver(macroDeleteModeDriver)
	MacroNormalMode.setMacroMoveDriver(macroMovementDriver)
	return MacroNormalMode
end

return MacroNormalMode
