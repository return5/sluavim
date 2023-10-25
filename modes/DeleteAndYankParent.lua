local NormalMode <const> = require('modes.NormalMode')
local BaseMode <const> = require('modes.BaseMode')

local DeleteAndYankParent <const> = {type = "deleteandyankparent"}
DeleteAndYankParent.__index = DeleteAndYankParent


function DeleteAndYankParent:action()
	return DeleteAndYankParent.returnDeleteAndYankParent()
end

function DeleteAndYankParent:doAction(textBuffer,cursor)
	local start <const> = cursor.x
	local returnMode <const> = NormalMode:takeInput(textBuffer,cursor)
	if cursor.x ~= start then
		BaseMode.adjustRegister()
		local register <const> = {}
		local startChar <const> = start <= cursor.x and start or cursor.x
		local stopChar <const> = cursor.x >= start and cursor.x or start
		self.action(textBuffer,startChar,stopChar,cursor.y,register)
		BaseMode.setFirstRegister(register)
		self.doAfter(textBuffer,cursor)
	end
	return returnMode
end

function DeleteAndYankParent.returnDeleteAndYankParent()
	return DeleteAndYankParent
end

function DeleteAndYankParent.doAfterSelectEntireLine()
	DeleteAndYankParent.doAfter = DeleteAndYankParent.returnDeleteAndYankParent
	return DeleteAndYankParent.returnDeleteAndYankParent()
end

function DeleteAndYankParent.selectEntireLine(textBuffer,cursor,mode)
	cursor:moveToStartOfLine(1)
	DeleteAndYankParent.keyBindings['$'](textBuffer,cursor)
	mode.doAfter = mode.doAfterSelectEntireLine
	return DeleteAndYankParent
end

function DeleteAndYankParent:takeInput(textBuffer,cursor)
	local ch <const> = BaseMode.grabInput()
	if self.keyBindings[ch] then
		self.keyBindings[ch](textBuffer,cursor,self)
		self:doAction(textBuffer,cursor)
	end
	return NormalMode
end

DeleteAndYankParent.keyBindings = {
	t = NormalMode.keyBindings.t,
	T = NormalMode.keyBindings.T,
	f = NormalMode.keyBindings.f,
	F = NormalMode.keyBindings.F,
	d = DeleteAndYankParent.selectEntireLine,
	['$'] = NormalMode.setTakeInputToMoveToEndOfLine,
	['^'] = NormalMode.setTakeInputToMoveToStartOfLine
}

return DeleteAndYankParent
