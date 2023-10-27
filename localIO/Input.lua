 --[[
 	clas which represents an abstraction of user inputs. class receives user inputs from anysource.
 	in this case we are taking keyboard input via ncurses.
 --]]
 local NcursesIO <const> = require('ncurses.NcursesIO')
 local KeyMapings <const> = require('ncurses.NcursesKeyMap')

local Input <const> = {type = "input"}
Input.__index = Input

_ENV = Input

 local i = 1
 Input.chars = {'a','h','e','l','l','o','W','O','R','L','D',KeyMapings.ENTER,'j','u','m','p',KeyMapings.ESC,'F','m','d','t','p','i','t'}--'d','f','p','a','l'}

 function Input.getCh()
   i = i + 1
  return Input.chars[i - 1]
 end

return Input
