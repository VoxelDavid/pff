--[[
  A robust module used to handle light sources -- candles, fireplaces, and
  lamps, to name a few.

  Usage example:

    local LightSource = require(game.ServerScriptService.LightSource)

    local light = LightSource.new(script.Parent)
    light.Range = 20
    light.IgniteSpeed = 1
    light.ExtinguishSpeed = 2
--]]

-- Setup the LightSource constructor with default properties.
local LightSource = {
  -- The range of the light when activated.
  Range = 8,

  -- How long (in seconds) it takes for the light source to be activated and
  -- deactivated, respectively.
  IgniteSpeed = .25,
  ExtinguishSpeed = .5,

  -- The value the PointLight's Brightness property will be when night and day.
  Brightness = 1,
  FadedBrightness = .3,

  -- How long (in seconds) it takes for the light source's brightness to be
  -- faded in/out.
  BrightenSpeed = 2,
  DarkenSpeed = 4
}

--[[
  Create a new light source instance.

  @param Instance lightRoot
    The container where a PointLight instance and an optional Fire instance are
    stored.

  @ToDo
    Allow for an optional 'active' param to be passed. When true, turn on the
    newly created light source.
--]]
function LightSource.new(lightRoot)
  -- Light and Fire instances are given unique names so they don't conflict
  -- with instances of the same class. I don't expect that situation, but it's
  -- always good to be flexible.

  local light = Instance.new("PointLight", lightRoot)
  light.Name = "LightSource"
  light.Color = rgb(214, 128, 8)
  light.Range = 16

  -- Generating a Fire instance will be conditional in the future. For the
  -- moment it will always be generated.
  local fire = Instance.new("Fire", lightRoot)
  fire.Name = "FireSource"
  fire.Heat = 20
  fire.Size = 2

  local instance = {
    Light = light,
    Fire = fire,
    Active = true -- The lights are always on by default
  }


  return setmetatable(instance, LightSource)
end
LightSource.__index = LightSource

--[[
  Use the Active value in each instance to toggle the light source on and off,
  using the respective methods.
--]]
function LightSource:ToggleActive()
  if self.Active then
    self:ShrinkRange()
  else
    self:GrowRange()
  end

  self.Active = not self.Active
end

--[[
  Fade in and out the Range property of a Light instance to create a somewhat
  realistic ignite/extinguish effect.
--]]
function LightSource:GrowRange()
  local light = self.Light
  local fire = self.Fire

  if fire then
    fire.Enabled = true
  end

  local startRange = light.Range
  local startTime = tick()
  local endTime = startTime + self.IgniteSpeed

  while self.Range >= light.Range do
    local speed = timer(startTime, endTime)
    local range = startRange - (startRange - self.Range) * speed

    light.Range = range
    wait()
  end

  light.Range = self.Range
end

function LightSource:ShrinkRange()
  local light = self.Light
  local fire = self.Fire

  if fire then
   fire.Enabled = false
  end

  local startRange = light.Range
  local startTime = tick()
  local endTime = startTime + self.ExtinguishSpeed

  -- The values are hard-coded because I don't expect for the light to be
  -- anything but 0 when it's turned off. If there ever comes a point when it
  -- would be something different, it's a very easy task to edit it.

  while 0 < light.Range do
    local speed = timer(startTime, endTime)

    light.Range = startRange - (startRange * speed)
    wait()
  end

  light.Range = self.OffRange
end
end

--[[
  Methods used to increase and decrease the 'Brightness' property of a
  PointLight instance, over a period of time.

  Associated properties:
  - Brightness
  - FadedBrightness
  - BrightenSpeed
  - DarkenSpeed

  A very big thank-you to StackOverflow user Odoth. Without his formula I
  wouldn't have been able to get this functioning.

  http://stackoverflow.com/q/23554388/2097156
--]]
function LightSource:IncreaseBrightness()
  local light = self.Light
  local startBrightness = light.Brightness
  local startTime = tick()
  local endTime = startTime + self.BrightenSpeed

  while light.Brightness <= self.Brightness do
    local speed = timer(startTime, endTime)
    local brightness = startBrightness - (startBrightness - self.Brightness) * speed

    light.Brightness = brightness
    wait()
  end

  -- Set the brightness in case the loop spills over.
  light.Brightness = self.Brightness
end

function LightSource:DecreaseBrightness()
  local light = self.Light
  local startBrightness = light.Brightness
  local startTime = tick()
  local endTime = startTime + self.DarkenSpeed

  while light.Brightness >= self.FadedBrightness do
    local speed = timer(startTime, endTime)
    local brightness = startBrightness - (startBrightness - self.FadedBrightness) * speed

    light.Brightness = brightness
    wait()
  end

  -- Set the brightness in case the loop spills over.
  light.Brightness = self.FadedBrightness
end


function timer(startTime, endTime)
  return (tick() - startTime) / (endTime - startTime)
end

function rgb(r, g, b)
  return Color3.new(r/255, g/255, b/255)
end

return LightSource
