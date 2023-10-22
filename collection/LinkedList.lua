--[[
	a simple linkedlist class.
--]]

local Node <const> = require('collection.Node')
local setmetatable <const> = setmetatable
local io = io

local LinkedList <const> = {type = "linkedlist"}
LinkedList.__index = LinkedList

_ENV = LinkedList

function LinkedList:selectNodes(start,stop,register)
	local i = start
	local startNode = self:getNode(start)
	local temp = startNode
	while temp and i < stop do
		register[#register + 1] = temp:getItem()
		temp = temp.next
		i = i + 1
	end
	if temp then
		register[#register + 1] = temp:getItem()
	end
	return startNode,temp
end

function LinkedList:removeNodes(start,stop,register)
	if start > self.size then return self end
	local startNode <const>, stopNode <const> = self:selectNodes(start,stop,register)
	local nextNode <const> = stopNode and stopNode.next or nil
	if startNode == self.head then
		self.head = nextNode
	end
	if startNode.prev then
		startNode.prev.next = nextNode
	end
	if nextNode then
		nextNode.prev = startNode.prev
	end
	self:setNewSize()
	return self
end

function LinkedList:find(ch,x,offset,nextNodeFunc)
	local newX = x + offset
	local temp = self:getNode(newX)
	while temp do
		if temp:getItem() == ch then
			return newX
		end
		temp = nextNodeFunc(temp)
		newX = newX + offset
	end
	return -1
end

function LinkedList:findForward(ch,x)
	return self:find(ch,x,1,function(temp) return temp.next end)
end

function LinkedList:findBackwards(ch,x)
	return self:find(ch,x,-1,function(temp) return temp.prev end)
end

function LinkedList:setNewSize()
	local temp = self.head
	self.size = 0
	while temp do
		self:incrementSize()
		temp = temp.next
	end
	return self
end

function LinkedList:setHead(node)
	self.head = node
	self:setNewSize()
	return self
end

function LinkedList:iterateBuffer(start,limit,func)
	local node = self:getNode(start)
	local i = start
	local loopLimit <const> = limit <= self.size and limit or self.size
	while i <= loopLimit and node do
		node:doFunc(func,i)
		node = node.next
		i = i + 1
		io.write("\n")
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
	local node = self.head
	local i = 1
	while i < index and node do
		node = node.next
		i = i + 1
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
	self:incrementSize()
	return self
end

function LinkedList:incrementSize()
	self.size = self.size + 1
	return self
end

function LinkedList:setSize(size)
	self.size = size
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
