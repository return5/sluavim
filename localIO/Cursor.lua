local setmetatable <const> = setmetatable

local Cursor <const> = {}
Cursor.__index = Cursor

_ENV = Cursor

function Cursor:move(x,y)
	self.x = x
	self.y = y
	return self
end

function Cursor:new(x,y)
	return setmetatable({x = x, y = y},self)
end

return Cursor
