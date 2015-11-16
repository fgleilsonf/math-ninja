--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
require( "setup" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = setupBackground("images/lousa.png");
	sceneGroup:insert(background)

	local logo = display.newImage("images/mathninjalogo.png", display.contentWidth  * 0.5, 230)
	logo.width = 300
	logo.height = 180
	sceneGroup:insert(logo)

	local playGame = display.newImage("images/playagain.png", display.contentWidth  * 0.5, display.contentHeight * 0.75)
	sceneGroup:insert(playGame)

	local scoresImage = display.newImage("images/scores.png", display.contentWidth  * 0.5, display.contentHeight * 0.55)
	sceneGroup:insert(scoresImage)

	local scores = composer.getVariable( "scores" )

	print( native.systemFont)

	local scores = display.newText(scores,  display.contentWidth  * 0.56, display.contentHeight * 0.55, "TrashHand", 80)
	sceneGroup:insert(scores)

	local back = display.newImage("images/back.png", display.contentWidth  * 0.87, display.contentHeight * 0.75)
	back.width = 180
	back.height = 120
	sceneGroup:insert(back)

	function back:tap(event)
		composer.gotoScene( "menu" )
	end

    function playGame:tap()
		composer.gotoScene( "game" )
	end

	playGame:addEventListener("tap", playGame)
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