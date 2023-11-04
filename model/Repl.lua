local Window <const> = require('window.Window')
local BaseMode <const> = require('modes.BaseMode')
local Output <const> = require('localIO.Output')
local Input <const> = require('localIO.Input')
local io = io

local Repl <const> = {ype = "Repl"}
Repl.__index = Repl

_ENV = Repl

local function printRegister(r)
	local reg <const> = BaseMode.getRegister(r)
	Output.printCharAt("printing register\n")
	if reg then
		for i=1,#reg,1 do
			Output.printCharAt(reg[i])
		end
		Output.printCharAt("\n")
	end
end

function Repl.repl(currentMode,textBuffer,cursor)
	local window <const> = Window:new(1,1)
	while Input.i < #Input.chars + 1 do
		local ch <const> = Input.getCh()
		currentMode = currentMode:parseInput(ch,textBuffer,cursor)
		window:setY(cursor)
	end
	textBuffer:print(window)
	--io.write("\ncursor.x is: ",cursor.x ," cursor y is: ",cursor.y,"\n")
	--printRegister('a')
	return Repl
end


return Repl
