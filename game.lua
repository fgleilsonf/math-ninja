
require ( "physics" )
require( "setup" )
require( "constants" )
require( "cache" )
require( "path_files" )

local ui = require( "ui" )
local composer = require( "composer" )
local scene = composer.newScene()

physics.start()
physics.setGravity( 0, 9.8 * 2)
physics.start()

local images = getImage()
local sounds = getSounds()

local QUESTION_ABOUT_ROOT_SQUARE = 1
local QUESTION_ABOUT_OPERATIONS_4 = 2
local QUESTION_ABOUT_NUMBER_SQUARE = 3
local QUESTION_ABOUT_FATORIAL = 4

local themeFromQuestio = 0
local scores = 0

local endPoints = {}
local maxPoints = 5
local lineThickness = 20
local lineFadeTime = 250

local slashSoundEnabled = true -- sound should be enabled by default on startup
local minTimeBetweenSlashes = 150 -- Minimum amount of time in between each slash sound
local minDistanceForSlashSound = 50 -- Amount of pixels the users finger needs to travel in one frame in order to play a slash sound

local soundCut = audio.loadSound(sounds.PATH_SOUND_SLASH_)
local preExplosion = audio.loadSound(sounds.PATH_SOUND_PRE_EXPLOSION_)
local explosion = audio.loadSound(sounds.PATH_SOUND_EXPLOSION_)

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
local ballTimer
local responseTimer

