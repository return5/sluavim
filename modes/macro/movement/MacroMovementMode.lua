local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')
local MacroNormalMode <const> = require('modes.macro.macroNormalAndInsert.MacroNormalMode')

local MacroMovementMode <const> = {type = "MacroMovementMode"}
MacroMovementMode.__index = MacroMovementMode

setmetatable(MacroMovementMode,BaseMode)

_ENV = MacroMovementMode

function MacroMovementMode:parseInput(ch,textBuffer,cursor)
	if ch == KeyMap.ESC then return MacroNormalMode end
	local stop <const>, offset <const> = self:findFunction(textBuffer,cursor,ch)
	if stop == -1 then return MacroNormalMode end
	cursor:setX(stop + offset)
	return MacroNormalMode
end

function MacroMovementMode:takeInput(textBuffer,cursor)
	local ch <const> = BaseMode.grabInput()
	BaseMode.insertIntoCurrentRegister(ch)
	return self:parseInput(ch,textBuffer,cursor)
end

return MacroMovementMode
