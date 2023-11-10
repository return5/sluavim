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
local tonumber <const> = tonumber

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

local function getSearchOptions(str)
	return match(str,":([^s]*)s")
end

local function getStartStopLocation(options,textBuffer,cursor)
	if not options or options == "" then return cursor:getY(),cursor:getY() end
	if options == "%" then return 1,textBuffer:getSize() end
	local startLineMatch <const>, stopLineMatch <const> = match(options,"([0-9]*)%s*,%s*([0-9]*)")
	local startLine <const> = (startLineMatch == nil or startLineMatch == "") and cursor:getY() or startLineMatch
	local stopLine <const> = (stopLineMatch == nil or stopLineMatch == "") and cursor:getY() or stopLineMatch
	return startLine,stopLine
end

local function getSearchAndReplaceStrings(str)
	return match(str,"s/(.+)/(.-)/")
end

local function getReplaceOptions(str)
	return match(str,".+/(.-)$")
end

local function searchAndReplace(str,textBuffer,cursor)
	local searchOptions <const> = getSearchOptions(str)
	local start <const>, stop <const> = getStartStopLocation(searchOptions,textBuffer,cursor)
	local searchString <const>, replaceString <const> = getSearchAndReplaceStrings(str)
	local replaceOptions <const> = getReplaceOptions(str)
	textBuffer:searchAndReplace(tonumber(start),tonumber(stop),searchString,replaceString,replaceOptions)
end

local function saveAnOrQuitProgram(str,textBuffer)
	local optionStr <const> = match(str,":([^%s]+)%s*")
	local options <const> = {}
	for option in gmatch(optionStr,".") do
		options[option] = true
	end
	if options['w'] then writeFile(match(str,"[^%s]+%s+(.*)"),textBuffer) end
	if options['q'] then quitProgram() end
end

local function processString(str,textBuffer,cursor)
	if match(str,":[qw]+") then
		saveAnOrQuitProgram(str,textBuffer)
	elseif match(str,":[%%0-9,%s]*s") then
		searchAndReplace(str,textBuffer,cursor)
	end
end

function ColonMode.processStrTbl(textBuffer,cursor)
	local str <const> = concat(ColonMode.strTbl)
	processString(str,textBuffer,cursor)
	ColonMode.strTbl = {}
	return ColonMode.removeWindow()
end

function ColonMode.printWindow()
	for i=1,#ColonMode.strTbl,1 do
		Output.printCharAt(ColonMode.strTbl[i],i,ColonMode.window,1)
	end
	return ColonMode
end

function ColonMode.removeWindow()
	Output.clearWindow(ColonMode.window)
	Output.refreshWindow(ColonMode.window)
	Output.deleteWindow(ColonMode.window)
	return NormalMode
end

function ColonMode:parseInput(ch,textBuffer,cursor)
	if ch == KeyMap.ESC then return ColonMode.removeWindow() end
	if ch == KeyMap.ENTER then return ColonMode.processStrTbl(textBuffer,cursor) end
	if ch == KeyMap.BACK then return ColonMode.handleBackSpace() end
	ColonMode.strTbl[#ColonMode.strTbl + 1] = ch
	ColonMode.printWindow()
	return ColonMode
end

function ColonMode.handleBackSpace()
	if #ColonMode.strTbl > 1 then
		ColonMode.strTbl[#ColonMode.strTbl] = nil
		return ColonMode.printWindow()
	end
	if #ColonMode.strTbl == 1 then
		return ColonMode.removeWindow()
	end
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
