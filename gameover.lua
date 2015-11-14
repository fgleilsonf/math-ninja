--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
require( "setup" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = setupBackground("images/background3.jpg");
	sceneGroup:insert(background)

    local titleGame = display.newText("Math Ninja",  display.contentWidth  * 0.5, display.contentHeight * 0.2, native.systemFontBold, 90)
	sceneGroup:insert(titleGame)

	local scores = composer.getVariable( "scores" )
	local scores = display.newText("Scores: "..scores,  display.contentWidth  * 0.5, display.contentHeight * 0.4, native.systemFontBold, 50)
	sceneGroup:insert(scores)

	local playGame = display.newText("Jogar novamente",  display.contentWidth  * 0.5, display.contentHeight * 0.6, native.systemFontBold, 60)
	sceneGroup:insert(playGame)

    function playGame:tap(event)
		composer.gotoScene( "game" )
	end

	playGame:addEventListener("tap", playGame)
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