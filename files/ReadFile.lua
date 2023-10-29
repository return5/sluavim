local openFile <const> = io.open


local ReadFile <const> = {type = "ReadFile"}
ReadFile.__index = ReadFile

_ENV = ReadFile

function ReadFile.readFile(fileName,textBuffer)
	local file <const> = openFile(fileName,"r")
	if file then
		local text <const> = file:read("*a")
		textBuffer:readTextIntoBuffer(text)
		file:close()
	end
	return ReadFile
end

return ReadFile
