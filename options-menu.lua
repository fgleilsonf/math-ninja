--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
local scene = composer.newScene()
require( "setup" ) require( "cache" )

function scene:create( event )
    local sceneGroup = self.view

    local xMin = display.screenOriginX
    local yMin = display.screenOriginY
    local xMax = display.contentWidth - display.screenOriginX
    local yMax = display.contentHeight - display.screenOriginY
    local _W = display.contentWidth
    local _H = display.contentHeight

    local background = setupBackground("images/background3.jpg");
    sceneGroup:insert(background)

    local titleGame = display.newText("Math Ninja",  display.contentWidth  * 0.5, display.contentHeight * 0.2, native.systemFontBold, 90)
    sceneGroup:insert(titleGame)

    local credits = display.newText("<< Créditos >>", display.contentWidth  * 0.5, display.contentHeight * 0.5, native.systemFontBold, 60)
    sceneGroup:insert(credits)

    local tutorial = display.newText("<< Tutorial >>", display.contentWidth  * 0.5, display.contentHeight * 0.6, native.systemFontBold, 60)
    sceneGroup:insert(tutorial)

    local back = display.newImage("images/back.png", display.contentWidth  * 0.9, display.contentHeight * 0.8)
    back.width = 100
    back.height = 100
    sceneGroup:insert(back)

    function back:tap(event)
        composer.gotoScene( "menu" )
    end

    function credits:tap(event)
        composer.gotoScene( "credits" )
    end

    function tutorial:tap(event)
        composer.gotoScene( "tutorial" )
    end

    credits:addEventListener("tap", credits)
    tutorial:addEventListener("tap", tutorial)
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