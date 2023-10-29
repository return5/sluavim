--[[
	class for delete mode. handles deleting text from a textBuffer when using 'd' commands in NormalMode and VisualSelect mode
--]]

local MacroDeleteAndYankParent <const> = require('modes.macro.MacroDeleteAndYankParent')

local MacroDeleteMode <const> = {}
MacroDeleteMode.__index = MacroDeleteMode

setmetatable(MacroDeleteMode,MacroDeleteAndYankParent)

_ENV = MacroDeleteMode

function MacroDeleteMode.action(textBuffer,startChar,stopChar,y,register)
	textBuffer:removeChars(startChar,stopChar,y,register)
	return MacroDeleteMode
end

function MacroDeleteMode.deleteCurrentChar(textBuffer,cursor)
	return MacroDeleteMode:deleteOrYankCharacters(textBuffer,cursor,cursor.x)
end

return MacroDeleteMode
