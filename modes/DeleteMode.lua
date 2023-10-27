--[[
	class for delete mode. handles deleting text from a textBuffer when using 'd' commands in NormalMode and VisualSelect mode
--]]

local DeleteAndYankParent <const> = require('modes.DeleteAndYankParent')

local DeleteMode <const> = {type = "deletemode"}
DeleteMode.__index = DeleteMode
setmetatable(DeleteMode,DeleteAndYankParent)

_ENV = DeleteMode

function DeleteMode.doAfterSelectEntireLine(textBuffer,cursor)
	textBuffer:removeLineAt(cursor.y)
	DeleteMode.doAfter = DeleteMode.returnDeleteMode
	return DeleteMode
end

function DeleteMode.action(textBuffer,startChar,stopChar,y,register)
	textBuffer:removeChars(startChar,stopChar,y,register)
	return DeleteMode
end

function DeleteMode.deleteCurrentChar(textBuffer,cursor)
	return DeleteMode:deleteOrYankCharacters(textBuffer,cursor,cursor.x)
end

DeleteMode.doAfter = DeleteMode.returnDeleteMode

return DeleteMode
