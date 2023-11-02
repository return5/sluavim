local DeleteParent <const> = require('modes.deleteAndYank.DeleteAndYankParent')

local DeleteMode <const> = {type = "DeleteMode"}
setmetatable(DeleteMode,DeleteParent)
DeleteMode.__index = DeleteMode

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

return DeleteMode
