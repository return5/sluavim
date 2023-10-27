--[[
	abstraction to represent the size of the printable window on screen.
	functions as a sliding window. text which is visible on screen is inside of the sliding window.
	this is so the program only has to to print text on screen which is currently visible.
--]]

local NcurseIO <const> = require('ncurses.NcursesIO')
local setmetatable <const> = setmetatable

local Window <const> = {type = "window"}
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

function Window:getWindowStartEnd()
	return self.x,self:getHeight()
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
