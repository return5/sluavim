 --[[
 	clas which represents an abstraction of user inputs. class receives user inputs from anysource.
 	in this case we are taking keyboard input via ncurses.
 --]]
 local NcursesIO <Const> = require('ncurses.NcursesIO')

local Input <const> = {}
Input.__index = Input

_ENV = Input

 function Input.getCh()
   --TODO
 end

return Input
