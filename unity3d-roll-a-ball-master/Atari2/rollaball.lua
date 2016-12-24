local classic = require 'classic'
require 'image'

local Catch, super = classic.class('Catch', Env)

-- Constructor
function Catch:_init(opts)
  opts = opts or {}

  self.level = opts.level or 2
  -- Width and height
  self.size = opts.size or 20
  self.screen = torch.FloatTensor(3, self.size, self.size):zero()
  self.blank = torch.FloatTensor(3, self.size, self.size):zero()

end

-- 1 state returned, of type 'int', of dimensionality 1 x self.size x self.size, between 0 and 1
function Catch:getStateSpec()
  return {'int', {3, self.size, self.size}, {0, 1}}
end

-- 1 action required, of type 'int', of dimensionality 1, between 0 and 2
function Catch:getActionSpec()
  return {'int', 1, {1, 5}}
end

-- RGB screen of size self.size x self.size
function Catch:getDisplaySpec()
  return {'real', {3, self.size, self.size}, {0, 1}}
end

-- Min and max reward
function Catch:getRewardSpec()
  return 0, 12
end

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

-- Redraws screen based on state
function Catch:redraw()
  -- Reset screen
 self.screen:zero()

while file_exists('/media/daniel/BigNeuronalNetwo/NewTests/unity3d-roll-a-ball-master/sem1.txt') == true do

--local fin = torch.DiskFile('/home/daniel/unity3d-roll-a-ball-master/SavedScreen.jpg', 'r')
--fin:binary()
--fin:seekEnd()
--local file_size_bytes = fin:position() - 1
--fin:seek(1)
--local img_binary = torch.ByteTensor(file_size_bytes)
--fin:readByte(img_binary:storage())
--fin:close()
-- Then when you're ready to decompress the ByteTensor:
--img = image.decompressJPG(img_binary)

end

--open semaphore
file = io.open('/media/daniel/BigNeuronalNetwo/NewTests/unity3d-roll-a-ball-master/sem2.txt','w')
file:close()

img = image.load('/media/daniel/BigNeuronalNetwo/NewTests/unity3d-roll-a-ball-master/SavedScreen.jpg',3,'float')

os.remove('/media/daniel/BigNeuronalNetwo/NewTests/unity3d-roll-a-ball-master/sem2.txt')


--img = image.load('/home/daniel/unity3d-roll-a-ball-master/SavedScreen.jpg',3,'float')

--log.info(img)  

--image.display(img)
self.screen =img

end

-- Starts new game
function Catch:start()
stepnumber = 0

  scorefile = io.open("/media/daniel/BigNeuronalNetwo/NewTests/unity3d-roll-a-ball-master/score.txt", "w")
  scorefile:write(0)
  scorefile:close()

  -- Redraw screen
  self:redraw()
  --log.info('test')

  -- Return observation
  return self.screen
end

-- Steps in a game
function Catch:step(action)
local reward = 0
stepnumber = stepnumber +1

while file_exists('/media/daniel/BigNeuronalNetwo/NewTests/unity3d-roll-a-ball-master/unitySWSem.txt') == true do
end

file = io.open('/media/daniel/BigNeuronalNetwo/NewTests/unity3d-roll-a-ball-master/networkSWSem.txt','w')
file:close()

  -- Reward is 0 by default
	file = io.open("action.txt", "w")
	file:write(action)
	file:close()

	scorefile = io.open("/media/daniel/BigNeuronalNetwo/NewTests/unity3d-roll-a-ball-master/score.txt", "r")
	scorefromfile = scorefile:read()
	scorefile:close()
	
	file = io.open("stepnumber.txt", "w")
	file:write(stepnumber)
	file:close()

	scoreint = tonumber(scorefromfile)

	--log.info(scoreint)
	--reward = 10000 - stepnumber
	--log.info(scoreint)

os.remove('/media/daniel/BigNeuronalNetwo/NewTests/unity3d-roll-a-ball-master/networkSWSem.txt')

-- Check terminal condition
--reward = scoreint
--log.info(reward)

local terminal = false
if scoreint == 12 then
reward = 12
terminal = true
end

if stepnumber == 10000 then 
reward = scoreint
--slog.info(reward)
terminal = true
end

--log.info(reward)

  -- Redraw screen
  self:redraw()
  local screen = self.screen

  return reward, screen, terminal
end

-- Returns (RGB) display of screen
function Catch:getDisplay()
    return torch.repeatTensor(self.screen, 1, 1, 1)
end

return Catch

