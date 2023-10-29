local BaseMode <const> = require('modes.BaseMode')
local ReplaceMode <const> = require('modes.replace.ReplaceMode')
local ContinuousReplacementMode <const> = require('modes.replace.ContinuousReplacementMode')

local ReplacementModeDriver <const> = {type = "ReplacementModeDriver"}
ReplacementModeDriver.__index = ReplacementModeDriver

setmetatable(ReplacementModeDriver,BaseMode)

_ENV = ReplacementModeDriver

function ReplacementModeDriver.replaceChar()
	return ReplaceMode
end

function ReplacementModeDriver.continuousReplacement()
	return ContinuousReplacementMode
end

return ReplacementModeDriver
