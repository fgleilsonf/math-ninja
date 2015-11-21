--[[
	@author Gleilson Ferreira
]]

local composer = require( "composer" )
require( "path_files" )
require( "setup" )

local scene = composer.newScene()

local minimumDragTolerance = 60

local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight
local pad = 20
local top = 0
local bottom = 0

local xMin = display.screenOriginX
local yMin = display.screenOriginY
local xMax = display.contentWidth - display.screenOriginX
local yMax = display.contentHeight - display.screenOriginY
local _W = display.contentWidth
local _H = display.contentHeight

local circle = {}

local titles = {
    "Bem vindo ao Math Ninja",
    "Escolha um tema",
    "Estude o tema, teste seu aprendizado",
    "Calcule a resposta e corte a bola",
    "Avalie e der sua nota"
}

function scene:create( )
    local sceneGroup = self.view

    local proximo
    local jogar
    local pular
    local titleImage

    function new(imageSet)
        local slider = display.newGroup()
        slider.images = {}
        slider.imgNum = nil

        for i=1, #imageSet do
            local p = display.newImage(imageSet[i])
            local h = viewableScreenH-(top+bottom)

            slider:insert(p)

            p.width = (xMax - xMin) - 100
            p.height = (yMax - yMin) - 250
            p.x = _W * 0.5
            p.y = _H * 0.5

            if (i > 1) then
                p.x = screenW*1.5 + pad
            else
                p.x = screenW*.5
            end
            p.y = (h*.5) - 25
            slider.images[i] = p
        end

        slider.imgNum = 1
        slider.x = 0
        slider.y = top + display.screenOriginY


        function slider:touch(event)
            local phase = event.phase

            if (phase == "began") then
                display.getCurrentStage():setFocus(self.images[self.imgNum])
                self.images[self.imgNum].isFocus = true
                self.startPos = event.x
                self.prevPos = event.x

            elseif self.images[self.imgNum].isFocus then

                if (phase == "moved") then
                    if self.tween then transition.cancel(self.tween) end
                    local delta = event.x - self.prevPos
                    self.prevPos = event.x
                    self.images[self.imgNum].x = self.images[self.imgNum].x + delta

                    if( self.images[self.imgNum-1]) then
                        self.images[self.imgNum-1].x = self.images[self.imgNum-1].x + delta
                    end

                    if (self.images[self.imgNum+1]) then
                        self.images[self.imgNum+1].x = self.images[self.imgNum+1].x + delta
                    end

                elseif (phase == "ended" or phase == "cancelled") then

                    local dragDistance = event.x - self.startPos

                    if(dragDistance < -minimumDragTolerance and self.imgNum < #self.images) then
                        self:nextImage()
                    elseif (dragDistance > minimumDragTolerance and self.imgNum > 1) then
                        self:prevImage()
                    else
                        self:cancelMove()
                    end

                    if (phase == "cancelled") then
                        self:cancelMove()
                    end

                    display.getCurrentStage():setFocus(nil)
                    self.images[self.imgNum].isFocus = false
                end
            end
            return true
        end

        function slider:setSlideNumber()
            print("TODO: setSlideNumber")
        end

        function slider:cancelTween()
            if self.prevTween then
                transition.cancel(self.prevTween)
            end
            self.prevTween = self.tween
        end

        function slider:nextImage()
            self.tween  = transition.to( self.images[self.imgNum], {
                time=400,
                x=(screenW * 0.5 + pad) * -1,
                transition=easing.outExpo
            })

            self.tween = transition.to( self.images[self.imgNum+1], {
                time = 400,
                x = screenW * 0.5,
                transition=easing.outExpo
            })

            self.imgNum = self.imgNum + 1
            self:initImage(self.imgNum)
        end

        function slider:prevImage()
            self.tween = transition.to(
                self.images[self.imgNum],
                {
                    time=400,
                    x = screenW * 1.5 + pad,
                    transition = easing.outExpo
                }
            )
            self.tween = transition.to(
                self.images[self.imgNum-1],
                {
                    time=400,
                    x = screenW * 0.5,
                    transition = easing.outExpo
                }
            )
            self.imgNum = self.imgNum -1
            self:initImage(self.imgNum)
        end

        function slider:cancelMove()
            tween = transition.to (
                self.images[self.imgNum],
                {
                    time = 400,
                    x = screenW * 0.5,
                    transition = easing.outExpo
                }
            )

            tween = transition.to(
                self.images[self.imgNum-1],
                {
                    time = 400,
                    x = (screenW * 0.5 + pad) * -1,
                    transition = easing.outExpo
                }
            )

            tween = transition.to(
                self.images[self.imgNum+1],
                {
                    time = 400,
                    x = (screenW * 1.5 + pad),
                    transition = easing.outExpo
                }
            )
        end

        function slider:initImage(num)
            if(num < #self.images) then
                self.images[num+1].x = screenW * 1.5 + pad
            end

            if(num > 1) then
                self.images[num-1].x = (screenW * 0.5 + pad) * -1
            end

            clearCircles()
            circle[num]:setFillColor( 0, 1, 0, 1 )

            pular.isVisible = (num ~= #self.images)
            titleImage.text = titles[num]

            jogar.isVisible = (num == #self.images)
            proximo.isVisible = (num ~= #self.images)
        end

        function slider:jumpToImage(num)
            local i
            for i = 1, #self.images do
                if i < num then
                    self.images[i].x = -screenW * 0.5;
                elseif i > num then
                    self.images[i].x = screenW * 1.5 + pad
                else
                    self.images[i].x = screenW * 0.5 - pad
                end
            end
            self.imgNum = num
            self.initImage(self.imgNum)
        end

        function slider:cleanUp()
            self:removeEventListener("touch", self)
        end

        slider:addEventListener("touch", slider)
        return slider

    end

    local imagePath = getImage()

    local background = setupBackground(imagePath.PATH_IMAGE_BACKGROUND_);
    sceneGroup:insert(background)

    titleImage = display.newText(titles[1],  display.contentWidth  * 0.5, 150, "TrashHand", 45)
    sceneGroup:insert(titleImage)

    local images = {
        "images/tutorial/game.png",
        "images/tutorial/menu.png",
        "images/tutorial/game.png",
        "images/tutorial/menu.png",
        "images/tutorial/game.png"
    }

    local slideImages = new(images, nil)
    slideImages.strokeWidth = 50
    sceneGroup:insert(slideImages)

    pular = display.newImage("images/pular.png", 160, display.contentHeight - 170)
    pular.width = 280
    pular.height = 110
    sceneGroup:insert(pular)

    function pular:tap()
        composer.gotoScene( "menu", {time=800, effect="crossFade"} )
    end

    pular:addEventListener("tap", pular)

    jogar = display.newImage("images/jogar.png", display.contentWidth  * 0.86, display.contentHeight - 170)
    jogar.height = 120
    jogar.width = 270
    jogar.isVisible = false
    sceneGroup:insert(jogar)

    function jogar:tap()
        composer.gotoScene( "menu", {time=800, effect="crossFade"} )
    end

    jogar:addEventListener("tap", jogar)

    proximo = display.newImage("images/proximo.png", display.contentWidth  * 0.87, display.contentHeight - 170)
    proximo.height = 110
    sceneGroup:insert(proximo)

    function proximo:tap()
        slideImages:nextImage()
    end

    proximo:addEventListener("tap", proximo)

    circle[1] = display.newCircle( display.contentWidth  * 0.4, display.contentHeight - 170, 20 )
    circle[1]:setFillColor( 0, 1, 0, 1 )
    sceneGroup:insert(circle[1])

    circle[2] = display.newCircle( display.contentWidth  * 0.45, display.contentHeight - 170, 20 )
    circle[3] = display.newCircle( display.contentWidth  * 0.5, display.contentHeight - 170, 20 )
    circle[4] = display.newCircle( display.contentWidth  * 0.55, display.contentHeight - 170, 20 )
    circle[5] = display.newCircle( display.contentWidth  * 0.6, display.contentHeight - 170, 20 )

    sceneGroup:insert(circle[2])
    sceneGroup:insert(circle[3])
    sceneGroup:insert(circle[4])
    sceneGroup:insert(circle[5])

    function clearCircles()
        local i
        for i = 1, #circle do
            circle[i]:setFillColor( 1, 1, 1, 1 )
        end
    end
end 

function scene:show() end

function scene:hide()
    composer.removeScene( "tutorial" )
end

function scene:destroy() end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene