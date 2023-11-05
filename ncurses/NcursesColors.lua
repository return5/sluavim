local ncurse   <const> = require("luatoncurses.sluacurses")


local COLOR_BLACK <const> = COLOR_BLACK
local COLOR_RED <const> = COLOR_RED
local COLOR_GREEN <const> = COLOR_GREEN
local COLOR_YELLOW <const> = COLOR_YELLOW
local COLOR_BLUE <const> = COLOR_BLUE
local COLOR_MAGENTA <const> = COLOR_MAGENTA
local COLOR_CYAN <const> = COLOR_CYAN
local COLOR_WHITE <const> = COLOR_WHITE
local start_color <const> = start_color
local init_pair <const> = init_pair
local init_color <const> = init_color

local NcursesColors <const> = {type = "NcursesColors"}
NcursesColors.__index = NcursesColors

_ENV = NcursesColors

NcursesColors.colors = {
	COLOR_BLACK = COLOR_BLACK,
	COLOR_RED = COLOR_RED,
	COLOR_GREEN = COLOR_GREEN,
	COLOR_YELLOW = COLOR_YELLOW,
	COLOR_BLUE = COLOR_BLUE,
	COLOR_MAGENTA = COLOR_MAGENTA,
	COLOR_CYAN = COLOR_CYAN,
	COLOR_WHITE = COLOR_WHITE
}

NcursesColors.colorPairs = {
	COLOR_BLACK = COLOR_BLACK,
	COLOR_RED = COLOR_RED,
	COLOR_GREEN = COLOR_GREEN,
	COLOR_YELLOW = COLOR_YELLOW,
	COLOR_BLUE = COLOR_BLUE,
	COLOR_MAGENTA = COLOR_MAGENTA,
	COLOR_CYAN = COLOR_CYAN,
	COLOR_WHITE = COLOR_WHITE
}

function NcursesColors.startColor()
	start_color()
end

function NcursesColors.setColorPair(name,number,foreground,background)
	NcursesColors.colorPairs[name] = number
	NcursesColors.initPair(number, foreground,background)
end

function NcursesColors.initPair(pair,foreground,background)
	init_pair(NcursesColors.colors[NcursesColors.colorPairs[pair]],NcursesColors.colors[foreground],NcursesColors.colors[background])
	return pair
end

function NcursesColors.initColor(color,red,green,blue)
	init_color(color,red,green,blue)
end

return NcursesColors
