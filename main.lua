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
local Cursor <const> = require('window.Cursor')
local TextBuffer <const> = require('TextBuffer.TextBuffer')
local Window <const> = require('window.Window')
local SetModeFields <const> = require('modes.SetModeFields')
local Input <const> = require('localIO.Input')

local function repl(currentMode)
	local cursor <const> = Cursor:new(1,1)
	local window <const> = Window:new(1,1)
	local textBuffer <const> = TextBuffer:new()
	for i=1,#Input.chars,1 do
		currentMode = currentMode:takeInput(textBuffer,cursor)
		window:setY(cursor)
	end
	textBuffer:print(window)
	io.write("cursor: ",cursor.x,":",cursor.y,"\n")
end

local function main()
	CmdArgs.readArgs(arg)
	ChangeOptions.options()
	SetModeFields.setModes()
	local initMode <const> = ChangeOptions.getInitMode()
	repl(initMode)
end

main()
