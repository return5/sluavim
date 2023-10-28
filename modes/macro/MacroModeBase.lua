local BaseMode <const> = require('modes.BaseMode')
local NormalMode <const> = require('modes.NormalMode')
local KeyMap <const> = require('ncurses.NcursesKeyMap')

local MacroModeBase <const> = {type = "MacroModeBase"}
MacroModeBase.__index = MacroModeBase

setmetatable(MacroModeBase,BaseMode)

_ENV = MacroModeBase

function MacroModeBase:doAction()
	return NormalMode
end

function MacroModeBase:returnAfterEsc()
	return NormalMode
end

function MacroModeBase:takeInput(textBuffer,cursor)
	local ch <const> = self.grabInput()
	if ch == KeyMap.ESC then return self:returnAfterEsc() end
	return self:doAction(textBuffer,ch,cursor)
end

return MacroModeBase
