--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
require( "setup" )
local scene = composer.newScene()

function scene:create( )
    local sceneGroup = self.view

    local background = setupBackground("images/background3.jpg");
    sceneGroup:insert(background)

    local titleGame = display.newText("Quadrado de um Número",  display.contentWidth  * 0.5, display.contentHeight * 0.15, native.systemFontBold, 70)
    sceneGroup:insert(titleGame)

    local text = "        O quadrado de um número inteiro é calculado através da  \n"..
            "   potenciação da base inteira em relação ao expoente de \n"..
            "   número dois. Dessa forma estamos multiplicando \n"..
            "   o número inteiro por ele mesmo. \n\n"..
            "   Os quadrados dos números seguem uma sequência lógica \n"..
            "   1, 4, 9, 16, 25, 36, 49, etc."

    local description = display.newText(text, display.contentWidth  * 0.52, display.contentHeight * 0.48, native.systemFontBold, 40)
    sceneGroup:insert(description)

    local back = display.newImage("images/back.png", display.contentWidth  * 0.9, display.contentHeight * 0.8)
    back.width = 100
    back.height = 100
    sceneGroup:insert(back)

    function back:tap(event)
        composer.gotoScene( "menu" )
    end

    back:addEventListener("tap", back)

    local play = display.newText("<< Jogar >>", display.contentWidth  * 0.5, display.contentHeight * 0.8, native.systemFontBold, 60)
    sceneGroup:insert(play)

    function play:tap(event)
        composer.setVariable( "operator", 3 )
        composer.gotoScene( "game" )
    end

    play:addEventListener("tap", play)
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
    elseif phase == "did" then
    end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
    elseif phase == "did" then
    end
end

function scene:destroy( event )
    local sceneGroup = self.view

    if myImage then
        myImage:removeSelf()
        myImage = nil
    end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene