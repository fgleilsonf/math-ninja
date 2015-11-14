--
-- Created by Gleilson Ferreira.
-- User: Gleilson Ferreira
-- Date: 05/11/2015
-- Contém as urls da aplicação referente a aúdio e imagem
--

-- IMAGENS

local PATH_BASE_ = "images/"

function getImage()
    return {
        PATH_IMAGE_BALL_RED_ = PATH_BASE_.."ball_red.png",
        PATH_IMAGE_BALL_RED_TOP_ = PATH_BASE_.."ball_red_top.png",
        PATH_IMAGE_BALL_RED_BOTTOM_ = PATH_BASE_.."ball_red_bottom.png",
        PATH_IMAGE_BALL_BLUE_ = PATH_BASE_.."ball_blue.png",
        PATH_IMAGE_BALL_BLUE_TOP_ = PATH_BASE_.."ball_blue_top.png",
        PATH_IMAGE_BALL_BLUE_BOTTOM_ = PATH_BASE_.."ball_blue_bottom.png",
        PATH_IMAGE_BALL_YELLOW_ = PATH_BASE_.."ball_yellow.png",
        PATH_IMAGE_BALL_YELLOW_TOP_ = PATH_BASE_.."ball_yellow.png",
        PATH_IMAGE_BALL_YELLOW_BOTTOM_ = PATH_BASE_.."ball_yellow.png",
        PATH_IMAGE_LIFE_ = PATH_BASE_.."life.png"
    }
end