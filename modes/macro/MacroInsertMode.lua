local MacroInsertAndNormalModeParent <const> = require('modes.macro.MacroInsertAndNormalModeParent')
local InsertMode <const> = require('modes.InsertMode')
local pairs <const> = pairs
local KeyMap <const> = require('ncurses.NcursesKeyMap')
local io  = io

local MacroInsertMode <const> = {type = "MacroInsertMode", macroNormalMode = "please remember to set this value before using this class."}
MacroInsertMode.__index = MacroInsertMode

setmetatable(MacroInsertMode,MacroInsertAndNormalModeParent)

_ENV = MacroInsertMode

function MacroInsertMode.default(textBuffer,ch,cursor)
	MacroInsertMode.insertCharIntoMacro(ch)
	InsertMode.default(textBuffer,ch,cursor)
	return MacroInsertMode
end

function MacroInsertMode.escape(_,_,cursor)
	InsertMode.escape(nil,nil,cursor)
	io.write("inside of MAcroInsertMode returning type: ",MacroInsertMode.macroNormalMode.type,"\n")
	return MacroInsertMode.macroNormalMode
end

function MacroInsertMode.setMacroNormalMode(macroNormalMode)
	MacroInsertMode.macroNormalMode = macroNormalMode
	return MacroInsertMode
end

--make defensive copy
MacroInsertMode.keyBindings = {}
for k,v in pairs(InsertMode.keyBindings) do
	MacroInsertMode.keyBindings[k] = MacroInsertMode.wrapInsertOrNormalModeFunction(v,MacroInsertMode)
end

MacroInsertMode.keyBindings[KeyMap.ESC] = MacroInsertMode.escape

return MacroInsertMode
