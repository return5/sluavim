local setmetatable <const> = setmetatable
local io = io

local Cursor <const> = {type = "cursor"}
Cursor.__index = Cursor

_ENV = Cursor

function Cursor:moveY(amount)
	self.y = self.y + amount
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
	io.write("limit is: ",limit,"\n")
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
	return self:moveX(-self.x + 1)
end

function Cursor:newLineAbove()
	self:moveToStartOfLine()
	return self:moveUp()
end

function Cursor:newLine()
	self:moveToStartOfLine()
	return self:moveDown()
end

function Cursor:move(x,y)
	self.x = x
	self.y = y
	return self
end

function Cursor:new(x,y)
	return setmetatable({x = x, y = y},self)
end

return Cursor
