--[[
	class for yank mode. handles copying text from a textBuffer when using 'y' commands in NormalMode and VisualSelect mode
--]]

local DeleteAndYankParent <const> = require('modes.deleteAndYank.DeleteAndYankParent')

local YankMode <const> = {type = "YankMode"}
YankMode.__index = YankMode

setmetatable(YankMode,DeleteAndYankParent)

_ENV = YankMode

function YankMode.action(textBuffer,startChar,stopChar,y,register)
	textBuffer:copyChars(startChar,stopChar,y,register)
	return YankMode
end

return YankMode
