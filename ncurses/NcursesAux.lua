local ncurse   <const> = require("luatoncurses.sluacurses")
local NcursesColors <const> = require('ncurses.NcursesColors')
local NcurseBoolMapper <const> = require('ncurses.NcurseBoolMapper')

local NcursesAux   <const> = {}
NcursesAux.__index = NcursesAux

local initscr   <const> = initscr
local cbreak    <const> = cbreak
local keypad    <const> = keypad
local mousemask <const> = mousemask
local refresh   <const> = refresh
local stdscr    <const> = stdscr
local endwin    <const> = endwin
local noecho    <const> = noecho
local curs_set  <const> = curs_set
local ALL_MOUSE_EVENTS <const> = ALL_MOUSE_EVENTS

_ENV = NcursesAux

function NcursesAux.initNcurses()
    initscr()
    cbreak()  --disable line buffering
    noecho() --dont show user input on screen
    keypad(stdscr,NcurseBoolMapper[true]) --enable keypad. needed for mouse
    mousemask(ALL_MOUSE_EVENTS) --enable mouse input
    refresh()
end

function NcursesAux.showCursor(val)
    curs_set(NcurseBoolMapper[val])
end

function NcursesAux.endNcurses()
    endwin()
end

return NcursesAux

