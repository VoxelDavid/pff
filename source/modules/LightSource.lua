--[[
  A robust module used to handle light sources -- candles, fireplaces, and
  lamps, to name a few.

  Usage example:

    local LightSource = require(game.ServerScriptService.LightSource)

    local light = LightSource.new(script.Parent)
    light.Range = 20
    light.IgniteSpeed = 5
    light.ExtinguishSpeed = 10
--]]

-- Setup the LightSource constructor with default properties.
local LightSource = {
  -- The range of the light when activated.
  Range = 8,

  -- How quickly the light will be activated and deactivated, respectively. The
  -- lower the value, the quicker the transition.
  IgniteSpeed = 5,
  ExtinguishSpeed = 12
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
  local light  = lightRoot:FindFirstChild("PointLight")
  local fire   = lightRoot:FindFirstChild("Fire")

  if not light then
    -- Throw an error, giving a helpful stack trace to find which light source
    -- is missing its PointLight object.
    error("A PointLight must exist inside of the first parameter passed to Lightsource.new()")
  end

  local instance = {
    Light = light,
    Active = false -- The lights are always off by default
  }

  if fire then
    instance.Fire = fire
  end

  return setmetatable(instance, LightSource)
end
LightSource.__index = LightSource

--[[
  Use the Active value in each instance to toggle the light source on and off,
  using the respective methods.
--]]
function LightSource:ToggleActive()
  if self.Active then
    self:TurnOff()
  else
    self:TurnOn()
  end

  self.Active = not self.Active
end

--[[
  Fade in the Range property of a PointLight object to create a somewhat
  realistic ignite effect.

  All PointLights are disabled by default, so there is also a conditional
  statement to enable them when first run.
--]]
function LightSource:TurnOn()
  local light = self.Light
  local fire = self.Fire

  -- The light source objects are disabled by default, so they need to be
  -- enabled when they're turned on.
  if not light.Enabled then
    light.Enabled = true
  end

  if fire then
    fire.Enabled = true
  end

  while light.Range < self.Range do
    -- Divide the desired range by the ignition speed to get a number that will
    -- always end at the correct range.
    light.Range = light.Range + (self.Range / self.IgniteSpeed)
    wait()
  end
end

--[[
  Fade out the Range property of a PointLight object to create a somewhat
  realistic extinguish effect.
--]]
function LightSource:TurnOff()
  local light = self.Light
  local fire = self.Fire

  if fire then
   fire.Enabled = false
  end

  while light.Range > 0 do
    -- Divide the current range by the extinguish speed to get a number that will
    -- always end at the correct range.
    light.Range = light.Range - (self.Range / self.ExtinguishSpeed)
    wait()
  end
end

return LightSource
