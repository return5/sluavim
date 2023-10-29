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
local BaseMode <const> = require('modes.BaseMode')
local Output <const> = require('localIO.Output')
local WriteFile <const> = require('files.WriteFile')
local ReadFile <const> = require('files.ReadFile')

local function printRegister(r)
	local reg <const> = BaseMode.getRegister(r)
	Output.printCharAt("printing register\n")
	for i=1,#reg,1 do
		Output.printCharAt(reg[i])
	end
	Output.printCharAt("\n")
end

local function repl(currentMode)
	local cursor <const> = Cursor:new(1,1)
	local window <const> = Window:new(1,1)
	local textBuffer <const> = TextBuffer:new()
	while Input.i < #Input.chars + 1 do
		currentMode = currentMode:takeInput(textBuffer,cursor)
		window:setY(cursor)
	end
	textBuffer:print(window)
	printRegister(1)
	printRegister(2)
	WriteFile.writeFile("myText.txt",textBuffer)
end

local function main()
	CmdArgs.readArgs(arg)
	ChangeOptions.options()
	SetModeFields.setModes()
	local initMode <const> = ChangeOptions.getInitMode()
	local textBuffer <const> = TextBuffer:new()
	ReadFile.readFile("myText.txt",textBuffer)
	local window <const> = Window:new(1,1)
	textBuffer:print(window)
	--repl(initMode)
end

main()
