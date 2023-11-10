--[[
	abstraction to represent an individual line of text.
--]]

local Output <const> = require('localIO.Output')
local LinkedList <const> = require('collection.LinkedList')
local setmetatable <const> = setmetatable
local concat <const> = table.concat
local gsub <const> = string.gsub
local tonumber <const> = tonumber

local Line <const> = {type = "line"}
Line.__index = Line

_ENV = Line


local function getReplaceNumber(replaceOption)
	if replaceOption == nil or replaceOption == "" then return nil end
	return tonumber(replaceOption)
end

function Line:searchAndReplace(searchString,replaceString,replaceOptions)
	local strTbl <const> = {}
	self.chars:readLineIntoTable(strTbl)
	local replaceNumber <const> = getReplaceNumber(replaceOptions)
	local newString <const> = gsub(concat(strTbl),searchString,replaceString,replaceNumber)
	return newString,self:isLineEnded()
end

function Line:printAtRow(row,ncursesWindow)
	self.chars:iterate(Output.printCharAt,ncursesWindow,row)
end

function Line:isLineEnded()
	return self.chars:isLineEnded()
end

function Line:replaceCharAt(char,column)
	self.chars:replace(column,char)
	return self
end

function Line:insertNodeAtStart(node)
	self.chars:setHead(node)
	return self
end

function Line:grabFrom(n)
	local node <const> = self.chars:getNode(n)
	if node and node.prev then
		node.prev.next = nil
	end
	self.chars:setNewSize()
	return node
end

function Line:isEmpty()
	return self.chars:isEmpty()
end

function Line:removeCharAt(column)
	self.chars:remove(column)
	return self
end

function Line:addChar(char,pos)
	self.chars:add(char,pos)
	return self
end

function Line:insertChar(char)
	self.chars:add(char,self:getSize() + 1)
	return self
end

function Line:getSize()
	return self.chars.size
end

function Line:findForwardPattern(pattern,startPos)
	return self.chars:findForwardPattern(pattern,startPos)
end

function Line:getCharAtCursor(cursor)
	return self.chars:getItem(cursor.x)
end

function Line:findForward(ch,startPos)
	return self.chars:findForward(ch,startPos)
end

function Line:findBackwards(ch,startPos)
	return self.chars:findBackwards(ch,startPos)
end

function Line:findBackwardsPattern(pattern,startPos)
	return self.chars:findBackwardsPattern(pattern,startPos)
end

function Line:removeChars(start,stop,register)
	return self.chars:iterateNodes(start,stop,register,LinkedList.removeNodes)
end

function Line:copyChars(start,stop,register)
	return self.chars:iterateNodes(start,stop,register,LinkedList.returnSelf)
end

function Line:readIntoTable(strTbl)
	self.chars:readLineIntoTable(strTbl)
	return self
end

function Line:readIntoString()
	local str = {}
	self:readIntoTable(str)
	return concat(str)
end

function Line:addEndingNewLine(ch)
	self.chars:addEndingNode(ch)
end

function Line:removeCharAtEnd(ch)
	self.chars:removeIfMatchChar(ch,self.chars.size)
	return self
end

function Line.returnConstructor()
	return Line.new(Line)
end

function Line:getCharAt(x)
	return self.chars:getItem(x)
end

function Line:new()
	return setmetatable({chars = LinkedList:new()},self)
end

return Line
