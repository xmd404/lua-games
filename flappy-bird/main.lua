push = require 'push'
Class = require 'class'
require 'Bird'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

local bird = Bird()

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

-- dynamic resizing of game canvas
function love.resize(w, h)
  push:resize(w, h)
end

-- key inputs
function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function love.update(dt)
  backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
    % BACKGROUND_LOOPING_POINT
    -- ground.png is consistent enough to not need a loop point
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
    % VIRTUAL_WIDTH

    bird:update(dt)
end

-- render to screen
function love.draw()
  push:start()
    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    bird:render()
  push:finish()
end
