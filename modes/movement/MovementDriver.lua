local BaseMode <const> = require('modes.BaseMode')
local MacroMovementFrom <const> = require('modes.macro.movement.MacroMovementFrom')
local MacroMovementFromBackwards <const> = require('modes.macro.movement.MacroMovementFromBackwards')
local MacroMovementTo <const> = require('modes.macro.movement.MacroMovementTo')
local MacroMovementToBackwards <const> = require('modes.macro.movement.MacroMovementToBackwards')

local MacroMovementDriver <const> = {type = "MacroMovementDriver"}
MacroMovementDriver.__index = MacroMovementDriver

setmetatable(MacroMovementDriver,BaseMode)

_ENV = MacroMovementDriver

function MacroMovementDriver.from()
	return MacroMovementFrom
end

function MacroMovementDriver.to()
	return MacroMovementTo
end

function MacroMovementDriver.fromBackwards()
	return MacroMovementFromBackwards
end

function MacroMovementDriver.toBackwards()
	return MacroMovementToBackwards
end

return MacroMovementDriver
