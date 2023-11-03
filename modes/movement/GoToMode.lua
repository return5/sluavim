local MovementMode <const> = require('modes.movement.MovementMode')
local GotToTopOfFile <const> = require('modes.movement.GoToTopOfFile')
local io = io

local GoToMode <const> = {type = 'GoToMode'}
GoToMode.__index = GoToMode
setmetatable(GoToMode,MovementMode)

_ENV = GoToMode

function GoToMode:returnGoToTopOfFile(_,_,cursor)
	return GotToTopOfFile:goToTopOfFile(cursor)
end

function GoToMode:parseInput(ch,textBuffer,cursor)
	io.write("ch is: ",ch,"\n")
	if self.keyBindings[ch] then
		io.write("it matched\n")
		return self.keyBindings[ch](self,textBuffer,ch,cursor)
	end
	return self.returnNormalMode()
end

function GoToMode:takeInput(textBuffer,cursor)
	local ch <const> = self.grabInput()
	return self:parseInput(ch,textBuffer,cursor)
end

GoToMode.keyBindings = {
	g = GoToMode.returnGoToTopOfFile
}

return GoToMode
