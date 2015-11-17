 --[[
	@author Gleilson Ferreira
]]
display.setStatusBar (display.HiddenStatusBar)

local composer = require( "composer" )

composer.gotoScene( "root-square", {time=800, effect="crossFade"} )