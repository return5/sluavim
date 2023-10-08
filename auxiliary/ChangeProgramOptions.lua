--[[
	class which sets/unsets options based on the config file
--]]

local Config <const> = require('config.config')
local NcursesColors <const> = require('ncurses.NcursesColors')
local NcursesAux <const> = require('ncurses.NcursesAux')
local NormalMode <const> = require('modes.NormalMode')
local InsertMode <const> = require('modes.InsertMode')

local pairs <const> = pairs

local ChangeProgramOptions <const> = {}
ChangeProgramOptions.__index = ChangeProgramOptions

_ENV = ChangeProgramOptions

local function setColorPairs(colorPairs)
	for number,pair in pairs(colorPairs) do
		NcursesColors.setColorPair(pair[1],number,pair[2],pair[3])
	end
end

local function setColorValues(colorValues)
	for color,values in pairs(colorValues) do
		NcursesColors.initColor(color,values[1],values[2],values[3])
	end
end

local function enableColor()
	NcursesColors.startColor()
end

local function showCursor(val)
	NcursesAux.showCursor(val)
end

local function showLineNumbers(val)
	--TODO
end

function ChangeProgramOptions.options()
	if Config.showLineNumbers ~= nil then showLineNumbers(Config.showLineNumbers) end
	if Config.showCursor ~= nil then showCursor(Config.showCursor) end
	if Config.enableColor then enableColor() end
	if Config.colorPairs ~= nil then setColorPairs(Config.colorPairs) end
	if Config.colorValues ~= nil then setColorValues(Config.colorValues) end
end

local function setEasyMode()

end

function ChangeProgramOptions.getInitMode()
	if Config.easyMode ~= nil and Config.easyMode then return setEasyMode() end
	return NormalMode
end

return ChangeProgramOptions
