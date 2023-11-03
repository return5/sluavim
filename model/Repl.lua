local Window <const> = require('window.Window')
local Cursor <const> = require('window.Cursor')
local BaseMode <const> = require('modes.BaseMode')
local Output <const> = require('localIO.Output')
local Input <const> = require('localIO.Input')
local WriteFile <const> = require('files.WriteFile')
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

function Repl.repl(currentMode,textBuffer)
	local cursor <const> = Cursor:new(1,1)
	local window <const> = Window:new(1,1)
	while Input.i < #Input.chars + 1 do
		io.write("currentMode: ",currentMode.type,"\n")
		currentMode = currentMode:takeInput(textBuffer,cursor)
		window:setY(cursor)
	end
	textBuffer:print(window)
	WriteFile.writeFile('myText.txt',textBuffer)
	io.write("\ncursor.x is: ",cursor.x ," cursor y is: ",cursor.y,"\n")
	--printRegister(1)
end

return Repl
