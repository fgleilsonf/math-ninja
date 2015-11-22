--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
local scene = composer.newScene()
require( "setup" ) require( "cache" ) require( "path_files" )

local images = getImage()

function scene:create()
	local sceneGroup = self.view

    local background = setupBackground(images.PATH_IMAGE_BACKGROUND_);
    sceneGroup:insert(background)

    local logo = display.newImage(images.PATH_IMAGE_LOGO_, display.contentWidth  * 0.5, 230)
    logo.width = 350
    logo.height = 220
    sceneGroup:insert(logo)

	local ball = {}
	local radius = 150
    local optionHeight = display.contentHeight * 0.57

    local images = getImage()

    ball[1] = display.newImage(images.PATH_IMAGE_CIRCLE_, display.contentWidth  * 0.2, optionHeight)
    ball[1].width = radius
    ball[1].height = radius
    sceneGroup:insert(ball[1])

    ball[2] = display.newImage(images.PATH_IMAGE_CIRCLE_, display.contentWidth  * 0.4, optionHeight)
    ball[2].width = radius
    ball[2].height = radius
    sceneGroup:insert(ball[2])

    ball[3] = display.newImage(images.PATH_IMAGE_CIRCLE_, display.contentWidth  * 0.6, optionHeight)
    ball[3].width = radius
    ball[3].height = radius
    sceneGroup:insert(ball[3])

	ball[4] = display.newImage(images.PATH_IMAGE_CIRCLE_, display.contentWidth  * 0.8, optionHeight)
	ball[4].width = radius
	ball[4].height = radius
	sceneGroup:insert(ball[4])

	local rootSquare = display.newImage("images/square.png", ball[1].x, optionHeight )
    rootSquare.width = 80
    rootSquare.height = 80
    sceneGroup:insert(rootSquare)

	local operators = display.newImage("images/calc.png", ball[2].x, optionHeight)
	operators.width = 80
	operators.height = 80
	sceneGroup:insert(operators)

	local numberSquare = display.newImage("images/x2.png", ball[3].x, optionHeight)
    numberSquare.width = 80
    numberSquare.height = 80
	sceneGroup:insert(numberSquare)

    local fatorial = display.newImage("images/n.png", ball[4].x, optionHeight)
    fatorial.width = 80
    fatorial.height = 80
    sceneGroup:insert(fatorial)

    local menu = display.newImage("images/menu.png", display.contentWidth  * 0.8, display.contentHeight * 0.78)
    menu.height = 110
    sceneGroup:insert(menu)

    local recordeImage = display.newImage("images/recorde.png", 210, display.contentHeight * 0.78)
    recordeImage.height = 110
    sceneGroup:insert(recordeImage)

    local recorde = display.newText(getPontuacao(), 300, display.contentHeight * 0.77, "TrashHand", 50)
    sceneGroup:insert(recorde)

    function rootSquare:tap()
		composer.gotoScene( "root-square", {time=800, effect="crossFade"} )
	end

	function operators:tap()
		composer.gotoScene( "4-operations", {time=800, effect="crossFade"} )
    end

	function numberSquare:tap()
		composer.gotoScene( "number-square", {time=800, effect="crossFade"} )
    end

    function fatorial:tap()
        composer.gotoScene( "fatorial", {time=800, effect="crossFade"} )
    end

	rootSquare:addEventListener("tap", rootSquare)
	operators:addEventListener("tap", operators)
	numberSquare:addEventListener("tap", numberSquare)
    fatorial:addEventListener("tap", fatorial)

    function menu:tap()
        composer.gotoScene( "options-menu", {time=800, effect="crossFade"} )
    end

    menu:addEventListener("tap", menu)
end

function scene:show() end
function scene:hide()
    composer.removeScene( "menu" )
end
function scene:destroy() end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene