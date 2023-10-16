local ncurse   <const> = require("luatoncurses.sluacurses")


local NcursesIo   <const> = {}
NcursesIo.__index = NcursesIo

local getch    <const> = getch
local getstr   <const> = getstr
local mvprintw <const> = mvprintw
local getCols <const> = getCols
local getLines <const> = getLines
local refresh  <const> = refresh
local clear    <const> = clear
local move     <const> = move 


_ENV = NcursesIo

function NcursesIo.getCols()
    return getCols()
end

function NcursesIo.getLines()
    return getLines()
end

function NcursesIo.getCh()
    return getch()    
end

function NcursesIo.getStr()
    return getstr()
end

function NcursesIo.printLineNoRefresh(y,line)
    mvprintw(y,0,line)
end

function NcursesIo.printLine(y,line)
    mvprintw(y,0,line)
    refresh()
end

function NcursesIo.refresh()
    refresh()
    getch()
end

function NcursesIo.clearScreen()
    clear()
end

function NcursesIo.moveCurs(y,x)
    move(y,x)
end

return NcursesIo

