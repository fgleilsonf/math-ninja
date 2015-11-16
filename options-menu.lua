--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
local scene = composer.newScene()
require( "setup" ) require( "cache" )

function scene:create( event )
    local sceneGroup = self.view

    local background = setupBackground("images/lousa.png");
    sceneGroup:insert(background)

    local titleGame = display.newText("Math Ninja",  display.contentWidth  * 0.5, 190, native.systemFontBold, 70)
    sceneGroup:insert(titleGame)

    local credits = display.newText("<< Créditos >>", display.contentWidth  * 0.5, display.contentHeight * 0.5, native.systemFontBold, 50)
    sceneGroup:insert(credits)

    local tutorial = display.newText("<< Tutorial >>", display.contentWidth  * 0.5, display.contentHeight * 0.6, native.systemFontBold, 50)
    sceneGroup:insert(tutorial)

    local back = display.newImage("images/back.png", display.contentWidth  * 0.9, display.contentHeight * 0.75)
    back.width = 70
    back.height = 70
    sceneGroup:insert(back)

    function back:tap(event)
        composer.gotoScene( "menu", {time=800, effect="crossFade"} )
    end

    function credits:tap()
        composer.gotoScene( "credits", {time=800, effect="crossFade"})
    end

    function tutorial:tap()
        composer.gotoScene( "tutorial", {time=800, effect="crossFade"})
    end

    credits:addEventListener("tap", credits)
    tutorial:addEventListener("tap", tutorial)
    back:addEventListener("tap", back)
end

function scene:show( event ) end

function scene:hide( event ) end

function scene:destroy( event ) end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene