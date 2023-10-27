--[[
	abstraction which represent a collection of text lines.
--]]

local Line <const> = require('TextBuffer.Line')
local LinkedList <const> = require('collection.LinkedList')
local Output <const> = require('localIO.Output')
local setmetatable <const> = setmetatable

local TextBuffer <const> = {type = "textbuffer"}
TextBuffer.__index = TextBuffer

_ENV = TextBuffer

function TextBuffer:print(window)
	local start <const>, limit <const> = window:getWindowStartEnd()
	self.lines:iterateBuffer(start,limit,Line.printAtRow,Output.newLine)
end

function TextBuffer:removeLineAt(row)
	return self.lines:remove(row)
end

function TextBuffer:removeCharAt(row,column)
	self.lines:getItem(row):removeCharAt(column)
	if self.lines:getItem(row):isEmpty() then self:removeLineAt(row) end
	return self
end

function TextBuffer:replaceCharAt(char,cursor)
	self.lines:getItem(cursor.y):replaceCharAt(char,cursor.x)
	return self
end

function TextBuffer:getLine(n)
	return self.lines:getNode(n)
end

function TextBuffer:getLengthOfLine(line)
	local lineNode = self:getLine(line)
	local item = lineNode:getItem()
	return item:getSize()
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

function TextBuffer:removeChars(start,stop,row,register)
	return self.lines:getNode(row):getItem():removeChars(start,stop,register)
end

function TextBuffer:getSize()
	return self.lines.size
end

function TextBuffer:new()
	return setmetatable({lines = LinkedList:new():add(Line:new())},self)
end

return TextBuffer
