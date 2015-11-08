--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
local scene = composer.newScene()
local setup = require( "setup" )

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

	local ball = {}

    ball[1] = display.newImage("images/ball_green.png", display.contentWidth  * 0.3, display.contentHeight * 0.5)
    ball[1].width = 200
    ball[1].height = 200
    sceneGroup:insert(ball[1])

    ball[2] = display.newImage("images/ball_green.png", display.contentWidth  * 0.5, display.contentHeight * 0.5)
    ball[2].width = 200
    ball[2].height = 200
    sceneGroup:insert(ball[2])

    ball[3] = display.newImage("images/ball_green.png", display.contentWidth  * 0.7, display.contentHeight * 0.5)
    ball[3].width = 200
    ball[3].height = 200
    sceneGroup:insert(ball[3])

	local rootSquare = display.newImage("images/raiz2.png", display.contentWidth  * 0.3, display.contentHeight * 0.5)
	sceneGroup:insert(rootSquare)

	local operators = display.newImage("images/operators.png", display.contentWidth  * 0.5, display.contentHeight * 0.5)
	operators.width = 110
	operators.height = 110
	sceneGroup:insert(operators)

	local calc = display.newText("X²", display.contentWidth  * 0.7, display.contentHeight * 0.5, native.systemFontBold, 80)
	calc:setTextColor(0, 0, 0)
	sceneGroup:insert(calc)

    local titleGame = display.newText("Math Ninja",  display.contentWidth  * 0.5, display.contentHeight * 0.2, native.systemFontBold, 90)
	sceneGroup:insert(titleGame)

	function startGame( )
		composer.gotoScene( "game" )
	end

	function startGame (operator)
		composer.setVariable( "operator", operator )
		composer.gotoScene( "game" )
	end

    function rootSquare:tap(event)
		startGame(1)
	end

	function operators:tap(event)
		startGame(2)
	end

	function calc:tap(event)
		startGame(3)
	end

	rootSquare:addEventListener("tap", rootSquare)
	operators:addEventListener("tap", operators)
	calc:addEventListener("tap", calc)
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