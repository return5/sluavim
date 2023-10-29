local ReplacementMode <const> = require('modes.replace.ReplaceMode')

local ContinuousReplacementMode <const> = { type = "ContinuousReplacementMode"}
ContinuousReplacementMode.__index = ContinuousReplacementMode

setmetatable(ContinuousReplacementMode,ReplacementMode)

_ENV = ContinuousReplacementMode

function ContinuousReplacementMode:replace(textBuffer,ch,cursor)
	if cursor:isXGreaterEndOfLine(textBuffer) then
		textBuffer:insert(cursor.y,ch,cursor.x)
	else
		textBuffer:replaceCharAt(ch,cursor)
	end
	cursor:moveRight()
	return self
end

function ContinuousReplacementMode:returnAfterReplacement()
	return ContinuousReplacementMode
end

return ContinuousReplacementMode
