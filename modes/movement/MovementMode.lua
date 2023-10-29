local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')
local NormalMode <const> = require('modes.NormalMode')

local MovementMode <const> = {type = "MovementMode"}
MovementMode.__index = MovementMode

setmetatable(MovementMode,BaseMode)

_ENV = MovementMode

function MovementMode:parseInput(ch,textBuffer,cursor)
	if ch == KeyMap.ESC then return NormalMode.returnNormalMode() end
	local stop <const>, offset <const> = self:findFunction(textBuffer,cursor,ch)
	if stop == -1 then return NormalMode.returnNormalMode() end
	cursor.x = stop + offset
	return NormalMode.returnNormalMode()
end

function MovementMode:takeInput(textBuffer,cursor)
	local ch <const> = BaseMode.grabInput()
	return self:parseInput(ch,textBuffer,cursor)
end

return MovementMode
