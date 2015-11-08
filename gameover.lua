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

	local scores = display.newText("Scores: 100",  display.contentWidth  * 0.5, display.contentHeight * 0.4, native.systemFontBold, 50)
	sceneGroup:insert(scores)

	local playGame = display.newText("Jogar novamente",  display.contentWidth  * 0.5, display.contentHeight * 0.6, native.systemFontBold, 60)
	sceneGroup:insert(playGame)

    function playGame:tap(event)
		composer.gotoScene( "game" )
	end

	function initBall()
		local center = display.contentWidth * 0.5
		local ball = {}

		ball[1] = display.newCircle( center, display.contentHeight - 120, 40 )
		ball[1]:setFillColor(0, 0, 255, 1)
		ball[1].color = "blue"

		ball[2] = display.newCircle( center + 110, display.contentHeight - 120, 40 )
		ball[2]:setFillColor(255, 0, 0, 1)
		ball[2].color = "red"

		ball[3] = display.newCircle( center - 110, display.contentHeight - 120, 40 )
		ball[3]:setFillColor(0, 255, 0, 1)
		ball[3].color = "green"

		sceneGroup:insert(ball[1])
		sceneGroup:insert(ball[2])
		sceneGroup:insert(ball[3])
	end

	initBall()
	
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