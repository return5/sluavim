local Window <const> = require('window.Window')
local NormalMode <const> = require('modes.NormalMode')
local Output <const> = require('localIO.Output')
local Input <const> = require('localIO.Input')
local Cursor <const> = require('window.Cursor')

local Repl <const> = {ype = "Repl"}
Repl.__index = Repl

_ENV = Repl

local function doNothing() end

local function printNumbersWindow(window,numbersWindow)
	for i=0,Output.getWindowHeight() - 1, 1 do
		Output.printRightAlignChar(window:getY() + i,i,0,numbersWindow)
	end
end

local function printAndRefreshWindows(textBuffer,ncursesWindow,numbersWindow,printNumbers,window,cursor)
	Output.clearWindow(ncursesWindow)
	printNumbers(window,numbersWindow)
	textBuffer:print(window,ncursesWindow)
	Output.setScreenCursor(window:getCursorYRelativeToWindow(cursor),cursor:getX(),ncursesWindow)
	Output.refreshWindowsInOrder()
end

local function replLoopBody(currentMode,window,cursor,textBuffer,ncursesWindow,numbersWindow,printNumbers,prevMode)
	local ch <const> = Input.getCh()
	currentMode,prevMode = currentMode:parseInput(ch,textBuffer,cursor,prevMode)
	window:setY(cursor)
	printAndRefreshWindows(textBuffer,ncursesWindow,numbersWindow,printNumbers,window,cursor)
	return currentMode,prevMode
end

function Repl.loop(printNumbers,textBuffer,ncursesWindow,numbersWindow)
	local currentMode = NormalMode
	local prevMode = nil
	local cursor <const> = Cursor:new(1,1)
	local window <const> = Window:new(1,1)
	printAndRefreshWindows(textBuffer,ncursesWindow,numbersWindow,printNumbers,window,cursor)
	while true do
		currentMode,prevMode = replLoopBody(currentMode,window,cursor,textBuffer,ncursesWindow,numbersWindow,printNumbers,prevMode)
	end
	return Repl
end

function Repl.replWithNumbers(textBuffer,ncursesWindow,numberWindow)
	return Repl.loop(printNumbersWindow,textBuffer,ncursesWindow,numberWindow)
end

function Repl.repl(textBuffer,ncursesWindow)
	return Repl.loop(doNothing,textBuffer,ncursesWindow)
end


return Repl
