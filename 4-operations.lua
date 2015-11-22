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

    local titleGame = display.newText("4 - Operações",  display.contentWidth  * 0.5, 170, "Verdana", 70)
    sceneGroup:insert(titleGame)

    local info = {}

    info[1] = display.newText(" X : Multiplicação", 510, 410, display.contentWidth - 140, 300, "Verdana", 30 )
    sceneGroup:insert(info[1])

    info[1] = display.newText(" / : Divisão", 510, 480, display.contentWidth - 140, 300, "Verdana", 30 )
    sceneGroup:insert(info[1])

    info[4] = display.newText("+ : Soma", 510, 550, display.contentWidth - 140, 300, "Verdana", 30 )
    sceneGroup:insert(info[4])

    info[5] = display.newText(" - : Subtração", 510, 620, display.contentWidth - 140, 300, "Verdana", 30 )
    sceneGroup:insert(info[5])

    local back = display.newImage(images.PATH_IMAGE_BACK_, display.contentWidth  * 0.87, display.contentHeight * 0.77)
    back.width = 180
    back.height = 120
    sceneGroup:insert(back)

    local play = display.newImage(images.PATH_IMAGE_JOGAR_, display.contentWidth  * 0.5, display.contentHeight * 0.77)
    play.width = 240
    play.height = 120
    sceneGroup:insert(play)

    function play:tap()
        composer.setVariable( "operation", 2 )
        composer.gotoScene( "game", {time=800, effect="crossFade"} )
    end

    function back:tap()
        composer.gotoScene( "menu", {time=800, effect="crossFade"} )
    end

    back:addEventListener("tap", back)
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