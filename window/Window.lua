local NcurseIO <const> = require('ncurses.NcursesIO')
local setmetatable <const> = setmetatable

local Window <const> = {}
Window.__index = Window

_ENV = Window

function Window:setYBasedOnCursor(cursor)
	local lines <const> = NcurseIO.getLines()
	if cursor.y < lines then
		self.y = 1
	else
		self.y = cursor.y - 1 - lines
	end
	return self
end

function Window:getHeight()
	return self.y + NcurseIO.getLines()
end

function Window:getWidth()
	return self.x + NcurseIO.getCols()
end

function Window:moveDown()
	self.y = self.y + 1
	return self
end

function Window:moveUp()
	self.y = self.y - 1
	return self
end

function Window:setY(cursor)
	if cursor.y > self.y + NcurseIO.getLines() then
		self:moveWindowDown()
	elseif cursor.y < self.y then
		self:moveUp()
	end
	return self
end

function Window:new(x,y)
	return setmetatable({x = x,y = y},self)
end

return Window
