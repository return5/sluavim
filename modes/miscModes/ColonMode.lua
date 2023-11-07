local BaseMode <const> = require('modes.BaseMode')
local KeyMap <const> = require('localIO.KeyMapper')
local NormalMode <const> = require('modes.NormalMode')
local WriteFile <const> = require('files.WriteFile')
local Globals <const> = require('auxiliary.Globals')
local Output <const> = require('localIO.Output')
local match <const> = string.match
local gmatch <const> = string.gmatch
local exit <const> = os.exit
local concat <const> = table.concat

local ColonMode <const> = {type = "ColonMode",strTbl = {}}
ColonMode.__index = ColonMode

setmetatable(ColonMode,BaseMode)

_ENV = ColonMode

local function writeFile(fileName,textBuffer)
	local fileNameToWrite <const> = fileName and fileName or Globals.fileName
	Globals.fileName = fileNameToWrite
	if not fileNameToWrite then return end
	WriteFile.writeFile(fileNameToWrite,textBuffer)
end

local function quitProgram()
	Output.exit()
	exit(true)
end

local function processString(str,textBuffer)
	local optionStr <const> = match(str,":([^%s]+)%s*")
	local options <const> = {}
	for option in gmatch(optionStr,".") do
		options[option] = true
	end
	if options['w'] then writeFile(match(str,"[^%s]+%s+(.*)"),textBuffer) end
	if options['q'] then quitProgram() end
end

function ColonMode.processStrTbl(textBuffer)
	local str <const> = concat(ColonMode.strTbl)
	processString(str,textBuffer)
	ColonMode.strTbl = {}
	return ColonMode.removeWindow()
end

function ColonMode.printWindow()
	Output.clearWindow(ColonMode.window)
	for i=1,#ColonMode.strTbl,1 do
		Output.printCharAt(ColonMode.strTbl[i],i,ColonMode.window,1)
	end
	Output.refreshWindow(ColonMode.window)
	return ColonMode
end

function ColonMode.removeWindow()
	Output.clearWindow(ColonMode.window)
	Output.refreshWindow(ColonMode.window)
	Output.deleteWindow(ColonMode.window)
	return NormalMode
end

function ColonMode:parseInput(ch,textBuffer)
	if ch == KeyMap.ESC then return ColonMode.removeWindow() end
	if ch == KeyMap.ENTER then return ColonMode.processStrTbl(textBuffer) end
	ColonMode.strTbl[#ColonMode.strTbl + 1] = ch
	ColonMode.printWindow()
	return ColonMode
end

function ColonMode.startColonMode()
	local windowHeight <const> = Output.getWindowHeight()
	local windowWidth <const> = Output.getWindowWidth()
	ColonMode.window = Output.getNewWindow(5,windowHeight - 1,2,windowWidth - 5)
	ColonMode.strTbl[#ColonMode.strTbl + 1] = ":"
	ColonMode.printWindow()
	return ColonMode
end

return ColonMode
