--[[
  When clicked it will toggle between an off and on state. Editing a PointLight
  and an optional Fire object to create a somewhat realistic effect.
]]

--[[ These are the different variations of light sources and their respective
     properties that exist in the game. They're called by the 'className'
     parameter in toggleLight() ]]

local classes = {
  candle = {
    range = 14,
    igniteSpeed = 6,
    extinguishSpeed = 3
  },
  fireplace = {
    range = 18,
    igniteSpeed = 12,
    extinguishSpeed = 3
  },
  torch = {
    range = 16,
    igniteSpeed = 8,
    extinguishSpeed = 3
  }
}

local class, light, fire

--[[ 'className' is a string of one of the applicable objects in the 'classes' table.
     'lightSource' is the location where a PointLight (and optionally a Fire object)
     is stored (eg. script.Parent). and 'active' is a boolean value in the game. ]]

function toggleLight(className, lightSource, active)
  class = className
  light = lightSource.PointLight
  -- Fire object is optional. Must be included in the same place as the PointLight.
  fire = lightSource:FindFirstChild("Fire")

  if active.Value then
    turnOff()
    active.Value = false
  else
    turnOn()
    active.Value = true
  end
end

function turnOn()
  if fire then
    fire.Enabled = true
  end

  while light.Range < classes[class].range do
    light.Range = light.Range + (classes[class].range / classes[class].igniteSpeed)
    wait()
  end
end

function turnOff()
  if fire then
    fire.Enabled = false
  end

  while light.Range > 0 do
    light.Range = light.Range - (classes[class].range / classes[class].extinguishSpeed)
    wait()
  end
end

return toggleLight
