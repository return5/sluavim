--[[
	abstraction to represent the size of the printable window on screen.
	functions as a sliding window. text which is visible on screen is inside of the sliding window.
	this is so the program only has to to print text on screen which is currently visible.
--]]

local Output <const> = require('localIO.Output')
local setmetatable <const> = setmetatable

local Window <const> = {type = "window"}
Window.__index = Window

_ENV = Window

function Window:setYBasedOnCursor(cursor)
	local lines <const> = Output.getWindowHeight()
	if cursor.y < lines then
		self.y = 1
	else
		self.y = cursor.y - 1 - lines
	end
	return self
end

function Window:getHeight()
	return self.y + Output.getWindowHeight()
end

function Window:getWidth()
	return self.x + Output.getWindowWidth()
end

function Window:moveDown()
	self.y = self.y + 1
	return self
end

function Window:moveUp()
	self.y = self.y - 1
	if self.y < 1 then self.y = 1 end
	return self
end

function Window:getWindowStartEnd()
	return self.y,self:getHeight()
end

function Window:getCursorYRelativeToWindow(cursor)
	return (cursor:getY() - self.y) + 1
end

function Window:moveYBy(amount)
	self.y = self.y + amount
	if self.y <= 0 then self.y = 1 end
	return self
end

function Window:setY(cursor)
	if cursor:getY() > self:getHeight()  or cursor:getY() < self.y then
		self:moveYBy(cursor:getY() - self:getHeight())
	end
	return self
end

function Window:getY()
	return self.y
end

function Window:new(x,y)
	return setmetatable({x = x,y = y},self)
end

return Window
