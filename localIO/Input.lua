 --[[
 	clas which represents an abstraction of user inputs. class should be able to receive user inputs from any source.
 	functions as a wrapper class to abstract away user inputs from the rest of the program.
 	in this case the class is taking keyboard input via ncurses.
 --]]

 local NcursesIO <const> = require('ncurses.NcursesIO')
 local KeyMapings <const> = require('ncurses.NcursesKeyMap')
 local io = io

local Input <const> = {type = "input"}
Input.__index = Input

_ENV = Input

 Input.i = 1
 Input.chars = {'a','h','e','l','l','o','W','O','R','L','D',KeyMapings.ENTER,'j','u','r','k','j','u','m','p',KeyMapings.ESC,'q','a','F','u','y','$',KeyMapings.ESC,'q','@','a'}--'t',KeyMapings.ESC,'q','h','@','e'}

 function Input.getCh()
  io.write("returning: ",Input.chars[Input.i],"\n")
   Input.i = Input.i + 1
  return Input.chars[Input.i - 1]
 end

return Input