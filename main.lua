--[[
	@author Gleilson Ferreira
]]
display.setStatusBar (display.HiddenStatusBar)

local composer = require( "composer" )

composer.setVariable( "operation", 3 )
composer.gotoScene( "game" )