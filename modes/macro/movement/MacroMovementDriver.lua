local BaseMode <const> = require('modes.BaseMode')
local MacroMovementFrom <const> = require('modes.macro.movement.MacroMovementFrom')
local MacroMovementFromBackwards <const> = require('modes.macro.movement.MacroMovementFromBackwards')
local MacroMovementTo <const> = require('modes.macro.movement.MacroMovementTo')
local MacroMovementToBackwards <const> = require('modes.macro.movement.MacroMovementToBackwards')

local MacroMovementDriver <const> = {type = "MacroMovementDriver"}
MacroMovementDriver.__index = MacroMovementDriver

setmetatable(MacroMovementDriver,BaseMode)

_ENV = MacroMovementDriver

--make these MacroMovementModes
function MacroMovementDriver.from(_,ch)
	BaseMode.insertIntoCurrentRegister(ch)
	return MacroMovementFrom
end

function MacroMovementDriver.to(_,ch)
	BaseMode.insertIntoCurrentRegister(ch)
	return MacroMovementTo
end

function MacroMovementDriver.fromBackwards(_,ch)
	BaseMode.insertIntoCurrentRegister(ch)
	return MacroMovementFromBackwards
end

function MacroMovementDriver.toBackwards(_,ch)
	BaseMode.insertIntoCurrentRegister(ch)
	return MacroMovementToBackwards
end

return MacroMovementDriver
