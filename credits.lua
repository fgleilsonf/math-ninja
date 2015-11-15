--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
require( "setup" ) require( "glossario" )
local scene = composer.newScene()

local textBox

function scene:create( )
    local sceneGroup = self.view

    local background = setupBackground("images/background3.jpg");
    sceneGroup:insert(background)

    local titleGame = display.newText("Créditos",  display.contentWidth  * 0.5, 170, native.systemFontBold, 45)
    sceneGroup:insert(titleGame)

    textBox = native.newTextBox( 510, 370, display.contentWidth - 140, 300 )
    textBox.text = getGlossario().CREDITS
    textBox.isEditable = false
    textBox.size= 30
    sceneGroup:insert(textBox)

    local back = display.newImage("images/back.png", display.contentWidth  * 0.9, display.contentHeight * 0.75)
    back.width = 70
    back.height = 70
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