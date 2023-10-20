--[[
	abstraction to represent an individual line of text on screen
--]]
local Output <const> = require('localIO.Output')
local LinkedList <const> = require('collection.LinkedList')
local setmetatable <const> = setmetatable
local type = type

local Line <const> = {type = "line"}
Line.__index = Line

_ENV = Line

function Line:printAtRow(row)
	self.chars:iterate(Output.printCharAt,row)
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
	if node.prev then
		node.prev.next = nil
	end
	self.chars:setSize(n - 1)
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

function Line:new()
	return setmetatable({chars = LinkedList:new()},self)
end

return Line
