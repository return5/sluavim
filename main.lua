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
local InsertMode <const> = require('modes.InsertMode')
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
end

local function main()
	CmdArgs.readArgs(arg)
	ChangeOptions.options()
	InsertMode.setNormal()
	local initMode <const> = ChangeOptions.getInitMode()
	repl(initMode)
	--local textBuffer <const> = TextBuffer:new()
	--textBuffer:insert(1,'h',1):insert(1,'e',2):insert(1,'l',3):insert(1,'l',4):insert(1,'o',5):insert(1,':\n',6)
	--textBuffer:addLineAt(2)
	--textBuffer:insert(1,'w',1):insert(1,'o',2):insert(1,'r',3):insert(1,'l',4):insert(1,'d',5):insert(1,'\n',6)
	--local window <const> = Window:new(1,1)
	--textBuffer:print(window)
--	repl(initMode)
end

main()
