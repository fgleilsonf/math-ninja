--[[
	@author Gleilson Ferreira
]]

require( "setup" )
require( "glossario" )
require( "path_files" )

local composer = require( "composer" )
local scene = composer.newScene()

local images = getImage()
local textBox

function scene:create( )
    local sceneGroup = self.view

    local background = setupBackground(images.PATH_IMAGE_BACKGROUND_);
    sceneGroup:insert(background)

    local titleGame = display.newText("Créditos",  display.contentWidth  * 0.5, 170, native.systemFontBold, 45)
    sceneGroup:insert(titleGame)

    textBox = native.newTextBox( 510, 370, display.contentWidth - 140, 300 )
    textBox.text = getGlossario().CREDITS
    textBox.isEditable = false
    textBox.size= 30
    sceneGroup:insert(textBox)

    local back = display.newImage(images.PATH_IMAGE_BACK_, display.contentWidth  * 0.87, display.contentHeight * 0.75)
    back.width = 180
    back.height = 120
    sceneGroup:insert(back)

    function back:tap()
        textBox.isVisible = false
        composer.gotoScene( "options-menu" )
    end

    back:addEventListener("tap", back)
end

function scene:show( )
    textBox.isVisible = true
end

function scene:hide( ) end
function scene:destroy( ) end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene