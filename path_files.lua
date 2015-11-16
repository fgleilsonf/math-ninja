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
        PATH_IMAGE_BALL_RED_TOP_ = PATH_BASE_IMAGES_.."ball_red_top.png",
        PATH_IMAGE_BALL_RED_BOTTOM_ = PATH_BASE_IMAGES_.."ball_red_bottom.png",
        PATH_IMAGE_BALL_BLUE_ = PATH_BASE_IMAGES_.."blueball.png",
        PATH_IMAGE_BALL_BLUE_TOP_ = PATH_BASE_IMAGES_.."ball_blue_top.png",
        PATH_IMAGE_BALL_BLUE_BOTTOM_ = PATH_BASE_IMAGES_.."ball_blue_bottom.png",
        PATH_IMAGE_BALL_YELLOW_ = PATH_BASE_IMAGES_.."yellowball.png",
        PATH_IMAGE_BALL_YELLOW_TOP_ = PATH_BASE_IMAGES_.."ball_yellow_top.png",
        PATH_IMAGE_BALL_YELLOW_BOTTOM_ = PATH_BASE_IMAGES_.."ball_yellow_bottom.png",
        PATH_IMAGE_LIFE_ = PATH_BASE_IMAGES_.."life.png"
    }
end

function getSounds()
    return {
        PATH_SOUND_SLASH_ = PATH_BASE_SOUNDS_.."slash.wav",
        PATH_SOUND_PRE_EXPLOSION_ = PATH_BASE_SOUNDS_.."preExplosion.wav",
        PATH_SOUND_EXPLOSION_ = PATH_BASE_SOUNDS_.."explosion.wav"
    }
end