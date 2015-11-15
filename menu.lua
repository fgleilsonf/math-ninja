--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
local scene = composer.newScene()
require( "setup" ) require( "cache" )

function scene:create()
	local sceneGroup = self.view

    local background = setupBackground("images/background3.jpg");
    sceneGroup:insert(background)

	local ball = {}
	local radius = 160

    ball[1] = display.newImage("images/ball_green.png", display.contentWidth  * 0.2, display.contentHeight * 0.5)
    ball[1].width = radius
    ball[1].height = radius
    sceneGroup:insert(ball[1])

    ball[2] = display.newImage("images/ball_green.png", display.contentWidth  * 0.4, display.contentHeight * 0.5)
    ball[2].width = radius
    ball[2].height = radius
    sceneGroup:insert(ball[2])

    ball[3] = display.newImage("images/ball_green.png", display.contentWidth  * 0.6, display.contentHeight * 0.5)
    ball[3].width = radius
    ball[3].height = radius
    sceneGroup:insert(ball[3])

	ball[4] = display.newImage("images/ball_green.png", display.contentWidth  * 0.8, display.contentHeight * 0.5)
	ball[4].width = radius
	ball[4].height = radius
	sceneGroup:insert(ball[4])

	local rootSquare = display.newImage("images/raiz2.png", ball[1].x, display.contentHeight * 0.5)
    rootSquare.width = 100
    rootSquare.height = 100
    sceneGroup:insert(rootSquare)

	local operators = display.newImage("images/operators.png", ball[2].x, display.contentHeight * 0.5)
	operators.width = 80
	operators.height = 80
	sceneGroup:insert(operators)

	local numberSquare = display.newText("X²", ball[3].x + 10, display.contentHeight * 0.5, native.systemFontBold, 70)
    numberSquare:setTextColor(0, 0, 0)
	sceneGroup:insert(numberSquare)

    local fatorial = display.newText("n!", ball[4].x, display.contentHeight * 0.5, native.systemFontBold, 70)
    fatorial:setTextColor(0, 0, 0)
    sceneGroup:insert(fatorial)

    local titleGame = display.newText("Math Ninja",  display.contentWidth  * 0.5, 190, native.systemFontBold, 70)
	sceneGroup:insert(titleGame)

    function rootSquare:tap()
		composer.gotoScene( "root-square" )
	end

	function operators:tap()
		composer.gotoScene( "4-operations" )
    end

	function numberSquare:tap()
		composer.gotoScene( "number-square" )
    end

    function fatorial:tap()
        composer.gotoScene( "fatorial" )
    end

	rootSquare:addEventListener("tap", rootSquare)
	operators:addEventListener("tap", operators)
	numberSquare:addEventListener("tap", numberSquare)
    fatorial:addEventListener("tap", fatorial)

	local pontuacao = getPontuacao()

	local recorde = display.newText("Recorde: "..pontuacao, 170, display.contentHeight * 0.77, native.systemFontBold, 40)
	sceneGroup:insert(recorde)

    local menu = display.newText("<< Menu >>", display.contentWidth  * 0.82, display.contentHeight * 0.77, native.systemFontBold, 40)
    sceneGroup:insert(menu)

    function menu:tap()
        composer.gotoScene( "options-menu", {time=800, effect="crossFade"} )
    end

    menu:addEventListener("tap", menu)
end

function scene:show() end
function scene:hide() end
function scene:destroy() end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene