local classic = require 'classic'

local Catch, super = classic.class('Catch', Env)

-- Constructor
function Catch:_init(opts)
  opts = opts or {}

  -- Difficulty level
  self.level = opts.level or 2
  self.waysize = 0
  -- Probability of screen flickering
  self.flickering = opts.flickering or 0
  self.flickered = false
  -- Obscured
  self.obscured = opts.obscured or false

  -- Width and height
  self.size = opts.size or 24
  self.screen = torch.Tensor(1, self.size, self.size):zero()
  self.blank = torch.Tensor(1, self.size, self.size):zero()

  -- Player params/state
  self.player = {
    width = opts.playerWidth or self.size / 12
  -- width = 12
  }
  -- Ballarray
  --ballarray = {}
  --self.ball = {}
  
--  for i=1,10 do
    
--  self.ballarray[i] = {}
  
 -- end
 
 
  
 self.ball = {}
 self.ball1 = {}
 self.ball2 = {}
end

-- 1 state returned, of type 'int', of dimensionality 1 x self.size x self.size, between 0 and 1
function Catch:getStateSpec()
  return {'int', {1, self.size, self.size}, {0, 1}}
end

-- 1 action required, of type 'int', of dimensionality 1, between 0 and 3
function Catch:getActionSpec()
  return {'int', 1, {0, 3}}
end

-- RGB screen of size self.size x self.size
function Catch:getDisplaySpec()
  return {'real', {3, self.size, self.size}, {0, 1}}
end

-- Min and max reward
function Catch:getRewardSpec()
  return 0, 1
end

function Catch:getScore()
  usedWay = self.size * self.size - self.waysize
  
end
-- Redraws screen based on state
function Catch:redraw()
  -- Reset screen
  self.screen:zero()
  -- Draw balls
  
 -- for i=1,10 do
    
--  self.screen[{{1}, {self.ballarray[i].y}, {self.ballarray[i].--x}}] = 1
  
--end
if self.player.x >= self.size - self.player.width -3
  then
    self.player.x = self.size - self.player.width -3
    
  elseif self.player.x <=3 then
    self.player.x = 3
    
  elseif self.player.y >= self.size - self.player.width -3
  then
    self.player.y = self.size - self.player.width -3
    
  elseif self.player.y <= 3
  then
    self.player.y = 3
    
  elseif self.player.y <= 3 and self.player.x >= self.size - self.player.width -3 then
    self.player.x = self.size - self.player.width -3
    self.player.y = 3
  
  elseif self.player.y <= 3 and self.player.x <=3 then
    self.player.x = 3
    self.player.y = 3
  
  elseif self.player.y >= self.size - self.player.width -3 and self.player.x <=3 then
    self.player.x = 3
    self.player.y = self.size - self.player.width -3
    
  elseif self.player.y >= self.size - self.player.width -3 and self.player.x >= self.size - self.player.width -3 then
    self.player.x = self.size - self.player.width -3
    self.player.y = self.size - self.player.width -3
  
end


  self.screen[{{1}, {self.ball.y}, {self.ball.x}}] = 1
  self.screen[{{1}, {self.ball1.y}, {self.ball1.x}}] = 1
  self.screen[{{1}, {self.ball2.y}, {self.ball2.x}}] = 1
  
  -- Draw player
  self.screen[{
    {1}, 
    {self.player.y, self.player.y + self.player.width - 1}, 
    {self.player.x, self.player.x + self.player.width - 1} 
    }] = 1
  
  

  -- Obscure screen?
  if self.obscured then
    local barrier = math.ceil(self.size / 4)
    self.screen[{{1}, {self.size-barrier, self.size-1}, {}}] = 0
  end
end

-- Starts new game
function Catch:start()
  stepnumber = 0
  -- Reset player and ball
  self.player.x = self.size/2
  self.player.y = self.size/2
 -- for i=1,10 do 
 -- self.ballarray[i].x = torch.random(self.size)
 -- self.ballarray[i].y = torch.random(self.size)
--end

--create ball objects
  self.ball.x = math.random(4,self.size-4)
  self.ball.y = math.random(4, self.size-4)
  
  self.ball1.x = math.random(4, self.size-4)
  self.ball1.y = math.random(4, self.size-4)
  
  self.ball2.x = math.random(4, self.size-4)
  self.ball2.y = math.random(4, self.size-4)
  
  -- Choose new trajectory
 -- self.ball.gradX = torch.uniform(-1/3, 1/3)*(1 - self.level)
 
  -- Redraw screen
  self:redraw()

  -- Return observation
  return self.screen
