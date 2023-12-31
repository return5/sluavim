local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('localIO.KeyMapper')
local NormalMode <const> = require('modes.NormalMode')

local MovementMode <const> = {type = "MovementMode"}
MovementMode.__index = MovementMode

setmetatable(MovementMode,BaseMode)

_ENV = MovementMode

function MovementMode.returnNormalMode()
	return NormalMode
end

function MovementMode:move(textBuffer,cursor,ch)
	local stop <const>, offset <const> = self:findFunction(textBuffer,cursor,ch)
	if stop == -1 then return self.returnNormalMode() end
	cursor:setX(stop + offset)
	return self.returnNormalMode()
end

function MovementMode:parseInput(ch,textBuffer,cursor)
	if ch == KeyMap.ESC then return NormalMode.returnNormalMode() end
	return self:move(textBuffer,cursor,ch)
end

return MovementMode
