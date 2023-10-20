local Input <const> = require('localIO.Input')

local BaseMode <const> = {type = 'basemode',keyBindings = {}}
BaseMode.__index = BaseMode

_ENV = BaseMode

function BaseMode.default()
	return BaseMode
end


function BaseMode:takeInput(textBuffer,cursor)
	local ch <const> = Input.getCh()
	if self.keyBindings[ch] then
		return self.keyBindings[ch](textBuffer,ch,cursor)
	end
	return self.default(textBuffer,ch,cursor)
end

return BaseMode