end

-- Steps in a game
function Catch:step(action)
  -- Reward is 0 by default
  local reward = 0
  --log.info(action)
  stepnumber = stepnumber +1
  
  if self.player.x >= self.size - self.player.width -1
  then
    self.player.x = self.size - self.player.width -1
    
  elseif self.player.x <= 1 then
    self.player.x = 1
    
  elseif self.player.y >= self.size - self.player.width -1
  then
    self.player.y = self.size - self.player.width -1
    
  elseif self.player.y <= 1
  then
    self.player.y = 1
    
  elseif self.player.y <= 1 and self.player.x >= self.size - self.player.width -1 then
    self.player.x = self.size - self.player.width -1
    self.player.y = 1
  
  elseif self.player.y <= 1 and self.player.x <= 1 then
    self.player.x = 1
    self.player.y = 1
  
  elseif self.player.y >= self.size - self.player.width -1 and self.player.x <= 1 then
    self.player.x = 1
    self.player.y = self.size - self.player.width -1
    
  elseif self.player.y >= self.size - self.player.width - 1 and self.player.x >= self.size - self.player.width -1 then
    self.player.x = self.size - self.player.width -1
    self.player.y = self.size - self.player.width -1
  
end

  -- Move player (0 is no-op)
  if action == 0 then
    self.player.x = self.player.x + 1, 1
  elseif action == 1 then
    self.player.x = self.player.x - 1
    --, self.size -     self.player.width + 1, 1
  elseif action == 2 then
    self.player.y = self.player.y + 1, 1
  elseif action == 3 then
    self.player.y = self.player.y - 1
    --, self.size -     self.player.width + 1, 1
    
  end
  
  if self.player.x >= self.size - self.player.width -1
  then
    self.player.x = self.size - self.player.width -1
    
  elseif self.player.x <= 1 then
    self.player.x = 1
    
  elseif self.player.y >= self.size - self.player.width -1
  then
    self.player.y = self.size - self.player.width -1
    
  elseif self.player.y <= 1
  then
    self.player.y = 1
    
  elseif self.player.y <= 1 and self.player.x >= self.size - self.player.width -1 then
    self.player.x = self.size - self.player.width -1
    self.player.y = 1
  
  elseif self.player.y <= 1 and self.player.x <= 1 then
    self.player.x = 1
    self.player.y = 1
  
  elseif self.player.y >= self.size - self.player.width -1 and self.player.x <= 1 then
    self.player.x = 1
    self.player.y = self.size - self.player.width -1
    
  elseif self.player.y >= self.size - self.player.width - 1 and self.player.x >= self.size - self.player.width -1 then
    self.player.x = self.size - self.player.width -1
    self.player.y = self.size - self.player.width -1
  
end
  
  -- Move ball
 -- self.ball.y = self.ball.y + 1
 -- self.ball.x = self.ball.x + self.ball.gradX
  -- Bounce ball if it hits the side

  -- Check terminal condition
  local terminal = false
  if stepnumber == self.size*self.size then
    reward = 0
    terminal = true
  end 
    
    -- Player wins if it caught ball
    if self.ball.x >= self.player.x and self.ball.x <= self.player.x + self.player.width - 1 and
    self.ball.y >= self.player.y and self.ball.y <= self.player.y + self.player.width - 1
    then
      reward = self.size*self.size -stepnumber
      terminal = true
      
    elseif  self.ball1.x >= self.player.x and self.ball1.x <= self.player.x + self.player.width - 1 and
    self.ball1.y >= self.player.y and self.ball1.y <= self.player.y + self.player.width - 1
    then
      reward = self.size*self.size -stepnumber
      terminal = true
      
    elseif  self.ball2.x >= self.player.x and self.ball2.x  <= self.player.x + self.player.width - 1 and
    self.ball2.y >= self.player.y and self.ball2.y <= self.player.y + self.player.width - 1
    then
      reward = self.size*self.size -stepnumber
      terminal = true
      
    end
  
  -- Redraw screen
  self:redraw()
  
  -- Flickering
  local screen = self.screen
  if math.random() < self.flickering then
    screen = self.blank
    self.flickered = true
  else
    self.flickered = false
  end

  return reward, screen, terminal
end

-- Returns (RGB) display of screen
function Catch:getDisplay()
  if self.flickered then
    return torch.repeatTensor(self.blank, 3, 1, 1)
  else
    return torch.repeatTensor(self.screen, 3, 1, 1)
  end
end

return Catch

