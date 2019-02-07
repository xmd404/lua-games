Bird = Class{}

local GRAVITY = 25
local ANTI_GRAVITY = -5

function Bird:init()
  -- init bird (sprite)
  self.image = love.graphics.newImage('bird.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  -- init bird's position
  self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
  self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
  -- init bird's velocity (dy)
  self.dy = 0
end

function Bird:update(dt)
  -- apply gravity to velocity
  self.dy = self.dy + GRAVITY * dt
  -- input handling for jump
  if love.keyboard.wasPressed('space') then
    self.dy = ANTI_GRAVITY
  end
  -- apply current velocity to Y position
  self.y = self.y + self.dy
end

function Bird:render()
  love.graphics.draw(self.image, self.x, self.y)
end