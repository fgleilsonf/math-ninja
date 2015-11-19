 --[[
	@author Gleilson Ferreira
]]

display.setStatusBar (display.HiddenStatusBar)

local composer = require( "composer" )

composer.gotoScene( "credits", {time=800, effect="crossFade"} )