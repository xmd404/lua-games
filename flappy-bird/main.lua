push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local ground = love.graphics.newImage('ground.png')

-- load game
function love.load()
  -- remove bluriness on resize
  love.graphics.setDefaultFilter('nearest', 'nearest')
  -- set game title
  love.window.setTitle('Flappy Bird')
  -- init game screen
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })
end

-- dynamic game canvas
function love.resize(w, h)
  push:resize(w, h)
end