 --[[
 	clas which represents an abstraction of user inputs. class should be able to receive user inputs from any source.
 	functions as a wrapper class to abstract away user inputs from the rest of the program.
 	in this case the class is taking keyboard input via ncurses.
 --]]

 local NcursesIO <const> = require('ncurses.NcursesIO')

local Input <const> = {type = "Input"}
Input.__index = Input

_ENV = Input


 function Input.getCh()
     return NcursesIO.getCh()
 end

return Input