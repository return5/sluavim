local ncurse   <const> = require("luatoncurses.sluacurses")


local NcursesIo   <const> = {type = "NcursesIo"}
NcursesIo.__index = NcursesIo

local getch    <const> = getch
local getstr   <const> = getstr
local mvprintw <const> = mvprintw
local getCols <const> = getCols
local getLines <const> = getLines
local refresh  <const> = refresh
local clear    <const> = clear
local wmove     <const> = wmove
local mvwprintw <const> = mvwprintw
local mvwaddch <const> = mvwaddch
local wrefresh <const> = wrefresh
local wclear <const> = wclear
local toByte <const> = string.byte

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
    return NcursesIo
end

function NcursesIo.printLine(y,line)
    mvprintw(y,0,line)
    refresh()
end

function NcursesIo.printCh(y,x,ch,ncursesWindow)
    mvwaddch(ncursesWindow,y - 1,x - 1,toByte(ch))
    return NcursesIo
end

function NcursesIo.refreshWindow(window)
    wrefresh(window)
    return NcursesIo
end

function NcursesIo.clearWindow(window)
    wclear(window)
    return NcursesIo
end

function NcursesIo.clearScreen()
    clear()
    return NcursesIo
end

function NcursesIo.windowMoveCurs(y,x,window)
    wmove(window,y - 1,x - 1)
    return NcursesIo
end

function NcursesIo.printRightAlignChar(char,y,x,window)
    mvwprintw(window,y,x,"%d",char)
    return NcursesIo
end

function NcursesIo.setScreenCursor(y,x,window)
    return NcursesIo.windowMoveCurs(y,x,window)
end

function NcursesIo.refresh()
    refresh()
    return NcursesIo
end

return NcursesIo

