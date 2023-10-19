--[[
	a simple linkedlist class.
--]]

local Node <const> = require('collection.Node')
local setmetatable <const> = setmetatable
local io = io

local LinkedList <const> = {}
LinkedList.__index = LinkedList

_ENV = LinkedList


function LinkedList:iterateBuffer(start,limit,func)
	local node = self:getNode(start)
	local i = start
	local loopLimit <const> = limit <= self.size and limit or self.size
	while i <= loopLimit and node do
		node:doFunc(func,i)
		io.write("\n-----\n")
		node = node.next
		i = i + 1
	end
	return self
end

function LinkedList:iterate(func,arg1)
	local node = self.head
	for i=1,self.size,1 do
		node:doFunc(func,i,arg1)
		node = node.next
	end
	return self
end

function LinkedList:getNode(index)
	local newIndex <const> = (index <= 1 and 0) or (index > self.size and self.size - 1) or index - 1
	local node = self.head
	for i=1,newIndex,1 do
		node = node.next
	end
	return node
end

function LinkedList:add(item,index)
	if self.size == 0 then
		self.head = Node:new(nil,item)
	elseif index == 1 then
		self.head = Node:new(nil,item,self.head)
	else
		local newIndex <const> = index or self.size + 1
		local node <const> = self:getNode(newIndex - 1)
		node:addNextNode(item)
	end
	self.size = self.size + 1
	return self
end

function LinkedList:isEmpty()
	return self.size == 0
end

local function removeNode(linkedList,index)
	local node <const> = linkedList:getNode(index)
	local nextNode <const> = node.next
	if node.prev then
		node.prev.next = node.next
	end
	if nextNode then
		nextNode.prev = node.prev
	end
	node.next = nil
	node.prev = nil
	return nextNode
end

function LinkedList:remove(index)
	if self.size == 0 then
		return self
	end
	if index == 1 then
		self.head = removeNode(self,index)
	else
		removeNode(self,index)
	end
	self.size = self.size - 1
	return self
end

function LinkedList:getItem(index)
	 return self:getNode(index):getItem()
end

function LinkedList:replace(index,item)
	local node <const> = self:getNode(index)
	node:setItem(item)
	return self
end

function LinkedList:new()
	return setmetatable({size = 0},self)
end

return LinkedList
