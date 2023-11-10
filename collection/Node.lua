 --[[
	a node class for linkedlist.
 --]]
local setmetatable <const> = setmetatable
local gmatch <const> = string.gmatch

local Node <const> = {type = "node"}
Node.__index = Node

_ENV = Node

function Node:setItem(item)
	self.item = item
	return self
end

function Node:doFunc(func,i,arg1,arg2)
	func(self.item,i,arg1,arg2)
	return self
end


 function Node:matchChar(ch)
	 return self.item == ch
 end

function Node:readIntoTable(strTbl)
 	strTbl[#strTbl + 1] = self:getItem()
 	return self
end

function Node:addNextNode(item)
	self.next = Node:new(self,item,self.next)
	return self.next
end

function Node:getItem()
	return self.item
end

 function Node:grabEndNode()
	 local endNode  = self
	 while endNode.next do
		endNode = endNode.next
	 end
	 return endNode
 end

 function Node:isEmpty()
	 return self:getItem():getSize() == 0 and not self:getItem():isLineEnded()
 end

 function Node.readStringAsLineIntoNode(lineConstruct,newString,isLineEnded,prevNode)
	 local prevChar = ""
	 local line = lineConstruct()
	 local node = Node:new(prevNode,line)
	 if isLineEnded then
		 line:addEndingNewLine("\n")
	 end
	 local headNode <const> = node
	 for char in gmatch(newString,".") do
		 if char == "\n" and prevChar ~= "\\" then
			 line:addEndingNewLine(char)
			 line = lineConstruct()
			 node = Node:new(node,line)
		 else
			 line:insertChar(char)
		 end
		 prevChar = char
	 end

	 if headNode:isEmpty() then
		 return nil
	 end
	 if node:isEmpty() and node.prev then
		 node.prev.next = nil
	 end

	 return headNode
 end


 function Node:replaceNode(newNode,nextNode)
	 if newNode then
		 local endNode <const> = newNode:grabEndNode()
		 if nextNode then
			 nextNode.prev = endNode
			 endNode.next = nextNode
		 end
	 end
	 return self
 end

function Node:new(prev,item,next)
	local node <const> = setmetatable({prev = prev,item = item,next = next},self)
	if next then
		node.next.prev = node
	end
	if prev then
		node.prev.next = node
	end
	return node
end

return Node
