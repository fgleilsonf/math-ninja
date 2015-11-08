function setupBackground( urlImage )
	local xMin = display.screenOriginX
	local yMin = display.screenOriginY
	local xMax = display.contentWidth - display.screenOriginX
	local yMax = display.contentHeight - display.screenOriginY
	local _W = display.contentWidth
	local _H = display.contentHeight

	local background = display.newImageRect(urlImage, xMax-xMin, yMax-yMin)
	background.myName = "background"
	background.x = _W * 0.5
	background.y = _H * 0.5

	return background
end
