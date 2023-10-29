 --[[
	a node class for linkedlist.
 --]]
local setmetatable <const> = setmetatable

local Node <const> = {type = "node"}
Node.__index = Node

_ENV = Node

function Node:setItem(item)
	self.item = item
	return self
end

function Node:doFunc(func,i,arg1)
	func(self.item,i,arg1)
	return self
end


 function Node:matchChar(ch)
	 return self.item == ch
 end

function Node:readIntoTable(strTbl)
 strTbl[#strTbl + 1] = self.item
 return self
end

function Node:addNextNode(item)
	self.next = Node:new(self,item,self.next)
	return self.next
end

function Node:getItem()
	return self.item
end

function Node:new(prev,item,next)
	return setmetatable({prev = prev,item = item,next = next},self)
end

return Node
