--[[
	wrapper class which serves as an abstraction away from ncurses key mappings.
	maps keyboard keys to the values those keys produce in ncurses.
	serves as a interface between the program and ncurses stuff in an attempt to help de-couple program from ncurses.
--]]

local NcurseKeyMapper <const> = require('ncurses.NcursesKeyMap')

local KeyMapper <const> = {}

for key,value in pairs(NcurseKeyMapper) do
	KeyMapper[key] = value
end

return KeyMapper
