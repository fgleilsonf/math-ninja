--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
local slideView = require("Zunware_SlideView")
require( "setup" )

local scene = composer.newScene()

function scene:create( )
    local sceneGroup = self.view

    local background = setupBackground("images/lousa.png");
    sceneGroup:insert(background)

    local images = {
        "images/tutorial/menu.png",
        "images/tutorial/2.png"
    }

    local slideImages = slideView.new(images, nil)
    sceneGroup:insert(slideImages)

    local back = display.newImage("images/back.png", display.contentWidth  * 0.87, display.contentHeight * 0.79)
    back.width = 170
    back.height = 100
    sceneGroup:insert(back)

    local titleGame = display.newText("Tutorial",  display.contentWidth  * 0.5, 150, native.systemFontBold, 50)
    sceneGroup:insert(titleGame)

    function back:tap(event)
        composer.gotoScene( "menu" )
    end

    back:addEventListener("tap", back)
end 

function scene:show() end
function scene:hide() end
function scene:destroy() end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene