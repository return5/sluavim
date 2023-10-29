--[[
	class for yank mode. handles copying text from a textBuffer when using 'y' commands in NormalMode and VisualSelect mode
--]]

local MacroDeleteAndYankParent <const> = require('modes.macro.MacroDeleteAndYankParent')

local MacroYankMode <const> = {type = "MacroYankMode"}
MacroYankMode.__index = MacroYankMode

setmetatable(MacroYankMode,MacroDeleteAndYankParent)

_ENV = MacroYankMode

function MacroYankMode.action(textBuffer,startChar,stopChar,y,register)
	textBuffer:copyChars(startChar,stopChar,y,register)
	return MacroYankMode
end

return MacroYankMode
