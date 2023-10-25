local DeleteAndYankParent <const> = require('modes.DeleteAndYankParent')

local DeleteMode <const> = {type = "deletemode"}
DeleteMode.__index = DeleteMode
setmetatable(DeleteMode,DeleteAndYankParent)

_ENV = DeleteMode


function DeleteMode.returnDeleteMode()
	return DeleteMode
end

function DeleteMode.doAfterSelectEntireLine(textBuffer,cursor)
	textBuffer:removeLineAt(cursor.y)
	--TODO set cursor up if it is at bottom of page
	DeleteMode.doAfter = DeleteMode.returnDeleteMode()
	return DeleteMode.returnDeleteMode()
end

function DeleteMode.action(textBuffer,startChar,stopChar,y,register)
	textBuffer:removeChars(startChar,stopChar,y,register)
	return DeleteMode.returnDeleteMode()
end

function DeleteMode.deleteCurrentChar(textBuffer,cursor)
	return DeleteMode.deleteChars(textBuffer,cursor.x,cursor)
end

return DeleteMode
