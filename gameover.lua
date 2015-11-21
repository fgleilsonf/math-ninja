--[[
	@author Gleilson Ferreira
]]

require( "setup" )
require("path_files")

local composer = require( "composer" )
local scene = composer.newScene()

local imagesPath = getImage()

function scene:create()
	local sceneGroup = self.view

	local background = setupBackground(imagesPath.PATH_IMAGE_BACKGROUND_);
	sceneGroup:insert(background)

	local logo = display.newImage(imagesPath.PATH_IMAGE_GAMEOVER_, display.contentWidth  * 0.5, 230)
	logo.width = 400
	logo.height = 180
	sceneGroup:insert(logo)

	local playGame = display.newImage(imagesPath.PATH_IMAGE_JOGAR_NOVAMENTE_, display.contentWidth  * 0.5, display.contentHeight * 0.75)
	sceneGroup:insert(playGame)

	local scoresImage = display.newImage(imagesPath.PATH_IMAGE_SCORES_, display.contentWidth  * 0.5, display.contentHeight * 0.55)
	sceneGroup:insert(scoresImage)

	local scores = composer.getVariable( "scores" )

	local scores = display.newText(scores,  display.contentWidth  * 0.56, display.contentHeight * 0.55, "TrashHand", 80)
	sceneGroup:insert(scores)

	local back = display.newImage("images/back.png", display.contentWidth  * 0.87, display.contentHeight * 0.75)
	back.width = 180
	back.height = 120
	sceneGroup:insert(back)

	function back:tap()
		composer.gotoScene( "menu" )
	end

    function playGame:tap()
		composer.gotoScene( "game" )
	end

	playGame:addEventListener("tap", playGame)
	back:addEventListener("tap", back)
end

function scene:show( ) end
function scene:hide( )
    composer.removeScene( "gameover" )
end
function scene:destroy( ) end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene