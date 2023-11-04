local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('localIO.KeyMapper')
local NormalMode <const> = require('modes.NormalMode')
local WriteFile <const> = require('files.WriteFile')
local Globals <const> = require('auxiliary.Globals')
local match <const> = string.match
local gmatch <const> = string.gmatch
local exit <const> = os.exit
local concat <const> = table.concat

local ColonMode <const> = {type = "ColonMode",strTbl = {}}
ColonMode.__index = ColonMode

setmetatable(ColonMode,BaseMode)

_ENV = ColonMode

local function writeFile(fileName,textBuffer)
	if fileName and not Globals.fileName then Globals.fileName = fileName end
	local fileNameToWrite <const> = fileName and fileName or Globals.fileName
	if not fileNameToWrite then return end
	WriteFile.writeFile(fileName,textBuffer)
end

local function quitProgram()
	exit(true,true)
end

local function processString(str,textBuffer)
	local optionStr <const>, fileName <const> = match(str,"([^%s]+)%s*(.*)")
	local options <const> = {}
	for option in gmatch(optionStr,".") do
		options[option] = true
	end
	if options['w'] then writeFile(fileName,textBuffer) end
	if options['q'] then quitProgram() end
end

function ColonMode:processStrTbl(textBuffer)
	local str <const> = concat(self.strTbl)
	processString(str,textBuffer)
	self.strTbl = {}
	return NormalMode
end

function ColonMode:parseInput(ch,textBuffer)
	if ch == KeyMap.ESC then return NormalMode end
	if ch == KeyMap.ENTER then return self:processStrTbl(textBuffer) end
	self.strTbl[#self.strTbl + 1] = ch
	return ColonMode
end

return ColonMode
