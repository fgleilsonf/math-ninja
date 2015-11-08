
require ("physics")
require( "setup" )
require( "constants" )
local ui = require("ui")
local composer = require( "composer" )
local scene = composer.newScene()

physics.start()
physics.setGravity( 0, 9.8 * 2)
physics.start()

require( "path_files" )

local images = getImage()

local PATH_IMAGE_BALL_RED_ = "images/ball_red.png"
local PATH_IMAGE_BALL_GREEN_ = "images/ball_green.png"
local PATH_IMAGE_BALL_BLUE_ = "images/ball_blue.png"

local endPoints = {}
local maxPoints = 5
local lineThickness = 20
local lineFadeTime = 250

local slashSoundEnabled = true -- sound should be enabled by default on startup
local minTimeBetweenSlashes = 150 -- Minimum amount of time in between each slash sound
local minDistanceForSlashSound = 50 -- Amount of pixels the users finger needs to travel in one frame in order to play a slash sound

local soundCut = audio.loadSound("cut.wav")
local preExplosion = audio.loadSound("preExplosion.wav")
local explosion = audio.loadSound("explosion.wav")

local avalBall = {}

local ballProp = {
    density = 1.0,
    friction = 0.3,
    bounce = 0.2,
    filter = {
        categoryBits = 2,
        maskBits = 1
    }
}

local gushProp = {
    density = 1.0,
    friction = 0.3,
    bounce = 0.2,
    filter = {
        categoryBits = 4,
        maskBits = 8
    }
}

local minVelocityY = 850
local maxVelocityY = 1100

local minVelocityX = -200
local maxVelocityX = 200

local minAngularVelocity = 100
local maxAngularVelocity = 200

local minAngularVelocityChopped = 100
local maxAngularVelocityChopped = 200

local operatorsSymbol = getOperators()
local operators = {
    operatorsSymbol.OPERATOR_MULTIPLICATION_,
    operatorsSymbol.OPERATOR_DIVISION_,
    operatorsSymbol.OPERATOR_SUBTRACTION_,
    operatorsSymbol.OPERATOR_SUM_
}

local minGushRadius = 10
local maxGushRadius = 25
local numOfGushParticles = 15
local gushFadeTime = 500
local gushFadeDelay = 500

local minGushVelocityX = -350
local maxGushVelocityX = 350
local minGushVelocityY = -350
local maxGushVelocityY = 350

local bombTimer
local fruitTimer

local fruitShootingInterval = 1000
local bombShootingInterval = 5000

local splashImgs = {}

local splashFadeTime = 2500
local splashFadeDelayTime = 5000
local splashInitAlpha = .5
local splashSlideDistance = 50

local colorBallWithResponse

local listQuestios = {}

