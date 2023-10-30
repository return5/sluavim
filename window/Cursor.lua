--[[
	class represents a cursor on screen with x and y coordinates.
	this class handles nothing but the x and y, no other attributes of the cursor are handled by this class.
--]]

local setmetatable <const> = setmetatable

local Cursor <const> = {type = "cursor"}
Cursor.__index = Cursor

_ENV = Cursor

function Cursor:isXGreaterEndOfLine(textBuffer)
	return self.x > textBuffer:getLengthOfLine(self.y)
end

function Cursor:moveY(amount)
	self.y = self.y + amount
	return self
end

function Cursor:moveToEndOfLine(textBuffer)
	self.x = textBuffer:getLengthOfLine(self.y)
	return self
end

function Cursor:moveUp()
	self:moveY(-1)
	if self.y <= 0 then self.y = 1 end
	return self
end

function Cursor:moveDown()
	return self:moveY(1)
end

function Cursor:moveDownWithLimit(limit)
	self:moveDown()
	if self.y > limit then self.y = limit end
	return self
end

function Cursor:limitXToLengthOfLine(textBuffer)
	local limit <const> = textBuffer:getLengthOfLine(self.y)
	if self.x > limit then self.x = limit end
	return self
end

function Cursor:limitYToSizeOfTextBuffer(textBuffer)
	local limit <const> = textBuffer:getSize()
	if self.y > limit then self.y = limit end
	return self
end

function Cursor:moveRightWithLimit(limit)
	self:moveRight()
	if self.x > limit then self.x = limit end
	return self
end

function Cursor:moveX(amount)
	self.x = self.x + amount
	return self
end

function Cursor:moveXTo(to)
	self.x = to
	return self
end

function Cursor:moveLeft()
	self:moveX(-1)
	if self.x <= 0 then self.x = 1 end
	return self
end

function Cursor:moveRight()
	return self:moveX(1)
end

function Cursor:moveToStartOfLine()
	self.x = 1
	return self
end

function Cursor:setX(newX)
	self.x = newX
	return self
end

function Cursor:newLine()
	return self:moveToStartOfLine():moveDown()
end

function Cursor:new(x,y)
	return setmetatable({x = x, y = y},self)
end

return Cursor
