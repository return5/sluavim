 --[[
 	clas which represents an abstraction of user inputs. class should be able to receive user inputs from any source.
 	functions as a wrapper class to abstract away user inputs from the rest of the program.
 	in this case the class is taking keyboard input via ncurses.
 --]]

 local NcursesIO <const> = require('ncurses.NcursesIO')
 local KeyMap <const> = require('localIO.KeyMapper')

local Input <const> = {type = "Input"}
Input.__index = Input

_ENV = Input

 Input.i = 1
Input.chars = {'i','g','O','z','z','D','.',KeyMap.ENTER,'h','l','e','l','i','l','o','.','W','o','R','l','f','l','D',KeyMap.ESC,'q','a','F','l','q','@','a','@','a','x'}



 function Input.getCh()
   Input.i = Input.i + 1
  return Input.chars[Input.i - 1]
 end

return Input