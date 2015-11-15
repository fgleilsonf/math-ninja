 --[[
	@author Gleilson Ferreira
]]
display.setStatusBar (display.HiddenStatusBar)

local composer = require( "composer" )

 composer.setVariable( "operation", 4 )
 composer.gotoScene( "game", {time=800, effect="crossFade"} )
-- composer.gotoScene( "menu", {time=800, effect="crossFade"} )
 --composer.gotoScene( "game", {time=800, effect="crossFade"} )
 --composer.gotoScene( "number-square", {time=800, effect="crossFade"} )
--composer.gotoScene( "root-square", {time=800, effect="crossFade"} )
--composer.gotoScene( "4-operations", {time=800, effect="crossFade"} )