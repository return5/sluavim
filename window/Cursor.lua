local setmetatable <const> = setmetatable

local Cursor <const> = {type = "cursor"}
Cursor.__index = Cursor

_ENV = Cursor

function Cursor:moveY(amount)
	self.y = self.y + amount
	return self
end

function Cursor:moveUp()
	return self:moveY(-1)
end

function Cursor:moveDown()
	return self:moveY(1)
end

function Cursor:moveX(amount)
	self.x = self.x + amount
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
