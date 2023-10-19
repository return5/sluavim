 --[[
 	clas which represents an abstraction of user inputs. class receives user inputs from anysource.
 	in this case we are taking keyboard input via ncurses.
 --]]
 local NcursesIO <const> = require('ncurses.NcursesIO')
 local KeyMapings <const> = require('ncurses.NcursesKeyMap')
local Input <const> = {}
Input.__index = Input

_ENV = Input

 local i = 1
 Input.chars = {'i','h','e','l','l','o',KeyMapings.ENTER,'w',KeyMapings.ESC,'o','i','r','l','d',KeyMapings.ENTER}

 function Input.getCh()
   i = i + 1
  return chars[i - 1]
 end

return Input
