--[[
	configuration file for text editor.
--]]

return {
	showLineNumber = true,
	showCursor = true,
	enableColor = true,
	easyMode = false,
	--color pairs = foreground color, background color
	colorPairs = {
		COLOR_BLACK = {"COLOR_BLACK","COLOR_BLACK"},
		COLOR_RED = {"COLOR_RED","COLOR_BLACK"},
		COLOR_GREEN = {"COLOR_GREEN","COLOR_BLACK"},
		COLOR_YELLOW = {"COLOR_YELLOW","COLOR_BLACK"},
		COLOR_BLUE = {"COLOR_BLUE","COLOR_BLACK"},
		COLOR_MAGENTA = {"COLOR_MAGENTA","COLOR_BLACK"},
		COLOR_CYAN = {"COLOR_CYAN","COLOR_BLACK"},
		COLOR_WHITE = {"COLOR_WHITE","COLOR_BLACK"}
	},
	--change the r,g,b value of a color. range for each color: 0-1000
	colorValues = {}
}
