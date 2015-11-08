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
        PATH_IMAGE_BALL_BLUE_ = PATH_BASE_.."ball_blue.png",
        PATH_IMAGE_BALL_GREEN_ = PATH_BASE_.."ball_green.png",
        PATH_IMAGE_LIFE_ = PATH_BASE_.."life.png"
    }
end