--[[
	class which handles reading the command line arguments.
--]]

local config <const> = require('config.config')
local ReadFile <const> = require('files.ReadFile')
local Globals <const> = require('auxiliary.Globals')

local match <const> = string.match
local gmatch <const> = string.gmatch
local concat <const> = table.concat
local exit <const> = os.exit
local write <const> = io.write
local format <const> = string.format


local CmdArgs <const> = {}
CmdArgs.__index = CmdArgs

_ENV = CmdArgs

local function changeBooleanValue(field,value)
	config[field] = value
end

local function showLineNumbers()
	changeBooleanValue('showLineNumbers',true)
end

local function easyMode()
	changeBooleanValue('easyMode',true)
end

local function enableColor()
	changeBooleanValue('enableColor',true)
end

local function showCursor()
	changeBooleanValue('showCursor',true)
end

local function printOption(option,arg,description)
	local str <const> = format("\t%s %s\t%-10s\n",option,arg,description)
	write(str)
end

local function printHelp()
	write("sluavim.lua [options] [[-f] [filename]]\n")
	printOption("-h","","print help message.")
	printOption("--help","","print help message.")
	printOption("-f","[filename]","load file into editor.")
	printOption("--file","[filename]","load file into editor.")
	printOption("-n","","show line numbers(default).")
	printOption("--line-number","","show line numbers(default).")
	printOption("-e","","Start editor in easy-mode.")
	printOption("--easy-mode","","Start editor in easy-mode.")
	printOption("-s","","Show cursor.(default)")
	printOption("--show-cursor","","Show cursor.(default)")
	printOption("-c","","enable color.")
	printOption("--enable-color","","enable color.")
	exit(true,true)
end

local functionMapper <const> = {
	n = showLineNumbers,
	['line-number'] = showLineNumbers,
	e = easyMode,
	['easy-mode'] = easyMode,
	c = enableColor,
	['enable-color'] = enableColor,
	s = showCursor,
	['show-cursor'] = showCursor,
	h = printHelp,
	['help'] = printHelp
}

local function changeConfigBasedOnFlag(flagAndArg,regex)
	local flag <const> = match(flagAndArg,regex)
	if functionMapper[flag] then functionMapper[flag]() end
end

--TODO fix this stuff up
local function readFile(argsText,textBuffer)
	local fileOption <const> = match(argsText,"%-%-file;*([^;]+)") or match(argsText,"%-f;*([^;]+)")
	if fileOption then
		Globals.fileName = fileOption
		return ReadFile.readFile(fileOption,textBuffer)
	end
end

function CmdArgs.readArgs(args,textBuffer)
	local argsText <const> = concat(args,";;")
	for dashes,flagAndArg in gmatch(argsText,'(%-+);*([^;]+%;*)') do
		if #dashes == 2 then
			changeConfigBasedOnFlag(flagAndArg,"([^;]+);+")
		else
			changeConfigBasedOnFlag(flagAndArg,"([^;]);*")
		end
	end
	readFile(argsText,textBuffer)
end

return CmdArgs
