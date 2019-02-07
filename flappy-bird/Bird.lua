Bird = Class{}

local GRAVITY = 25

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
  self.dy = self.dy + GRAVITY * dt
  self.y = self.y + self.dy
end

function Bird:render()
  love.graphics.draw(self.image, self.x, self.y)
end