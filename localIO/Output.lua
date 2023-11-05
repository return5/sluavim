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

function Output.printCharAt(char,i,ncursesWindow,j)
	NcursesIO.printCh(j,i,char,ncursesWindow)
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

function Output.setScreenCursor(cursor,window)
	NcursesIO.setScreenCursor(cursor,window)
	return Output
end

return Output
