--[[
	class which represents the ability to write text to some output, typically a screen or terminal.
	in our case we are writing to terminal using ncurses library
--]]

local NcursesIO <const> = require('ncurses.NcursesIO')

local write <const> = io.write
local Output <const> = {type = "output"}
Output.__index = Output

_ENV = Output

function Output.newLine()
	write("\n")
end

function Output.printCharAt(char)
	write(char)
	return self
end

return Output
