local Window <const> = require('window.Window')
local BaseMode <const> = require('modes.BaseMode')
local Output <const> = require('localIO.Output')
local Input <const> = require('localIO.Input')
local Cursor <const> = require('window.Cursor')

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

local function doNothing() end

local function printNumbersWindow(window,numbersWindow)
	Output.clearWindow(numbersWindow)
	for i=0,Output.getWindowHeight() - 1, 1 do
		Output.printRightAlignChar(window:getY() + i,i,0,numbersWindow)
	end
	Output.refreshWindow(numbersWindow)
end

local function replLoopBody(currentMode,window,cursor,textBuffer,ncursesWindow,numbersWindow,printNumbers)
	local ch <const> = Input.getCh()
	currentMode = currentMode:parseInput(ch,textBuffer,cursor)
	Output.clearWindow(ncursesWindow)
	window:setY(cursor)
	printNumbers(window,numbersWindow)
	textBuffer:print(window,ncursesWindow)
	Output.setScreenCursor(cursor,ncursesWindow)
	Output.refreshWindow(ncursesWindow)
	return currentMode
end

function Repl.loop(printNumbers,initMode,textBuffer,ncursesWindow,numbersWindow)
	local currentMode = initMode
	local cursor <const> = Cursor:new(1,1)
	local window <const> = Window:new(1,1)
	printNumbers(window,numbersWindow)
	Output.setScreenCursor(cursor,ncursesWindow)
	Output.refreshWindow(ncursesWindow)
	while true do
		currentMode = replLoopBody(currentMode,window,cursor,textBuffer,ncursesWindow,numbersWindow,printNumbers)
	end
	return Repl
end

function Repl.replWithNumbers(currentMode,textBuffer,ncursesWindow,numberWindow)
	Output.refreshWindow(numberWindow)
	return Repl.loop(printNumbersWindow,currentMode,textBuffer,ncursesWindow,numberWindow)
end

function Repl.repl(currentMode,textBuffer,ncursesWindow)
	return Repl.loop(doNothing,currentMode,textBuffer,ncursesWindow)
end


return Repl
