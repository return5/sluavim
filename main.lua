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
local SetModeFields <const> = require('modes.SetModeFields')
local Repl <const> = require('model.Repl')

local function main()
	local textBuffer <const> = TextBuffer:new()
	CmdArgs.readArgs(arg,textBuffer)
	ChangeOptions.options()
	SetModeFields.setModes()
	local initMode <const> = ChangeOptions.getInitMode()
	Repl.repl(initMode,textBuffer)
end

main()
