-- Pong by @xmd404 (http://xavierduncan.com)
-- init global variables
push = require 'push'
-- set app window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
-- set game window
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
-- set paddle speed
PADDLE_SPEED = 200

-- init game
function love.load()
  -- override default load behaviour:
  -- adjust texture of graphics (vintage but readable)
  love.graphics.setDefaultFilter('nearest', 'nearest')
  -- add font objects
  smallFont = love.graphics.newFont('font.ttf', 8)
  scoreFont = love.graphics.newFont('font.ttf', 32)
  -- set active font to smallFont
  love.graphics.setFont(smallFont)
  -- init virtual resolution
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })
  -- init score
  playerOneScore = 0
  playerTwoScore = 0
  -- init paddle position on Y axis
  playerOnePosition = 30
  playerTwoPosition = VIRTUAL_HEIGHT - 50
end

-- game controls
function love.update(dt)
  -- player One (left)
  if love.keyboard.isDown('w') then
    playerOnePosition = playerOnePosition + -PADDLE_SPEED * dt
  elseif love.keyboard.isDown('s') then
    playerOnePosition = playerOnePosition + PADDLE_SPEED * dt
  end
  -- player Two (right)
  if love.keyboard.isDown('up') then
    playerTwoPosition = playerTwoPosition + -PADDLE_SPEED * dt
  elseif love.keyboard.isDown('down') then
    playerTwoPosition = playerTwoPosition + PADDLE_SPEED * dt
  end
end

-- quit game on 'escape' keypress
function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
end

-- draw 'hello pong' to center of screen
function love.draw()
  -- start virtual animation
  push:apply('start')
  -- -- clear screen with a specific color
  -- love.graphics.clear(40, 45, 52, 255)
  -- draw welcome text top center of screen
  love.graphics.setFont(smallFont)
  love.graphics.printf(
    'Hello Pong',
    0, 
    20,
    VIRTUAL_WIDTH,
    'center'
  )
  -- draw player score left & right center of screen
  love.graphics.setFont(scoreFont)
  love.graphics.print(
    tostring(playerOneScore),
    VIRTUAL_WIDTH / 2 - 50,
    VIRTUAL_HEIGHT / 3
  )
  love.graphics.print(
    tostring(playerTwoScore),
    VIRTUAL_WIDTH / 2 + 30,
    VIRTUAL_HEIGHT / 3
  )
  -- render 1st paddle (left side)
  love.graphics.rectangle('fill', 10, playerOnePosition, 5, 20)
  -- render 2nd paddel (right side)
  love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, playerTwoPosition, 5, 20)
  -- render ball (center)
  love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
  -- end animation
  push:apply('end')
end