--[[
	class which represents the ability to write text to some output, typically a screen or terminal.
	in our case we are writing to terminal using ncurses library
--]]

local NcursesIO <const> = require('ncurses.NcursesIO')

local write <const> = io.write
local Output <const> = {}
Output.__index = Output

_ENV = Output

function Output.printCharAt(char,column,row)
	write(char)
	return self
end

local function

function Output.printTextBuffer(textBuffer,cursor)
	local cols <const> = NcursesIO.getCols()
	local lines <const> = NcursesIO.getLines()

end

return Output
