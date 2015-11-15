--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
local slideView = require("Zunware_SlideView")

local scene = composer.newScene()

local centerWidth = display.contentWidth / 2

local xMin = display.screenOriginX
local yMin = display.screenOriginY
local xMax = display.contentWidth - display.screenOriginX
local yMax = display.contentHeight - display.screenOriginY
local _W = display.contentWidth
local _H = display.contentHeight

function scene:create( )
    local sceneGroup = self.view

    local images = {
        "images/tutorial/menu.png",
        "images/tutorial/2.png"
    }

    local slideImages = slideView.new(images, nil)
    sceneGroup:insert(slideImages)

    local back = display.newImage("images/back.png", display.contentWidth  * 0.9, display.contentHeight * 0.8)
    back.width = 70
    back.height = 70
    sceneGroup:insert(back)

    local titleGame = display.newText("Imagens do Jogo",  display.contentWidth  * 0.5, 140, native.systemFontBold, 50)
    sceneGroup:insert(titleGame)

    function back:tap(event)
        composer.gotoScene( "menu" )
    end

    back:addEventListener("tap", back)
end 

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end

function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( event.phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene