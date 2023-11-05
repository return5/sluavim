local NcurseBoolMapper <const> = require('ncurses.NcurseBoolMapper')

local NcursesAux   <const> = {type = "NcursesAux"}
NcursesAux.__index = NcursesAux

local initscr   <const> = initscr
local cbreak    <const> = cbreak
local refresh   <const> = refresh
local endwin    <const> = endwin
local noecho    <const> = noecho
local getCols <const> = getCols
local getLines <const> = getLines
local curs_set  <const> = curs_set
local newwin <const> = newwin
local wborder <const> = wborder
local wrefresh <const> = wrefresh

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

function NcursesAux.createWindow(height,width,y,x)
    return newwin(height,width,y,x)
end

function NcursesAux.createNumbersWindow()
    local height <const> = getLines()
    local window <const> = NcursesAux.createWindow(height,3,0,0)
    local borderWindow <const> = NcursesAux.createWindow(height,5,0,0)
    wborder(borderWindow,"","|","","","","|","","")
    wrefresh(borderWindow)
    return window
end

function NcursesAux.createMainWindow(numberWindow)
    local startX <const> = numberWindow and 5 or 0
    local width <const> = getCols() - startX
    local height <const> = getLines()
    return NcursesAux.createWindow(height,width,0,startX)
end

return NcursesAux

