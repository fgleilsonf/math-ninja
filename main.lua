 --[[
	@author Gleilson Ferreira
]]
display.setStatusBar (display.HiddenStatusBar)

local composer = require( "composer" )

composer.gotoScene( "menu", {time=800, effect="crossFade"} )