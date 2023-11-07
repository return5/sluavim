local NcurseBoolMapper <const> = require('ncurses.NcurseBoolMapper')

local NcursesAux   <const> = {type = "NcursesAux"}
NcursesAux.__index = NcursesAux

local initscr   <const> = initscr
local cbreak    <const> = cbreak
local refresh   <const> = refresh
local endwin    <const> = endwin
local noecho    <const> = noecho
local curs_set  <const> = curs_set
local newwin <const> = newwin
local wborder <const> = wborder
local delwin <const> = delwin

_ENV = NcursesAux

function NcursesAux.initNcurses()
    initscr()
    cbreak()  --disable line buffering
    noecho() --dont show user input on screen
    refresh()
end

function NcursesAux.showCursor(val)
    curs_set(NcurseBoolMapper[val])
end

function NcursesAux.endNcurses()
    endwin()
end

function NcursesAux.deleteWindow(window)
    delwin(window)
    return NcursesAux
end

function NcursesAux.createWindow(height,width,y,x)
    return newwin(height,width,y,x)
end

function NcursesAux.createBorder(window,left,right,top,bottom,topLeft,topRight,bottomLeft,bottomRight)
    wborder(window,left,right,top,bottom,topLeft,topRight,bottomLeft,bottomRight)
    return NcursesAux
end

return NcursesAux

