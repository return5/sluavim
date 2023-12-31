--[[
	abstraction which represent a collection of text lines.
--]]

local Line <const> = require('TextBuffer.Line')
local LinkedList <const> = require('collection.LinkedList')
local Output <const> = require('localIO.Output')
local setmetatable <const> = setmetatable
local gmatch <const> = string.gmatch

local TextBuffer <const> = {type = "textbuffer"}
TextBuffer.__index = TextBuffer

_ENV = TextBuffer


function TextBuffer:readTextIntoBuffer(text)
	local column = 1
	local row = 1
	for char in gmatch(text,".") do
		if char == "\n" then
			row = row + 1
			self:newLine(row,row - 1,char)
			column = 0
		else
			self:insert(row,char,column)
		end
		column = column + 1
	end
	return self
end

function TextBuffer:searchAndReplace(start,stop,searchString,replaceString,replaceOptions)
	self.lines:searchAndReplace(start,stop,searchString,replaceString,replaceOptions,Line.returnConstructor)
	return self
end

function TextBuffer:print(window,ncursesWindow)
	local start <const>, limit <const> = window:getWindowStartEnd()
	self.lines:iterateBuffer(start,limit,Line.printAtRow,Output.newLine,ncursesWindow)
end

function TextBuffer:readIntoTable(strTbl)
	self.lines:readIntoTable(strTbl)
	return self
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
	self.lines:getItem(cursor:getY()):replaceCharAt(char,cursor:getX())
	return self
end

function TextBuffer:getLine(n)
	return self.lines:getNode(n)
end

function TextBuffer:getLengthOfLine(line)
	local lineNode = self:getLine(line)
	if not lineNode then return -1 end
	local item = lineNode:getItem()
	if not item then return -1 end
	return item:getSize()
end

function TextBuffer:grabRowFrom(cursor)
	 return self:getLine(cursor:getY()):getItem():grabFrom(cursor:getX())
end

function TextBuffer:addLineAt(pos)
	self.lines:add(Line:new(),pos)
	return self
end

function TextBuffer:newLine(newPos,oldPos,ch)
	self:addEndingNewLine(oldPos,ch):addLineAt(newPos)
	if newPos < self:getSize() then
		self:addEndingNewLine(newPos,ch)
	end
	return self
end

function TextBuffer:insert(row,char,column)
	self.lines:getItem(row):addChar(char,column)
	return self
end

function TextBuffer:insertAtStart(pos,chars)
	self:getLine(pos):getItem():insertNodeAtStart(chars)
end

function TextBuffer:findForwardPattern(cursor,pat)
	return self.lines:getItem(cursor:getY()):findForwardPattern(pat,cursor:getX())
end

function TextBuffer:getCharAtCursor(cursor)
	return self.lines:getItem(cursor:getY()):getCharAtCursor(cursor)
end

function TextBuffer:findBackwardsPattern(cursor,pat)
	return self.lines:getItem(cursor:getY()):findBackwardsPattern(pat,cursor:getX())
end

function TextBuffer:findBackwards(cursor,ch)
	local lines = self.lines:getItem(cursor:getY())
	return lines:findBackwards(ch,cursor:getX())
end

function TextBuffer:findForward(cursor,ch)
	return self.lines:getItem(cursor:getY()):findForward(ch,cursor:getX())
end

function TextBuffer:removeChars(start,stop,row,register)
	return self.lines:getItem(row):removeChars(start,stop,register)
end

function TextBuffer:copyChars(start,stop,row,register)
	return self.lines:getItem(row):copyChars(start,stop,register)
end

function TextBuffer:getSize()
	return self.lines:getSize()
end

function TextBuffer:removeCharAtEnd(row,ch)
	self.lines:getItem(row):removeCharAtEnd(ch)
	return self
end

function TextBuffer:addEndingNewLine(pos,ch)
	self.lines:getItem(pos):addEndingNewLine(ch)
	return self
end

function TextBuffer:doesLineExistAndHaveLength(y)
	if self:getSize() < y then return false end
	local node = self.lines:getNode(y)
	if not node then return false end
	local line = node:getItem()
	if not line then return false end
	return line:getSize() > 0
end

function TextBuffer:new()
	return setmetatable({lines = LinkedList:new():add(Line:new())},self)
end

return TextBuffer