function scene:create()
    local sceneGroup = self.view

    local background = setupBackground("images/background3.jpg");
    sceneGroup:insert(background)

    local ball = {}
    local lifes = {}
    local questions = {}
    local countLife = 3

    function initQuestions()
        local LEFT_BALL_ = 220

        questions[0] = display.newText("?",  LEFT_BALL_, ball[0].y, native.systemFontBold, 70)
        questions[1] = display.newText("?",  LEFT_BALL_, ball[1].y, native.systemFontBold, 70)
        questions[2] = display.newText("?",  LEFT_BALL_, ball[2].y, native.systemFontBold, 70)

        sceneGroup:insert(questions[0])
        sceneGroup:insert(questions[1])
        sceneGroup:insert(questions[2])
    end

    function initLife()
        lifes[1] = display.newImage(images.PATH_IMAGE_LIFE_, display.contentWidth  - 110, 85)
        lifes[2] = display.newImage(images.PATH_IMAGE_LIFE_, display.contentWidth  - 180, 85)
        lifes[3] = display.newImage(images.PATH_IMAGE_LIFE_, display.contentWidth  - 250, 85)

        sceneGroup:insert(lifes[1])
        sceneGroup:insert(lifes[2])
        sceneGroup:insert(lifes[3])
    end

    function initBall()
        ball[0] = display.newImage(images.PATH_IMAGE_BALL_RED_, 120, display.contentHeight  * 0.36)
        ball[0].width = 100
        ball[0].height = 100
        ball[0].color = "red"

        ball[1] = display.newImage(images.PATH_IMAGE_BALL_BLUE_, 120, display.contentHeight  * 0.5)
        ball[1].width = 100
        ball[1].height = 100
        ball[1].color = "blue"

        ball[2] = display.newImage(images.PATH_IMAGE_BALL_GREEN_, 120, display.contentHeight  * 0.64)
        ball[2].width = 100
        ball[2].height = 100
        ball[2].color = "green"

        sceneGroup:insert(ball[0])
        sceneGroup:insert(ball[1])
        sceneGroup:insert(ball[2])
    end

    initBall()
    initLife()
    initQuestions()

    local questionToResponse = display.newText(" ? + ? = ?",  display.contentWidth * 0.5, display.contentHeight  * 0.5, native.systemFontBold, 90)
    questionToResponse:setTextColor(255, 255, 255)
    sceneGroup:insert(questionToResponse)

    Runtime:addEventListener("touch", drawSlashLine)

    function initBallAndSplash()
        local ballRed = {}
        ballRed.whole = PATH_IMAGE_BALL_RED_
        ballRed.top = "images/ball_red_top.png"
        ballRed.bottom = "images/ball_red_bottom.png"
        ballRed.splash = PATH_IMAGE_BALL_RED_
        ballRed.color = "red"
        table.insert(avalBall, ballRed)

        local ballBlue = {}
        ballBlue.whole = PATH_IMAGE_BALL_BLUE_
        ballBlue.top = "images/ball_blue_top.png"
        ballBlue.bottom = "images/ball_blue_bottom.png"
        ballBlue.splash = PATH_IMAGE_BALL_BLUE_
        ballBlue.color = "blue"
        table.insert(avalBall, ballBlue)

        local ballGreen = {}
        ballGreen.whole = PATH_IMAGE_BALL_GREEN_
        ballGreen.top = "images/ball_green_top.png"
        ballGreen.bottom = "images/ball_green_bottom.png"
        ballGreen.splash = PATH_IMAGE_BALL_GREEN_
        ballGreen.color = "green"
        table.insert(avalBall, ballGreen)

        table.insert(splashImgs, "images/ok.png")
        table.insert(splashImgs, "images/error.png")
    end

    function createGush(ball)
        local i
        for  i = 0, numOfGushParticles do
            local gush = display.newCircle( ball.x, ball.y, math.random(minGushRadius, maxGushRadius) )

            if (ball.color == "red") then
                gush:setFillColor(255, 0, 0, 255)
            end

            if (ball.color == "blue") then
                gush:setFillColor(255, 0, 255, 255)
            end

            if (ball.color == "green") then
                gush:setFillColor(255, 255, 0, 255)
            end

            gushProp.radius = gush.width / 2
            physics.addBody(gush, "dynamic", gushProp)

            local xVelocity = math.random(minGushVelocityX, maxGushVelocityX)
            local yVelocity = math.random(minGushVelocityY, maxGushVelocityY)

            gush:setLinearVelocity(xVelocity, yVelocity)

            transition.to(gush, {
                time = gushFadeTime,
                delay = gushFadeDelay,
                width = 0,
                height = 0,
                alpha = 0,
                onComplete = function(event) gush:removeSelf() end
            })
        end
    end

    function createSplash(ball)
        local splash = getRandomSplash(ball)
        splash.x = ball.x
        splash.y = ball.y
        splash.alpha = splashInitAlpha
        sceneGroup:insert(splash)

        transition.to(splash, {
            time = splashFadeTime,
            alpha = 0,
            y = splash.y + splashSlideDistance,
            delay = splashFadeDelayTime,
            onComplete = function(event)
                splash:removeSelf()
            end
        })

    end

    function createFruitPiece(fruit, section)

        local fruitVelX, fruitVelY = fruit:getLinearVelocity()

        local half = display.newImage(fruit[section])
        half.x = fruit.x - fruit.x
        local yOffSet = section == "top" and -half.height / 2 or half.height / 2
        half.y = fruit.y + yOffSet - fruit.y

        local newPoint = {}
        newPoint.x = half.x * math.cos(fruit.rotation * (math.pi /  180)) - half.y * math.sin(fruit.rotation * (math.pi /  180))
        newPoint.y = half.x * math.sin(fruit.rotation * (math.pi /  180)) + half.y * math.cos(fruit.rotation * (math.pi /  180))

        half.x = newPoint.x + fruit.x
        half.y = newPoint.y + fruit.y
        sceneGroup:insert(half)

        half.rotation = fruit.rotation
        ballProp.radius = half.width / 2
        physics.addBody(half, "dynamic", ballProp)

        local velocity  = math.sqrt(math.pow(fruitVelX, 2) + math.pow(fruitVelY, 2))
        local xDirection = section == "top" and -1 or 1
        local velocityX = math.cos((fruit.rotation + 90) * (math.pi /  180)) * velocity * xDirection
        local velocityY = math.sin((fruit.rotation + 90) * (math.pi /  180)) * velocity
        half:setLinearVelocity(velocityX,  velocityY)

        local minAngularVelocity = getRandomValue(minAngularVelocityChopped, maxAngularVelocityChopped)
        local direction = (math.random() < .5) and -1 or 1
        half.angularVelocity = minAngularVelocity * direction
    end

    function chopBall(ball)

        print("BOla", colorBallWithResponse)

        if (colorBallWithResponse == ball.color) then
            createOtherQuestion()
        else
            lifes[countLife].alpha = 0
            countLife = countLife - 1

            if (countLife == 0) then
                composer.gotoScene( "gameover" )
            end
        end

        createFruitPiece(ball, "top")
        createFruitPiece(ball, "bottom")

        createSplash(ball)
        createGush(ball)

        ball:removeSelf()
    end

    function getRandomValue(min, max)
        return min + math.abs(((max - min) * math.random()))
    end

    function getRandomSplash(ball)
        if (colorBallWithResponse == ball.color) then
            return display.newImage(splashImgs[1])
        end

        return display.newImage(splashImgs[2])
    end

    function getRandomBall()
        local ballProp = avalBall[math.random(1, #avalBall)]
        local ball = display.newImage(ballProp.whole)
        ball.whole = ballProp.whole
        ball.top = ballProp.top
        ball.bottom = ballProp.bottom
        ball.splash = ballProp.splash
        ball.color = ballProp.color

        return ball
    end

    function getBomb()
        local bomb = display.newImage( "images/bomb.png")
        return bomb
    end

    function blankOutScreen(bomb, linesGroup)

        local circle = display.newCircle( bomb.x, bomb.y, 5 )
        local circleGrowthTime = 300
        local dissolveDuration = 1000

        local dissolve = function(event)
            transition.to(circle, {
                alpha = 0,
                time = dissolveDuration,
                delay = 0,
                onComplete=function(event)
                    composer.gotoScene( "gameover" )
                end
            });
        end

        circle.alpha = 0
        transition.to(circle, {time=circleGrowthTime, alpha = 1, width = display.contentWidth * 3, height = display.contentWidth * 3, onComplete = dissolve})

        -- Vibrate the phone
        system.vibrate()

        bomb:removeSelf()
        linesGroup:removeSelf()
    end

    function explodeBomb(bomb, listener)

        bomb:removeEventListener("touch", listener)

        -- The bomb should not move while exploding
        bomb.bodyType = "kinematic"
        bomb:setLinearVelocity(0,  0)
        bomb.angularVelocity = 0

        -- Shake the stage
        local stage = display.getCurrentStage()

        local moveRightFunction
        local moveLeftFunction
        local rightTrans
        local leftTrans
        local shakeTime = 50
        local shakeRange = {min = 1, max = 25}

        moveRightFunction = function(event) rightTrans = transition.to(stage, {x = math.random(shakeRange.min,shakeRange.max), y = math.random(shakeRange.min, shakeRange.max), time = shakeTime, onComplete=moveLeftFunction}); end
        moveLeftFunction = function(event) leftTrans = transition.to(stage, {x = math.random(shakeRange.min,shakeRange.max) * -1, y = math.random(shakeRange.min,shakeRange.max) * -1, time = shakeTime, onComplete=moveRightFunction});  end

        moveRightFunction()

        local linesGroup = display.newGroup()

        -- Generate a bunch of lines to simulate an explosion
        local drawLine = function(event)

            local line = display.newLine(bomb.x, bomb.y, display.contentWidth * 2, display.contentHeight * 2)
            line.rotation = math.random(1,360)
            line.strokeWidth = math.random(15, 25)
            linesGroup:insert(line)
        end
        local lineTimer = timer.performWithDelay(100, drawLine, 0)

        -- Function that is called after the pre explosion
        local explode = function(event)

            audio.play(explosion)
            blankOutScreen(bomb, linesGroup);
            timer.cancel(lineTimer)
            stage.x = 0
            stage.y = 0
            transition.cancel(leftTrans)
            transition.cancel(rightTrans)

        end

        -- Play the preExplosion sound first followed by the end explosion
        audio.play(preExplosion, {onComplete = explode})

        timer.cancel(fruitTimer)
        timer.cancel(bombTimer)

    end

    function shootObject(type)
        local object = type == "ball" and getRandomBall() or getBomb()

        sceneGroup:insert(object)

        object.x = display.contentWidth / 2
        object.y = display.contentHeight  + object.height * 2

        ballProp.radius = object.height / 2
        physics.addBody(object, "dynamic", ballProp)

        if (type == "ball") then
            object:addEventListener("touch", function(event) chopBall(object) end)
        else
            local bombTouchFunction
            bombTouchFunction = function(event) explodeBomb(object, bombTouchFunction); end
            object:addEventListener("touch", bombTouchFunction)
        end

        local yVelocity = getRandomValue(minVelocityY, maxVelocityY) * -1
        local xVelocity = getRandomValue(minVelocityX, maxVelocityX)
        object:setLinearVelocity(xVelocity,  yVelocity)

        local minAngularVelocity = getRandomValue(minAngularVelocity, maxAngularVelocity)
        local direction = (math.random() < .5) and -1 or 1
        minAngularVelocity = minAngularVelocity * direction
        object.angularVelocity = minAngularVelocity

    end

    function formattedQuestion(n1, n2, operator)
        return n1 .. " " .. operator .. " " .. n2 .. " = ?"
    end

    initBallAndSplash()
    shootObject("ball")

    function createOtherQuestion()
        local dataQuestion = createQuestion()

        questionToResponse.text = formattedQuestion(dataQuestion.n1, dataQuestion.n2, dataQuestion.simboloOperator)

        questions[0].text = dataQuestion.result + 1
        questions[1].text = dataQuestion.result - 1
        questions[2].text = dataQuestion.result - 2

        local position = math.random(0, 2)
        questions[position].text = dataQuestion.result

        table.insert(listQuestios, dataQuestion);

        colorBallWithResponse = ball[position].color
    end

    createOtherQuestion()

    bombTimer = timer.performWithDelay(bombShootingInterval, function(event) shootObject("bomb") end, 0)
    fruitTimer = timer.performWithDelay(fruitShootingInterval, function(event) shootObject("ball") end, 0)
end

function createQuestion()
    local operator = math.random(1, 4)
    local n1 = math.random(0, 9)
    local n2 = math.random(0, 9)
    local result = 0

    local simboloOperator = operators[operator]
    if (simboloOperator == operatorsSymbol.OPERATOR_DIVISION_) then
        if (n2 == 0) then
            n2 = 1
        elseif (n1 ~= 0 and math.fmod(n1, n2) ~= 0 ) then
            local divisoes = {
                {n1 = 9, n2 = 3},
                {n1 = 8, n2 = 4},
                {n1 = 8, n2 = 2},
                {n1 = 6, n2 = 3},
                {n1 = 6, n2 = 2},
                {n1 = 4, n2 = 2}
            }

            local divisao = math.random(1, #divisoes)
            n1 = divisoes[divisao].n1
            n2 = divisoes[divisao].n2
        end
        result = n1 / n2
    elseif (simboloOperator == operatorsSymbol.OPERATOR_MULTIPLICATION_) then
        result = n1 * n2
    elseif (simboloOperator == operatorsSymbol.OPERATOR_SUBTRACTION_) then
        result = n1 - n2
    elseif (simboloOperator == operatorsSymbol.OPERATOR_SUM_) then
        result = n1 + n2
    end

    return {
        n1 = n1,
        n2 = n2,
        simboloOperator = simboloOperator,
        result = result
    }
end

function drawSlashLine(event)
    if(endPoints ~= nil and endPoints[1] ~= nil) then
        local distance = math.sqrt(math.pow(event.x - endPoints[1].x, 2) + math.pow(event.y - endPoints[1].y, 2))
        if (distance > minDistanceForSlashSound and slashSoundEnabled == true) then
            audio.play(soundCut)
            slashSoundEnabled = false

            timer.performWithDelay(minTimeBetweenSlashes,
                function(event)
                    slashSoundEnabled = true
                end
            )
        end
    end

    table.insert(endPoints, 1, {x = event.x, y = event.y, line= nil})

    if (#endPoints > maxPoints) then
        table.remove(endPoints)
    end

    for i,v in ipairs(endPoints) do
        local line = display.newLine(v.x, v.y, event.x, event.y)
        line.strokeWidth = lineThickness
        transition.to(line, {
            time = lineFadeTime,
            alpha = 0,
            strokeWidth = 0,
            onComplete = function(event)
                line:removeSelf()
            end
        })
    end

    if (event.phase == "ended") then
        while(#endPoints > 0) do
            table.remove(endPoints)
        end
    end
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