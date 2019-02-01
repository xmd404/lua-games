--[[
  Pong by xmd404 (http://xavierduncan.com)
]]

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[
  init game
]]
function love.load()
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })
end