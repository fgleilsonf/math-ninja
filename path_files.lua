--
-- Created by Gleilson Ferreira.
-- User: Gleilson Ferreira
-- Date: 05/11/2015
-- Contém as urls da aplicação referente a aúdio e imagem
--

-- IMAGENS e AUDIOS

local PATH_BASE_IMAGES_= "images/"
local PATH_BASE_SOUNDS_ = "sounds/"

function getImage()
    return {
        PATH_IMAGE_CIRCLE_ = PATH_BASE_IMAGES_.."circle.png",
        PATH_IMAGE_BALL_RED_ = PATH_BASE_IMAGES_.."redball.png",
        PATH_IMAGE_BALL_RED_TOP_ = PATH_BASE_IMAGES_.."redball_top.png",
        PATH_IMAGE_BALL_RED_BOTTOM_ = PATH_BASE_IMAGES_.."redball_bottom.png",
        PATH_IMAGE_BALL_BLUE_ = PATH_BASE_IMAGES_.."blueball.png",
        PATH_IMAGE_BALL_BLUE_TOP_ = PATH_BASE_IMAGES_.."blueball_top.png",
        PATH_IMAGE_BALL_BLUE_BOTTOM_ = PATH_BASE_IMAGES_.."blueball_bottom.png",
        PATH_IMAGE_BALL_YELLOW_ = PATH_BASE_IMAGES_.."yellowball.png",
        PATH_IMAGE_BALL_YELLOW_TOP_ = PATH_BASE_IMAGES_.."yellowball_top.png",
        PATH_IMAGE_BALL_YELLOW_BOTTOM_ = PATH_BASE_IMAGES_.."yellowball_bottom.png",
        PATH_IMAGE_LIFE_ = PATH_BASE_IMAGES_.."life.png",
        PATH_IMAGE_BACKGROUND_ = PATH_BASE_IMAGES_.."lousa.png",
        PATH_IMAGE_BACK_ = PATH_BASE_IMAGES_.."back.png",
        PATH_IMAGE_LOGO_ = PATH_BASE_IMAGES_.."mathninjalogo.png",
        PATH_IMAGE_CREDITS_ = PATH_BASE_IMAGES_.."creditos.png",
        PATH_IMAGE_TUTORIAL_ = PATH_BASE_IMAGES_.."tutorial.png",
        PATH_IMAGE_PROXIMO_ = PATH_BASE_IMAGES_.."proximo.png",
        PATH_IMAGE_PULAR_ = PATH_BASE_IMAGES_.."pular.png",
        PATH_IMAGE_JOGAR_ = PATH_BASE_IMAGES_.."jogar.png",
        PATH_IMAGE_GAMEOVER_ = PATH_BASE_IMAGES_.."gameover.png",
        PATH_IMAGE_JOGAR_NOVAMENTE_ = PATH_BASE_IMAGES_.."playagain.png",
        PATH_IMAGE_SCORES_ = PATH_BASE_IMAGES_.."scores.png"
    }
end

function getSounds()
    return {
        PATH_SOUND_SLASH_ = PATH_BASE_SOUNDS_.."slash.wav",
        PATH_SOUND_PRE_EXPLOSION_ = PATH_BASE_SOUNDS_.."preExplosion.wav",
        PATH_SOUND_EXPLOSION_ = PATH_BASE_SOUNDS_.."explosion.wav"
    }
end