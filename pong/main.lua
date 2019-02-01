--[[
  Pong by xmd404 (http://xavierduncan.com)
]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[
  init game, override default load behaviour
]]
function love.load()
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })
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