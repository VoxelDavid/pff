--[[

--]]

-- Constants

local RANGE                 = 12
local IGNITE_SPEED          = 6
local EXTINGUISH_SPEED      = 3

repeat wait() until _G.TimeOfDay
local timeOfDay = _G.TimeOfDay

local LightSource = {}

function LightSource:Init(lightRoot, activeValue, config)
  local light      = lightRoot:FindFirstChild("PointLight")
  local fire       = lightRoot:FindFirstChild("Fire")
  local range      = config.range           or RANGE
  local ignite     = config.igniteSpeed     or IGNITE_SPEED
  local extinguish = config.extinguishSpeed or EXTINGUISH_SPEED

  if not light or not activeValue then
    error("A PointLight and a BoolValue named \"Active\" must exist inside the location passed to the LightSource method.")
  end

  local init = {
    source = light,
    active = activeValue,
    range = range,
    igniteSpeed = ignite,
    extinguishSpeed = extinguish
  }

  if fire then
    init.fire = fire
  end

  return init
end

function LightSource:ToggleActive(lightRoot, activeValue, config)
  local active = activeValue

  if active.Value == true then
    self:TurnOff(lightRoot, activeValue, config)
  else
    self:TurnOn(lightRoot, activeValue, config)
  end

  active.Value = not active.Value
end

function LightSource:TurnOn(lightRoot, activeValue, config)
  local light  = self:Init(lightRoot, activeValue, config)
  local source = light.source
  local fire   = light.fire
  local range  = light.range
  local speed  = light.igniteSpeed

  print("Turn on")

  -- The light source objects are disabled by default, so they need to be
  -- enabled when they're turned on.
  if not source.Enabled then
    source.Enabled = true
  end

  if fire then
   fire.Enabled = true
  end

  while source.Range < range do
    source.Range = source.Range + (range / speed)
    wait()
  end
end

function LightSource:TurnOff(lightRoot, activeValue, config)
  local light  = self:Init(lightRoot, activeValue, config)
  local source = light.source
  local fire   = light.fire
  local range  = light.range
  local speed  = light.extinguishSpeed

  print("Turn off")

  if fire then
   fire.Enabled = false
  end

  while source.Range > 0 do
    source.Range = source.Range - (range / speed)
    wait()
  end
end

return LightSource
