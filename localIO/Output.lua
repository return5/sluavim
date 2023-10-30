--[[
	class which represents the ability to write text to some output, typically a screen or terminal.
	works as a wrapper class which represents an abstraction to outputting text. decouples output from teh rest of the program.
	in this case the  writing to terminal is using ncurses library.
--]]

local NcursesIO <const> = require('ncurses.NcursesIO')

local write <const> = io.write
local Output <const> = {type = "output"}
Output.__index = Output

_ENV = Output

function Output.newLine()
--	write("\nnewline\n")
	return Output
end

function Output.printCharAt(char,i,j)
	--write('printing at: ',j,":",i,' ')
	write(char)
	return Output
end

return Output
