scr = FoneOSScreen.new()

function setPhoneNumber(text)
	width = scr:width()
	height = scr:height()
	
	phoneNumber = scr:getId("phoneNumber")
	phoneNumber:text(text)
	phoneNumber:create()
	
	phoneNumber:x((width-phoneNumber:width()) / 2) -- center text
	
	phoneNumber:create()
end

function addNumber(text)
	phoneNumber = scr:getId("phoneNumber")
	if (phoneNumber:text() == "Enter number...") then
		phoneNumber:text("")
	end
	setPhoneNumber(phoneNumber:text() .. text)
	fone.layout.draw()
end

title = FoneOSTitle.new()
title:text("Dialer")
title:create()
scr:addTitle(title)

phoneNumber = FoneOSLabel.new()
phoneNumber:id("phoneNumber")
phoneNumber:x(5)
phoneNumber:y(30)
phoneNumber:create()
scr:addLabel(phoneNumber)

setPhoneNumber("Enter number...")

function createButton(no)
	local startX = 41
	local startY = 60
	local x, y = 0
	
	-- get x
	if (no == "1" or no == "4" or no == "7" or no == "*") then
		x = startX
	elseif (no == "2" or no == "5" or no == "8" or no == "0") then
		x = startX + 60
	elseif (no == "3" or no == "6" or no == "9" or no == "#") then
		x = startX + 60 + 60
	end
	
	-- get y
	if (no == "1" or no == "2" or no == "3") then
		y = startY
	elseif (no == "4" or no == "5" or no == "6") then
		y = startY + 45
	elseif (no == "7" or no == "8" or no == "9") then
		y = startY + 45 + 45
	elseif (no == "*" or no == "0" or no == "#") then
		y = startY + 45 + 45 + 45
	end
	
	btn = FoneOSButton.new()
	btn:id(no)
	btn:x(x)
	btn:y(y)
	btn:text(no)
	btn:create()
	btn:width(37)
	btn:height(37)
	btn:onActivate(function(self)
		addNumber(self:text())
	end)
	scr:addButton(btn)
	
	return btn
end

no1 = createButton("1")
no2 = createButton("2")
no3 = createButton("3")
no4 = createButton("4")
no5 = createButton("5")
no6 = createButton("6")
no7 = createButton("7")
no8 = createButton("8")
no9 = createButton("9")
star = createButton("*")
no0 = createButton("0")
pound = createButton("#")

callBtn = FoneOSButton.new()
callBtn:id("call")
callBtn:x(41)
callBtn:y(240)
callBtn:text("Call")
callBtn:create()
callBtn:width(97)
callBtn:height(37)
callBtn:onActivate(function()
	phoneNumber = fone.layout.current():getId("phoneNumber")
	if (phoneNumber:text() == "Enter number..." or phoneNumber:text() == "") then
		phoneNumber:text("")
		fone.layout.draw()
		return
	end
	fone.modem.call(phoneNumber:text())
	phoneNumber:text("")
	fone.layout.draw()
end)
scr:addButton(callBtn)

delBtn = FoneOSButton.new()
delBtn:id("del")
delBtn:x(161)
delBtn:y(240)
delBtn:text("D")
delBtn:create()
delBtn:width(37)
delBtn:height(37)
delBtn:onActivate(function()
	phoneNumber = fone.layout.current():getId("phoneNumber")
	if (phoneNumber:text() == "Enter number...") then
		phoneNumber:text("")
		fone.layout.draw()
		return
	end
	setPhoneNumber(phoneNumber:text():sub(1, phoneNumber:text():len()-1))
	fone.layout.draw()
end)
scr:addButton(delBtn)

fone.layout.current(scr)