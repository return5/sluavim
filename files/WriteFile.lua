local openFile <const> = io.open
local concat <const> = table.concat

local WriteFile <const> = {type = "WriteFile"}
WriteFile.__index = WriteFile

_ENV = WriteFile

function WriteFile.writeFile(fileName,textBuffer)
	local file <const> = openFile(fileName,"w+")
	if file then
		local strTbl <const> = {}
		textBuffer:readIntoTable(strTbl)
		file:write(concat(strTbl))
		file:close()
	end
	return WriteFile
end

return WriteFile
