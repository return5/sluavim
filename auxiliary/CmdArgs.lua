local config <const> = require('config.config')

local match <const> = string.match
local gmatch <const> = string.gmatch
local concat <const> = table.concat
local lower <const> = string.lower
local error <const> = io.stderr
local exit <const> = os.exit

local CmdArgs <const> = {}
CmdArgs.__index = CmdArgs

_ENV = CmdArgs

local booleanValues <const> = {
	t = true, ['true'] = true, f = false, ['false'] = false
}

local function checkBoolean(arg,flag)
	local lowerArg <const> = lower(arg)
	if booleanValues[lowerArg] ~= nil then return booleanValues[lowerArg] end
	error:write("Error: the flag '",flag,"' requires a boolean value.\n")
	exit(false)
end

local function changeBooleanValue(field,value)
	local boolVal <const> = checkBoolean(value,field)
	config[field] = boolVal
end

local function showLineNumber(value)
	changeBooleanValue('showLineNumber',value)
end

local function easyMode(value)
	changeBooleanValue('easyMode',value)
end

local function enableColor(value)
	changeBooleanValue('enableColor',value)
end

local function showCursor(value)
	changeBooleanValue('showCursor',value)
end

local functionMapper <const> = {
	n = showLineNumber,
	['line-number'] = showLineNumber,
	e = easyMode,
	['easy-mode'] = easyMode,
	c = enableColor,
	['enable-color'] = enableColor,
	s = showCursor,
	['show-cursor'] = showCursor
}

local function changeConfigBasedOnFlag(flagAndArg,regex)
	local flag <const>, argument <const> = match(flagAndArg,regex)
	if functionMapper[flag] then functionMapper[flag](argument) end
end

function CmdArgs.readArgs(args)
	local argsText <const> = concat(args,";;")
	for dashes,flagAndArg in gmatch(argsText,'(%-+);*([^;]+%;*[^;%-]*)') do
		if #dashes == 2 then
			changeConfigBasedOnFlag(flagAndArg,"([^;]+);+(.+)")
		else
			changeConfigBasedOnFlag(flagAndArg,"([^;]);*(.+)")
		end
	end
end

return CmdArgs
