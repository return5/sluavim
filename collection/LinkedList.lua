local Node <const> = require('collection.Node')
local setmetatable <const> = setmetatable
local Output <const> = require('localIO.Output')

local LinkedList <const> = {}
LinkedList.__index = LinkedList

_ENV = LinkedList


function LinkedList:iterate(func,arg1)
	local node = self.head
	for i=1,self.size,1 do
		node:doFunc(func,i,arg1)
		node = node.next
	end
	return self
end

function LinkedList:getNode(index)
	local newIndex <const> = (index <= 0 and 0) or (index > self.size and self.size - 1) or index - 1
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
		self.head = self.head:addNextNode(item)
	else
		local newIndex <const> = index or self.size + 1
		local node <const> = self:getNode(newIndex - 1)
		node:addNextNode(item)
	end
	self.size = self.size + 1
	return self
end

local function removeNode(linkedList,index)
	local node <const> = linkedList:getNode(index)
	node.prev.next = node.next
	if node.next then
		node.next.prev = node.prev
	end
	node.next = nil
	node.prev = nil
end

function LinkedList:remove(index)
	if self.size == 0 then
		return self
	end
	if index == 1 then
		self.head = self.head.next
		self.head.prev = nil
	end
	removeNode(self,index)
	self.size = self.size - 1
end

function LinkedList:getItem(index)
	local node  = self:getNode(index)
	return node:getItem()
end

function LinkedList:new()
	return setmetatable({size = 0},self)
end

return LinkedList
