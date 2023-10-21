--[[
	abstraction which represent a collection of text on screen
--]]
local Line <const> = require('TextBuffer.Line')
local LinkedList <const> = require('collection.LinkedList')
local setmetatable <const> = setmetatable

local TextBuffer <const> = {type = "textbuffer"}
TextBuffer.__index = TextBuffer

_ENV = TextBuffer

function TextBuffer:print(window)
	local start <const>, limit <const> = window:getWindowStartEnd()
	self.lines:iterateBuffer(start,limit,Line.printAtRow)
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

function TextBuffer:getLine(n)
	return self.lines:getNode(n)
end

function TextBuffer:getLengthOfLine(line)
	return self:getLine(line):getItem():getSize()
end

function TextBuffer:grabRowFrom(cursor)
	 return self:getLine(cursor.y):getItem():grabFrom(cursor.x + 1)
end

function TextBuffer:addLineAt(pos)
	self.lines:add(Line:new(),pos)
	return self
end

function TextBuffer:insert(row,char,column)
	self.lines:getItem(row):addChar(char,column)
	return self
end

function TextBuffer:findBackwards(cursor,ch)
	local lines = self.lines:getNode(cursor.y):getItem()
	return lines:findBackwards(ch,cursor.x)
end

function TextBuffer:findForward(cursor,ch)
	return self.lines:getNode(cursor.y):getItem():findForward(ch,cursor.x)
end

function TextBuffer:removeChars(start,cursor,register)
	return self.lines:getNode(cursor.y):getItem():removeChars(start,cursor.x,register)
end

function TextBuffer:getSize()
	return self.lines.size
end

function TextBuffer:new()
	return setmetatable({lines = LinkedList:new():add(Line:new())},self)
end

return TextBuffer
