--[[
  Pong by @xmd404 (http://xavierduncan.com)
]]

push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

--[[
  init game, override default load behaviour
]]
function love.load()
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })
end

--[[
  quit game on 'escape' keypress
]]
function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

--[[
  draw 'hello pong' to center of screen
]]
function love.draw()
  love.graphics.printf(
    'Hello Pong',
    0,
    WINDOW_HEIGHT / 2 - 6,
    WINDOW_WIDTH,
    'center'
  )
end