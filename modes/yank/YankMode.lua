--[[
	class for yank mode. handles copying text from a textBuffer when using 'y' commands in NormalMode and VisualSelect mode
--]]

local DeleteAndYankParent <const> = require('modes.DeleteAndYankParent')

local YankMode <const> = {}
YankMode.__index = YankMode

setmetatable(YankMode,DeleteAndYankParent)

_ENV = YankMode

function YankMode.action(textBuffer,startChar,stopChar,y,register)
	textBuffer:copyChars(startChar,stopChar,y,register)
	return YankMode
end

return YankMode
