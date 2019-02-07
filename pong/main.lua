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
  -- set game title
  love.window.setTitle('Pong2D')
  -- override default load behaviour:
  -- adjust texture of graphics (vintage but readable)
  love.graphics.setDefaultFilter('nearest', 'nearest')
  -- seed random number generator to current time
  -- this guarantees that calls to random are truly random :)
  math.randomseed(os.time())
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
  -- init player score
  p1Score = 0
  p2Score = 0
  -- init player position on Y axis
  p1Position = 30
  p2Position = VIRTUAL_HEIGHT - 50
  -- init velocity & position for ball on start
  ballX = VIRTUAL_WIDTH / 2 - 2
  ballY = VIRTUAL_HEIGHT / 2 -3
  -- randomize direction of ball between left and right number
  ballDX = math.random(2) == 1 and 100 or -100
  ballDY = math.random(-50, 50)
  -- init game state
  gameState = 'start'
end

-- game controls
-- max/min functions keep paddles within screen
function love.update(dt)
  -- p1 (left)
  if love.keyboard.isDown('w') then
    p1Position = math.max(0, p1Position + -PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('s') then
    p1Position = math.min(VIRTUAL_HEIGHT - 20, p1Position + PADDLE_SPEED * dt)
  end
  -- p2 (right)
  if love.keyboard.isDown('up') then
    p2Position = math.max(0, p2Position + -PADDLE_SPEED * dt)
  elseif love.keyboard.isDown('down') then
    p2Position = math.min(VIRTUAL_HEIGHT - 20, p2Position + PADDLE_SPEED * dt)
  end
  -- update ball position if we're in 'play' state
  if gameState == 'play' then
    ballX = ballX + ballDX * dt
    ballY = ballY + ballDY * dt
  end
end

-- quit game on 'escape' keypress
function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  elseif key == 'enter' or key == 'return' then
    if gameState == 'start' then
      gameState = 'play'
    else
      gameState = 'start'
      -- init velocity & position for ball on start
      ballX = VIRTUAL_WIDTH / 2 - 2
      ballY = VIRTUAL_HEIGHT / 2 -3
      -- randomize direction of ball between left and right number
      ballDX = math.random(2) == 1 and 100 or -100
      ballDY = math.random(-50, 50) * 1.5
    end
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
    tostring(p1Score),
    VIRTUAL_WIDTH / 2 - 50,
    VIRTUAL_HEIGHT / 3
  )
  love.graphics.print(
    tostring(p2Score),
    VIRTUAL_WIDTH / 2 + 30,
    VIRTUAL_HEIGHT / 3
  )
  -- render 1st paddle (left side)
  love.graphics.rectangle('fill', 10, p1Position, 5, 20)
  -- render 2nd paddel (right side)
  love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, p2Position, 5, 20)
  -- render ball (center)
  love.graphics.rectangle('fill', ballX, ballY, 4, 4)
  -- display FPS
  displayFPS()
  -- end animation
  push:apply('end')
end

-- renders current FPS in top left corner
function displayFPS()
  love.graphics.setFont(smallFont)
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end