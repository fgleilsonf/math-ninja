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

    local titlePage = display.newText("Créditos",  display.contentWidth  * 0.5, display.contentHeight * 0.15, native.systemFontBold, 70)
    sceneGroup:insert(titlePage)

    local multiplication = display.newText("Definições", display.contentWidth  * 0.198, display.contentHeight * 0.3, native.systemFontBold, 40)
    sceneGroup:insert(multiplication)

    local division = display.newText("Baseado no projeto Samuray-ninja", display.contentWidth  * 0.38, display.contentHeight * 0.4, native.systemFontBold, 40)
    sceneGroup:insert(division)

    local sum = display.newText("Imagens e ícones", display.contentWidth  * 0.25, display.contentHeight * 0.5, native.systemFontBold, 40)
    sceneGroup:insert(sum)

    local back = display.newImage("images/back.png", display.contentWidth  * 0.9, display.contentHeight * 0.8)
    back.width = 100
    back.height = 100
    sceneGroup:insert(back)

    function back:tap(event)
        composer.gotoScene( "options-menu" )
    end

    back:addEventListener("tap", back)
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