 --[[
	@author Gleilson Ferreira
]]

require ( "cache" )

display.setStatusBar (display.HiddenStatusBar)

local composer = require( "composer" )

if (hasFirstAccess() == 0) then
    setFirstAccess(1)
    composer.gotoScene( "tutorial", {time=800, effect="crossFade"} )
else
    composer.gotoScene( "menu", {time=800, effect="crossFade"} )
end
