local TextBuffer <const> = require('TextBuffer.TextBuffer')

local screen <const> = TextBuffer:new()

screen:addCharAt(1,'h')
		:addCharAt(1,'e')
		:addCharAt(1,'l')
	:addCharAt(1,'l'):addCharAt(1,'o'):addCharAt(1,'\n')
	:addLineAt():addCharAt(2,'w'):addCharAt(2,'o'):addCharAt(2,'r')
	:addCharAt(2,'l'):addCharAt(2,'d'):addCharAt(2,'\n')
	:replaceCharAt(2,2,8):replaceCharAt(-1,100,'r'):addCharAt(1,'\n')
	--	:addLineAt():addCharAt(3,'h'):addCharAt(3,'o'):addCharAt(3,'w'):addCharAt(3,'\n')
	--:removeCharAt(2,2):removeCharAt(2,1):removeCharAt(2,1):removeCharAt(2,1):removeCharAt(2,1):removeCharAt(2,1)

screen:print()
