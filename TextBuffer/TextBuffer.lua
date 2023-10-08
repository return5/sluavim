local Line <const> = require('TextBuffer.Line')
local LinkedList <const> = require('collection.LinkedList')
local setmetatable <const> = setmetatable

local TextBuffer <const> = {}
TextBuffer.__index = TextBuffer

_ENV = TextBuffer


function TextBuffer:print()
	self.lines:iterate(Line.printAtRow)
end

function TextBuffer:removeLineAt(row)
	return self.lines:remove(row)
end

function TextBuffer:removeCharAt(row,column)
	self.lines:getItem(row):removeCharAt(column)
	if self.lines:getItem(row):isEmpty() then self:removeLineAt(row) end
	return self
end

function TextBuffer:replaceCharAt(row,column,char)
	self.lines:getItem(row):replaceCharAt(char,column)
	return self
end

function TextBuffer:addLineAt(pos)
	self.lines:add(Line:new(),pos)
	return self
end

function TextBuffer:addCharAt(row,char,column)
	self.lines:getItem(row):addChar(char,column)
	return self
end

function TextBuffer:new()
	return setmetatable({lines = LinkedList:new():add(Line:new())},self)
end

return TextBuffer
