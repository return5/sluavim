--[[
	class which represents NormalMode in a VIM editor.
--]]

local BaseMode <const> = require('modes.BaseMode')
local InsertMode <const> = require('modes.InsertMode')

local NormalMode <const> = {
		type = 'NormalMode', deleteMode = "please remember to set this before using this class.",
		yankModeDriver = "please remember to set this before using this class.",
	}
NormalMode.__index = NormalMode

setmetatable(NormalMode,BaseMode)

_ENV = NormalMode

function NormalMode.default()
	return NormalMode
end

function NormalMode.returnInsertMode()
	return InsertMode
end

function NormalMode.moveToStartReturnInsertMode(_,_,cursor)
	cursor:moveToStartOfLine()
	return InsertMode
end

function NormalMode.moveLeft(_,_,cursor)
	cursor:moveLeft()
	return NormalMode
end

function NormalMode.moveUp(_,_,cursor)
	cursor:moveUp()
	return NormalMode
end

function NormalMode.moveRight(textBuffer,_,cursor)
	local limit <const> = textBuffer:getLengthOfLine(cursor.y) + 1
	cursor:moveRightWithLimit(limit)
	return NormalMode
end

function NormalMode.moveDown(textBuffer,_,cursor)
	local limit <const> = textBuffer:getSize()
	cursor:moveDownWithLimit(limit)
	return NormalMode
end

function NormalMode.moveRightAndReturnInsertMode(textBuffer,_,cursor)
	NormalMode.moveRight(textBuffer,nil,cursor)
	return InsertMode
end

function NormalMode.returnNormalMode()
	return NormalMode
end

function NormalMode.moveToEndAndReturnInsertMode(textBuffer,_,cursor)
	cursor:setX(textBuffer:getLengthOfLine(cursor.y) + 1)
	return InsertMode
end

function NormalMode.delete()
	return NormalMode.deleteModeDriver
end

function NormalMode.yank()
	return NormalMode.yankModeDriver
end

function NormalMode.deleteCurrentChar(textBuffer,_,cursor)
	NormalMode.deleteMode.deleteCurrentChar(textBuffer,cursor)
	cursor:limitXToLengthOfLine(textBuffer)
	return NormalMode
end

function NormalMode.deletePrevChar(textBuffer,_,cursor)
	cursor:moveLeft()
	NormalMode.deleteMode.deleteCurrentChar(textBuffer,cursor)
	return NormalMode
end


function NormalMode.insertNewLineBelowAndReturnInsertMode(textBuffer,_,cursor)
	return NormalMode.returnInsertMode().insertNewLineBelowAndReturnInsertMode(textBuffer,nil,cursor)
end

function NormalMode.insertNewLineAbove(textBuffer,_,cursor)
	return NormalMode.returnInsertMode().newLineAbove(textBuffer,nil,cursor)
end

function NormalMode:moveToEndOfLine(textBuffer,cursor)
	cursor:moveToEndOfLine(textBuffer)
	return NormalMode.returnNormalMode()
end

function NormalMode:moveToStartOfLine(_,cursor)
	cursor:moveToStartOfLine()
	return NormalMode.returnNormalMode()
end

function NormalMode.deleteTilEnd(textBuffer,_,cursor)
	--TODO rewrite this
	return NormalMode.deleteModeDriver.deleteToEnd(textBuffer,_,cursor)
end

--TODO test this.  move pasting to a mode or add to register class
function NormalMode.pasteRegister(textBuffer,_,cursor)
	--add this to register class
	local registerName <const> = BaseMode.registers.currentRegister ~= "" and BaseMode.registers.currentRegister or 1
	local register <const> = BaseMode.getRegister(registerName)
	local insertMode <const> = NormalMode.returnInsertMode()
	if #register > 0 then
		cursor:moveRight()
	end
	for i=1,#register,1 do
		insertMode.insertChar(textBuffer,register[i],cursor)
	end
	return NormalMode
end

NormalMode.keyBindings = {
	a = NormalMode.moveRightAndReturnInsertMode,
	A = NormalMode.moveToEndAndReturnInsertMode,
	i = NormalMode.returnInsertMode,
	I = NormalMode.moveToStartReturnInsertMode,
	h = NormalMode.moveLeft,
	j = NormalMode.moveDown,
	k = NormalMode.moveUp,
	l = NormalMode.moveRight,
	d = NormalMode.delete,
	D = NormalMode.deleteTilEnd,
	x = NormalMode.deleteCurrentChar,
	X = NormalMode.deletePrevChar,
	o = NormalMode.insertNewLineBelowAndReturnInsertMode,
	O = NormalMode.insertNewLineAbove,
	p = NormalMode.pasteRegister,
	['$'] = NormalMode.moveToEndOfLine,
	['^'] = NormalMode.moveToStartOfLine,
	y = NormalMode.yank
	--TODO :,y,P,~,"
}

function NormalMode.setYankModeDriver(yankModeDriver)
	--TODO reWrite this
	NormalMode.yankModeDriver = yankModeDriver
	return NormalMode
end

local function setMovementDriverFuncs(movementDriver)
	NormalMode.keyBindings.t = movementDriver.to
	NormalMode.keyBindings.T = movementDriver.toBackwards
	NormalMode.keyBindings.f = movementDriver.from
	NormalMode.keyBindings.F = movementDriver.fromBackwards
end

function NormalMode.setMovementDriver(movementDriver)
	setMovementDriverFuncs(movementDriver)
	return NormalMode
end

function NormalMode.setReplacementModeDriver(replaceDriver)
	NormalMode.keyBindings.r = replaceDriver.replaceChar
	NormalMode.keyBindings.R = replaceDriver.continuousReplacement
	return NormalMode
end

function NormalMode.setDrivers(replaceDriver,movementDriver,macroModeDriver,yankModeDriver,deleteModeDriver)
	NormalMode.setMovementDriver(movementDriver)
	NormalMode.setReplacementModeDriver(replaceDriver)
	NormalMode.deleteModeDriver = deleteModeDriver
end

return NormalMode

