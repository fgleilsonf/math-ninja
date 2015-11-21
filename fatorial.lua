--[[
	@author Gleilson Ferreira
]]

require( "setup" )
require( "glossario" )
require( "path_files" )

local composer = require( "composer" )
local scene = composer.newScene()
local images = getImage()


function scene:create( )
    local sceneGroup = self.view

    local background = setupBackground(images.PATH_IMAGE_BACKGROUND_);
    sceneGroup:insert(background)

    local titleGame = display.newText("Fatorial",  display.contentWidth  * 0.5, 170, "Verdana", 70)
    sceneGroup:insert(titleGame)

    local definition = display.newText(getGlossario().FATORIAL, 510, 410, display.contentWidth - 140, 350 )
    sceneGroup:insert(definition)

    local back = display.newImage(images.PATH_IMAGE_BACK_, display.contentWidth  * 0.87, display.contentHeight * 0.77)
    back.width = 180
    back.height = 120
    sceneGroup:insert(back)

    function back:tap()
        composer.gotoScene( "menu" )
    end

    back:addEventListener("tap", back)

    local play = display.newImage(images.PATH_IMAGE_JOGAR_, display.contentWidth  * 0.5, display.contentHeight * 0.77)
    play.width = 240
    play.height = 120
    sceneGroup:insert(play)

    function play:tap()
        composer.setVariable( "operation", 4 )
        composer.gotoScene( "game" )
    end

    play:addEventListener("tap", play)
end

function scene:show( ) end
function scene:hide( ) end
function scene:destroy( ) end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene