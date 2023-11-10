--[[
	a simple linkedlist class.
--]]

local Node <const> = require('collection.Node')
local setmetatable <const> = setmetatable
local match <const> = string.match

local LinkedList <const> = {type = "linkedlist"}
LinkedList.__index = LinkedList

_ENV = LinkedList



function LinkedList:searchAndReplace(start,stop,searchString,replaceString,replaceOptions,lineConstruct)
	local i = start
	local temp = self:getNode(start)
	while i <= stop and temp do
		local newString <const>,isLineEnded <const> = temp:getItem():searchAndReplace(searchString,replaceString,replaceOptions)
		local newNode <const> = Node.readStringAsLineIntoNode(lineConstruct,newString,isLineEnded,temp.prev)
		local temp2  <const> = temp.next
		self:replaceNode(temp,newNode,temp2)
		temp = temp2
		i = i + 1
	end
	return self
end

function LinkedList:replaceNode(node,newNode,nextNode)
	node:replaceNode(newNode,nextNode)
	if node == self.head then
		self.head = newNode
	end
	return self
end

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

function LinkedList:removeNodes(startNode,nextNode)
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

function LinkedList:returnSelf()
	return self
end

function LinkedList:iterateNodes(start,stop,register,func2)
	if start > self.size then return self end
	local startNode <const>, stopNode <const> = self:selectNodes(start,stop,register)
	local nextNode <const> = stopNode and stopNode.next or nil
	return func2(self,startNode,nextNode)
end

function LinkedList:find(expected,x,offset,nextNodeFunc,findFunction)
	local newX = x + offset
	local temp = self:getNode(newX)
	while temp do
		if findFunction(temp,expected) then
			return newX
		end
		temp = nextNodeFunc(temp)
		newX = newX + offset
	end
	return -1
end

function LinkedList.findPattern(node,pattern)
	return match(node:getItem(),pattern)
end

function LinkedList.findChar(node,char)
	return node:getItem() == char
end

local function returnNextNode(temp)
	return temp.next
end

function LinkedList:findForward(expected,startPos)
	return self:find(expected,startPos,1,returnNextNode,LinkedList.findChar)
end

function LinkedList:findForwardPattern(expected,startPos)
	local stop <const> = self:find(expected,startPos,1,returnNextNode,LinkedList.findPattern)
	return stop ~= -1 and stop or self.size + 1
end

local function returnPreviousNode(temp)
	return temp.prev
end

function LinkedList:findBackwardsPattern(expected,startPos)
	local stop <const> = self:find(expected,startPos,-1,returnPreviousNode,LinkedList.findPattern)
	return stop ~= -1 and stop or 0
end

function LinkedList:findBackwards(expected,startPos)
	return self:find(expected,startPos,-1,returnPreviousNode,LinkedList.findChar)
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

function LinkedList:removeIfMatchChar(ch,index)
	local node <const> = self:getNode(index)
	if node:matchChar(ch) then
		return self:remove(index)
	end
	return self
end

function LinkedList:readLineIntoTable(strTbl)
	local temp = self.head
	while temp do
		temp:readIntoTable(strTbl)
		temp = temp.next
	end
	return self
end

--TODO eliminate this code duplication
function LinkedList:readIntoTable(strTbl)
	local temp = self.head
	while temp do
		temp:getItem():readIntoTable(strTbl)
		strTbl[#strTbl + 1] = "\n"
		temp = temp.next
	end
	if #strTbl > 0 then
		strTbl[#strTbl] = nil
	end
	return self
end

function LinkedList:iterateBuffer(start,limit,func,func2,ncursesWindow)
	local node = self:getNode(start)
	local i = 1
	local loopCounter = start
	local loopLimit <const> = limit <= self.size and limit or self.size
	while loopCounter <= loopLimit and node do
		node:doFunc(func,i,ncursesWindow)
		node = node.next
		i = i + 1
		loopCounter = loopCounter + 1
		func2(ncursesWindow)
	end
	return self
end

function LinkedList:iterate(func,arg1,arg2)
	local node = self.head
	local i = 1
	while node do
		node:doFunc(func,i,arg1,arg2)
		node = node.next
		i = i + 1
	end
	if self.endingNode and self.endingNode.item then
		self.endingNode:doFunc(func,i,arg1,arg2)
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

function LinkedList:getItem(index)
	local node <const> = self:getNode(index)
	if node then return node.item end
	return nil
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
		node.prev.next = nextNode
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

function LinkedList:getSize()
	return self.size
end

function LinkedList:addEndingNode(ch)
	self.endingNode = Node:new(nil,ch)
	return self
end

function LinkedList:isLineEnded()
	return self.endingNode ~= nil
end

function LinkedList:new()
	return setmetatable({size = 0},self)
end

return LinkedList
