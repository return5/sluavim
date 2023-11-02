local DeleteParent <const> = require('modes.deleteAndYank.DeleteAndYankParent')

local DeleteMode <const> = {type = "DeleteMode"}
DeleteMode.__index = DeleteMode
setmetatable(DeleteMode,DeleteParent)

--make a local defensive copy
DeleteMode.keyBindings = {}
for key,func in pairs(DeleteParent.keyBindings) do
	DeleteMode.keyBindings[key] = func
end

_ENV = DeleteMode

function DeleteMode.action(textBuffer,start,stop,row,register)
	textBuffer:removeChars(start,stop,row,register)
	return DeleteMode
end

function DeleteMode:parseInput(ch,textBuffer,cursor)
	return DeleteParent.parseInput(self,ch,textBuffer,cursor)
end

function DeleteMode:takeInput(textBuffer,cursor)
	return DeleteParent.takeInput(self,textBuffer,cursor)
end

return DeleteMode
