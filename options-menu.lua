--[[
	@author Gleilson Ferreira
]]

require( "setup" )
require( "cache" )
local composer = require( "composer" )
local scene = composer.newScene()

local images = getImage()

function scene:create( event )
    local sceneGroup = self.view

    local background = setupBackground(images.PATH_IMAGE_BACKGROUND_);
    sceneGroup:insert(background)

    local logo = display.newImage(images.PATH_IMAGE_LOGO_, display.contentWidth  * 0.5, 230)
    logo.width = 350
    logo.height = 220
    sceneGroup:insert(logo)

    local credits = display.newImage(images.PATH_IMAGE_CREDITS_, display.contentWidth  * 0.5, display.contentHeight * 0.57)
    sceneGroup:insert(credits)

    local tutorial = display.newImage(images.PATH_IMAGE_TUTORIAL_, display.contentWidth  * 0.5, display.contentHeight * 0.76)
    sceneGroup:insert(tutorial)

    local back = display.newImage(images.PATH_IMAGE_BACK_, display.contentWidth  * 0.87, display.contentHeight * 0.75)
    back.width = 180
    back.height = 120
    sceneGroup:insert(back)

    function back:tap()
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