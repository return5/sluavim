local InsertMode <const> = require('modes.InsertMode')
local BaseMode <const> = require('modes.BaseMode')

local PasteRegisterMode <const> = {type = "PasteRegisterMode"}
PasteRegisterMode.__index = PasteRegisterMode
setmetatable(PasteRegisterMode,BaseMode)

_ENV = PasteRegisterMode

function PasteRegisterMode:pasteRegister(textBuffer,cursor)
	local register <const> = self.getCurrentRegister()
	if register and #register > 0 then
		cursor:moveRight()
		for i=1,#register,1 do
			InsertMode.insertChar(textBuffer,register[i],cursor)
		end
	end
	return PasteRegisterMode
end

return PasteRegisterMode
