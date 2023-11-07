--[[
	class which represents the ability to write text to some output, typically a screen or terminal.
	works as a wrapper class which represents an abstraction to outputting text. decouples output from teh rest of the program.
	in this case the  writing to terminal is using ncurses library.
--]]

local NcursesIO <const> = require('ncurses.NcursesIO')
local NcursesAux <const> = require('ncurses.NcursesAux')

local Output <const> = {type = "output"}
Output.__index = Output

_ENV = Output

function Output.newLine()
	return Output
end

function Output.initScreen()
	NcursesAux.initNcurses()
	return Output
end

function Output.printCharAt(char,x,ncursesWindow,y)
	NcursesIO.printCh(y,x,char,ncursesWindow)
	return Output
end

function Output.getWindowHeight()
	return NcursesIO.getLines()
end

function Output.getWindowWidth()
	return NcursesIO.getCols()
end

function Output.printRightAlignChar(char,y,x,window)
	NcursesIO.printRightAlignChar(char,y,x,window)
end

function Output.exit()
	NcursesAux.endNcurses()
	return Output
end

function Output.clearWindow(window)
	NcursesIO.clearWindow(window)
	return Output
end

function Output.refreshWindow(window)
	NcursesIO.refreshWindow(window)
	return Output
end

function Output.refresh()
	NcursesIO.refresh()
	return Output
end

function Output.setScreenCursor(y,x,window)
	NcursesIO.setScreenCursor(y,x,window)
	return Output
end

function Output.getNewWindow(x,y,height,width)
	return NcursesAux.createWindow(height,width,y,x)
end

function Output.createMainWindow(numbersWindow)
	local startX <const> = numbersWindow and 5 or 0
	local width <const> = Output.getWindowWidth() - startX
	local height <const> = Output.getWindowHeight()
	return Output.getNewWindow(startX,0,height,width)
end

function Output.createNumbersWindow()
	local height <const> = Output.getWindowHeight()
	local window <const> = Output.getNewWindow(0,0,height,3)
	local borderWindow <const> = Output.getNewWindow(0,0,height,5)
	NcursesAux.createBorder(borderWindow,"","|","","","","|","","")
	Output.refreshWindow(borderWindow)
	return window
end

function Output.deleteWindow(window)
	NcursesAux.deleteWindow(window)
	return Output
end

return Output