local timeRemainingToRespond = 10
local ballShootingInterval = 1000
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

    local background = setupBackground("images/lousa.png");
    sceneGroup:insert(background)

    themeFromQuestio = composer.getVariable( "operation" )

    local ball = {}
    local lifes = {}
    local questions = {}
    local countLife = 3

    function initQuestions()
        local LEFT_BALL_ = 170

        questions[0] = display.newText("?",  LEFT_BALL_, ball[0].y, native.systemFontBold, 40)
        questions[1] = display.newText("?",  LEFT_BALL_, ball[1].y, native.systemFontBold, 40)
        questions[2] = display.newText("?",  LEFT_BALL_, ball[2].y, native.systemFontBold, 40)

        sceneGroup:insert(questions[0])
        sceneGroup:insert(questions[1])
        sceneGroup:insert(questions[2])
    end

    function initLife()
        local y = 170
        lifes[1] = display.newImage(images.PATH_IMAGE_LIFE_, display.contentWidth  - 100, y)
        lifes[2] = display.newImage(images.PATH_IMAGE_LIFE_, display.contentWidth  - 170, y)
        lifes[3] = display.newImage(images.PATH_IMAGE_LIFE_, display.contentWidth  - 240, y)

        sceneGroup:insert(lifes[1])
        sceneGroup:insert(lifes[2])
        sceneGroup:insert(lifes[3])
    end

    function initBall()
        local width = 70
        local height = 70
        local left = 100

        ball[0] = display.newImage(images.PATH_IMAGE_BALL_RED_, left, 270)
        ball[0].width = width
        ball[0].height = height
        ball[0].color = "red"

        ball[1] = display.newImage(images.PATH_IMAGE_BALL_BLUE_, left, 350)
        ball[1].width = width
        ball[1].height = height
        ball[1].color = "blue"

        ball[2] = display.newImage(images.PATH_IMAGE_BALL_YELLOW_, left, 430)
        ball[2].width = width
        ball[2].height = height
        ball[2].color = "yellow"

        sceneGroup:insert(ball[0])
        sceneGroup:insert(ball[1])
        sceneGroup:insert(ball[2])
    end

    initBall()
    initLife()
    initQuestions()

    local questionToResponse = display.newText(" ? = ?",  150, 170, native.systemFontBold, 50)
    questionToResponse:setTextColor(255, 255, 255)
    sceneGroup:insert(questionToResponse)

    local alarm = display.newImage("images/alarm_clock.png", display.contentWidth * 0.45, 170)
    alarm.width = 80
    alarm.height = 100
    sceneGroup:insert(alarm)

    local timerTextQuestion = display.newText("10",  display.contentWidth * 0.52, 170, native.systemFontBold, 50)
    sceneGroup:insert(timerTextQuestion)

    Runtime:addEventListener("touch", drawSlashLine)

    function initBallAndSplash()
        local ballRed = {
            whole = images.PATH_IMAGE_BALL_RED_,
            top = images.PATH_IMAGE_BALL_RED_TOP_,
            bottom = images.PATH_IMAGE_BALL_RED_BOTTOM_,
            color = "red"
        }

        local ballBlue = {
            whole = images.PATH_IMAGE_BALL_BLUE_,
            top = images.PATH_IMAGE_BALL_BLUE_TOP_,
            bottom = images.PATH_IMAGE_BALL_BLUE_BOTTOM_,
            color = "blue"
        }

        local ballYellow = {
            whole = images.PATH_IMAGE_BALL_YELLOW_,
            top = images.PATH_IMAGE_BALL_YELLOW_TOP_,
            bottom = images.PATH_IMAGE_BALL_YELLOW_BOTTOM_,
            color = "yellow"
        }

        table.insert(avalBall, ballRed)
        table.insert(avalBall, ballBlue)
        table.insert(avalBall, ballYellow)
    end

    function createBallPiece(ball, section)

        local ballVelX, ballVelY = ball:getLinearVelocity()

        local half = display.newImage(ball[section])
        half.x = ball.x - ball.x
        local yOffSet = section == "top" and -half.height / 2 or half.height / 2
        half.y = ball.y + yOffSet - ball.y

        local newPoint = {}
        newPoint.x = half.x * math.cos(ball.rotation * (math.pi /  180)) - half.y * math.sin(ball.rotation * (math.pi /  180))
        newPoint.y = half.x * math.sin(ball.rotation * (math.pi /  180)) + half.y * math.cos(ball.rotation * (math.pi /  180))

        half.x = newPoint.x + ball.x
        half.y = newPoint.y + ball.y

        half.width = 120
        half.height = 60

        sceneGroup:insert(half)

        half.rotation = ball.rotation
        ballProp.radius = half.width / 2
        physics.addBody(half, "dynamic", ballProp)

        local velocity  = math.sqrt(math.pow(ballVelX, 2) + math.pow(ballVelY, 2))
        local xDirection = section == "top" and -1 or 1
        local velocityX = math.cos((ball.rotation + 90) * (math.pi /  180)) * velocity * xDirection
        local velocityY = math.sin((ball.rotation + 90) * (math.pi /  180)) * velocity
        half:setLinearVelocity(velocityX,  velocityY)

        local minAngularVelocity = getRandomValue(minAngularVelocityChopped, maxAngularVelocityChopped)
        local direction = (math.random() < .5) and -1 or 1
        half.angularVelocity = minAngularVelocity * direction
    end

    function gameOver ()
        local pontuacao = tonumber ( getPontuacao() )
        if (scores > pontuacao) then
            setPontuacao(scores)
        end

        timer.cancel(responseTimer)
        timer.cancel(ballTimer)
        timer.cancel(bombTimer)

        composer.setVariable( "scores", scores )
        composer.removeScene( "game" )
        composer.gotoScene( "gameover" )
    end

    function loseLife()
        lifes[countLife].fill.effect = "filter.monotone"
        lifes[countLife].fill.effect.r = 0.5
        lifes[countLife].fill.effect.g = 0.1
        lifes[countLife].fill.effect.b = 0.2
        lifes[countLife].fill.effect.a = 1

        countLife = countLife - 1

        if (countLife == 0) then
            gameOver()
        end
    end

    function chopBall(ball)
        if (colorBallWithResponse == ball.color) then
            scores = scores + 1
            createOtherQuestion()
        else
            loseLife()
        end

        createBallPiece(ball, "top")
        createBallPiece(ball, "bottom")

        ball:removeSelf()
    end

    function getRandomValue(min, max)
        return min + math.abs(((max - min) * math.random()))
    end

    function getRandomBall()
        local ballProp = avalBall[math.random(1, #avalBall)]
        local ball = display.newImage(ballProp.whole)
        ball.width = 90
        ball.height = 90
        ball.whole = ballProp.whole
        ball.top = ballProp.top
        ball.bottom = ballProp.bottom
        ball.color = ballProp.color

        return ball
    end

    function getBomb()
        local bomb = display.newImage( "images/bomb.png")
        bomb.width = 140
        bomb.height = 140
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
                onComplete=gameOver()
            });
        end

        circle.alpha = 0
        transition.to(circle, {
            time=circleGrowthTime,
            alpha = 1,
            width = display.contentWidth * 3,
            height = display.contentWidth * 3,
            onComplete = dissolve
        })

        system.vibrate()

        bomb:removeSelf()
        linesGroup:removeSelf()
    end

    function explodeBomb(bomb, listener)

        bomb:removeEventListener("touch", listener)

        bomb.bodyType = "kinematic"
        bomb:setLinearVelocity(0,  0)
        bomb.angularVelocity = 0

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

        local drawLine = function(event)
            local line = display.newLine(bomb.x, bomb.y, display.contentWidth * 2, display.contentHeight * 2)
            line.rotation = math.random(1,360)
            line.strokeWidth = math.random(15, 25)
            linesGroup:insert(line)
        end

        local lineTimer = timer.performWithDelay(100, drawLine, 0)

        local explode = function(event)
            audio.play(explosion)
            blankOutScreen(bomb, linesGroup);
            timer.cancel(lineTimer)
            stage.x = 0
            stage.y = 0
            transition.cancel(leftTrans)
            transition.cancel(rightTrans)
        end

        audio.play(preExplosion, {onComplete = explode})

        timer.cancel(ballTimer)
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

    initBallAndSplash()
    shootObject("ball")

    function createOtherQuestion()
        local dataQuestion = createQuestion()

        questions[0].text = dataQuestion.result + 1
        questions[1].text = dataQuestion.result - 1
        questions[2].text = dataQuestion.result - 2

        local position = math.random(0, 2)
        questions[position].text = dataQuestion.result
        table.insert(listQuestios, dataQuestion)

        questionToResponse.text = dataQuestion.question
        colorBallWithResponse = ball[position].color

        timeRemainingToRespond = 10
        timerTextQuestion.text = timeRemainingToRespond

        if (responseTimer) then
            timer.cancel(responseTimer)
        end
        responseTimer = timer.performWithDelay(1000, startTimeRemainingToRespond, 0)

        local size = string.len(questions[0].text)
        local sizeX = 170

        if (size > 5) then
            sizeX = size * 20 + 80
        elseif (size == 3) then
            sizeX = 180
        elseif (size == 4) then
            sizeX = 190
        elseif (size == 5) then
            sizeX = 200
        end

        questions[0].x = sizeX
        questions[1].x = sizeX
        questions[2].x = sizeX
    end

    function startTimeRemainingToRespond()
        timeRemainingToRespond = timeRemainingToRespond - 1
        timerTextQuestion.text = timeRemainingToRespond

        if (timeRemainingToRespond == 0) then
            timer.cancel(responseTimer)
            loseLife()

            if (countLife > 0) then
               createOtherQuestion()
            end
        end
    end

    createOtherQuestion()

    bombTimer = timer.performWithDelay(bombShootingInterval, function(event) shootObject("bomb") end, 0)
    ballTimer = timer.performWithDelay(ballShootingInterval, function(event) shootObject("ball") end, 0)
end

function createQuestion()
    if (themeFromQuestio == QUESTION_ABOUT_ROOT_SQUARE) then
        local n1 = math.random(0, 20)

        return {
            question = "Raiz ".. (n1 * n1) .. " = ?",
            result = n1
        }
    elseif (themeFromQuestio == QUESTION_ABOUT_OPERATIONS_4) then
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
            question = n1 .. " " .. simboloOperator .. " " .. n2 .. " = ?",
            simboloOperator = simboloOperator,
            result = result
        }
    elseif (themeFromQuestio == QUESTION_ABOUT_NUMBER_SQUARE) then
        local n1 = math.random(0, 20)

        return {
            question = n1.."² = ?",
            result =  (n1 * n1),
        }
    elseif (themeFromQuestio == QUESTION_ABOUT_FATORIAL) then
        local n1 = math.random(0, 11)

        function fat(n)
            if n == 0 then
                return 1
            else
                return n * fat(n - 1)
            end
        end

        return {
            question = n1.."! = ?",
            result =  fat(n1),
        }
    end
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

function scene:show( ) end
function scene:hide( ) end
function scene:destroy( ) end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene