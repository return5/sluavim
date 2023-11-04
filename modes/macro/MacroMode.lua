
local BaseMode <const> = require('modes.BaseMode')
local SetMacroMode <const> = require('modes.macro.SetMacroMode')
local RunMacroMode <const> = require('modes.macro.RunMacroMode')

local MacroMode <const> = {type = "MacroMode"}
MacroMode.__index = MacroMode

setmetatable(MacroMode,BaseMode)


function MacroMode.returnSetMacroMode()
	return SetMacroMode
end

function MacroMode.returnRunMacroMode()
	return RunMacroMode
end

return MacroMode
