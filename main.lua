--[[
Copyright (c) <2023> <github.com/return5>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
--]]

local CmdArgs <const> = require('auxiliary.CmdArgs')
local ChangeOptions <const> = require('auxiliary.ChangeProgramOptions')
local TextBuffer <const> = require('TextBuffer.TextBuffer')
local SetModeFields <const> = require('auxiliary.SetModeFields')
local Repl <const> = require('model.Repl')
local NcursesAux <const> = require('ncurses.NcursesAux')

local function main()
	local textBuffer <const> = TextBuffer:new()
	CmdArgs.readArgs(arg,textBuffer)
	NcursesAux.initNcurses()
	local numbersWindow <const> = ChangeOptions.options()
	local mainWindow <const> = NcursesAux.createMainWindow(numbersWindow)
	SetModeFields.setModes()
	local initMode <const> = ChangeOptions.getInitMode()
	if numbersWindow then
		Repl.replWithNumbers(initMode,textBuffer,mainWindow,numbersWindow)
	else
		Repl.repl(initMode,textBuffer,mainWindow)
	end
	NcursesAux.endNcurses()
end

main()
