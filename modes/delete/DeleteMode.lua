--[[
	class for delete mode. handles deleting text from a textBuffer when using 'd' commands in NormalMode and VisualSelect mode
--]]

local DeleteAndYankParent <const> = require('modes.DeleteAndYankParent')

local DeleteMode <const> = {}
DeleteMode.__index = DeleteMode
setmetatable(DeleteMode,DeleteAndYankParent)

_ENV = DeleteMode

function DeleteMode.action(textBuffer,startChar,stopChar,y,register)
	textBuffer:removeChars(startChar,stopChar,y,register)
	return DeleteMode
end

function DeleteMode.deleteCurrentChar(textBuffer,cursor)
	return DeleteMode:deleteOrYankCharacters(textBuffer,cursor,cursor.x)
end

return DeleteMode
