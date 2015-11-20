--[[
	@author Gleilson Ferreira
]]

require( "setup" )
require( "glossario" )
require( "path_files" )

local composer = require( "composer" )
local scene = composer.newScene()

local images = getImage()

function scene:create( )
    local sceneGroup = self.view

    local background = setupBackground(images.PATH_IMAGE_BACKGROUND_);
    sceneGroup:insert(background)

    local titleGame = display.newText("Créditos",  display.contentWidth  * 0.5, 170, "Verdana", 70)
    sceneGroup:insert(titleGame)

    local paint = {
        type = "image",
        filename = "images/avatar.jpg"
    }

    local perfil = display.newCircle( 120, 280, 60 )
    perfil.fill = paint
    sceneGroup:insert(perfil)

    local logo = display.newImage(images.PATH_IMAGE_LOGO_, display.contentWidth  * 0.8, 280)
    logo.width = 300
    logo.height = 200
    sceneGroup:insert(logo)

    local info = {}

    info[1] = display.newText("Gleilson Ferreira\nfgleilsonf@gmail.com", 640, 400, display.contentWidth - 140, 300, "Verdana", 30  )
    sceneGroup:insert(info[1])

    info[2] = display.newText("Github: https://github.com/fgleilsonf/", 500, display.contentHeight - 260, display.contentWidth - 140, 300, "Verdana", 30  )
    sceneGroup:insert(info[2])

    info[3] = display.newText("Projeto: Math Ninja estágio 1 FA7", 500, display.contentHeight - 210, display.contentWidth - 140, 300, "Verdana", 30  )
    sceneGroup:insert(info[3])

    info[4] = display.newText("Orientador: Eduardo Mendes", 500, display.contentHeight - 60, display.contentWidth - 140, 300, "Verdana", 30  )
    sceneGroup:insert(info[4])

    info[5] = display.newText("Corona API documentação: https://docs.coronalabs.com", 500, display.contentHeight - 160, display.contentWidth - 140, 300, "Verdana", 30  )
    sceneGroup:insert(info[5])

    info[6] = display.newText("Github projeto base: germc/Samurai-Fruit", 500, display.contentHeight - 110, display.contentWidth - 140, 300, "Verdana", 30  )
    sceneGroup:insert(info[6])

    info[7] = display.newText("Versão: 1.0", 500, display.contentHeight - 10, display.contentWidth - 140, 300, "Verdana", 30  )
    sceneGroup:insert(info[7])

    local back = display.newImage(images.PATH_IMAGE_BACK_, display.contentWidth  * 0.87, display.contentHeight * 0.75)
    back.width = 180
    back.height = 120
    sceneGroup:insert(back)

    function back:tap()
        composer.gotoScene( "options-menu" )
    end

    back:addEventListener("tap", back)
end

function scene:show( ) end
function scene:hide( ) end
function scene:destroy( ) end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene