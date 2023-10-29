local BaseMode <const> = require('modes.BaseMode')

local MacroInsertAndNormalModeParent <const> = {type = "MacroInsertAndNormalModePArent"}
MacroInsertAndNormalModeParent.__index = MacroInsertAndNormalModeParent

setmetatable(MacroInsertAndNormalModeParent,BaseMode)

_ENV = MacroInsertAndNormalModeParent

function MacroInsertAndNormalModeParent.insertCharIntoMacro(char)
	MacroInsertAndNormalModeParent.insertIntoCurrentRegister(char)
end

function MacroInsertAndNormalModeParent.default()
	return MacroInsertAndNormalModeParent
end

function MacroInsertAndNormalModeParent:takeInput(textBuffer,cursor)
	local ch <const> = self.grabInput()
	if self.keyBindings[ch] then
		return self.keyBindings[ch](textBuffer,ch,cursor)
	end
	return self.default(textBuffer,ch,cursor)
end

function MacroInsertAndNormalModeParent.wrapInsertOrNormalModeFunction(modeFunction,returnMode)
	return function(textBuffer,ch,cursor)
		MacroInsertAndNormalModeParent.insertCharIntoMacro(ch)
		modeFunction(textBuffer,ch,cursor)
		return returnMode
	end
end

return MacroInsertAndNormalModeParent

