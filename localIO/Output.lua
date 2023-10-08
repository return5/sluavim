
local write <const> = io.write
local Output <const> = {}
Output.__index = Output

_ENV = Output

function Output.printCharAt(char,column,row)
	write(char)
	return self
end

return Output
