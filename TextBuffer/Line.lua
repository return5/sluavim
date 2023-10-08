local Output <const> = require('localIO.Output')
local LinkedList <const> = require('collection.LinkedList')
local setmetatable <const> = setmetatable

local Line <const> = {}
Line.__index = Line

_ENV = Line

function Line.printLine(line,row)
	line.chars:iterate(Output.printCharAt,row)
end

function Line:replaceCharAt(char,column)
	local index <const> = column or #self.chars
	self.chars[index] = char
	return self
end

function Line:isEmpty()
	return #self.chars == 0
end

function Line:removeCharAt(column)
	remove(self.chars,column)
	return self
end

function Line:addChar(char,pos)
	self.chars:add(char,pos)
	return self
end

function Line:new()
	return setmetatable({chars = LinkedList:new()},self)
end

return Line
