--[[
  A robust module used to handle in-game light sources. Candles, fireplaces,
  lamps, you name it!

  Usage example:

    local LightSource = require(game.ServerScriptService.LightSource)

    local light = LightSource.new("Candle", script.Parent)
    light.Range = 20
    light.IgniteSpeed = 1
    light.ExtinguishSpeed = 2
--]]

-- Setup the LightSource constructor with default properties.
local LightSource = {
  -- The range of the light when activated.
  Range = 16,

  -- The value the PointLight's Brightness property will be when night and day,
  -- respectively.
  Brightness = 1,
  FadedBrightness = .3,

  -- How long (in seconds) it takes for the light source to be activated and
  -- deactivated.
  IgniteSpeed = .25,
  ExtinguishSpeed = .5,

  -- How long (in seconds) it takes for the light source's brightness to be
  -- faded in/out.
  BrightenSpeed = 2,
  DarkenSpeed = 4
}

--[[
  Presets are an easy way to tweak how the Light instances (and optionally
  Fire instances) will appear in-game.

  Any property a light or fire instance has can be used in the preset. The
  only thing you need to keep in mind is Color3 values are written with Table
  constructors, eg.

    { 123, 123, 123 }

  These settings are only applied when first generating instances. They are
  not used anywhere but the 'new' function.
--]]
local Presets = {
  Candle = {
    Light = {
      Color = { 214, 128, 8 },
      Range = 14,
      Brightness = .5
    },
    Fire = {
      Heat = 20,
      Size = 2
    }
  }
}

--[[
  Create a new light source instance.

  @param String/Table preset
    A string containing the name of a table in LightSource.Presets, or a table
    with custom preset data.
  @param Instance lightRoot
    The container where a PointLight instance and an optional Fire instance are
    stored.
--]]
function LightSource.new(preset, lightRoot)
  local self = LightSource

  --[[
    Used to check if the Preset argument is a String (existing preset),
    or a Table (custom preset).
  --]]
  local function checkPreset()
    if type(preset) == "string" then
      local chosenPreset = Presets[preset]

      if not chosenPreset then
        return warn("The preset name passed to LightSource.new() could not be found.")
      end

      return chosenPreset
    elseif type(preset) == "table" then
      -- Run checks on the custom preset and error if anything is missing.
    end
  end

  --[[
    Used to take the key/value pairs in the 'properties' argument and override
    the properties with matching names in 'instance'.
  --]]
  local function applyProperties(instance, properties)
    for prop,value in pairs(properties) do
      -- If the key in 'properties' matches a property instance.
      if instance[prop] then
        --[[
          Special handling for colors.

          Note: 'type(prop)' returns 'userdata' in this case, so it can not be
          used to see if the current property is a Color3 value.
        --]]
        if prop == "Color" or prop == "SecondaryColor" then
          value = rgb(unpack(value))
        end

        instance[prop] = value
      end
    end
  end

  preset = checkPreset()

  local lightInst = Instance.new("PointLight", lightRoot)
  lightInst.Name = "LightSource"

  local fireInst

  local lightProps = preset.Light
  local fireProps = preset.Fire

  local instance = {
    Light = lightInst,
    Active = true -- The lights are always on by default
  }

  if fireProps then
    fireInst = Instance.new("Fire", lightRoot)
    fireInst.Name = "FireSource"

    applyProperties(fireInst, fireProps)

    instance.Fire = fireInst
  end

  applyProperties(lightInst, lightProps)

  return setmetatable(instance, LightSource)
end
LightSource.__index = LightSource

--[[
  Use the Active value in each instance to toggle the light source on and off,
  using the respective methods.
--]]
function LightSource:ToggleActive()
  if self.Active then
    self:DecreaseRange()
  else
    self:IncreaseRange()
  end

  self.Active = not self.Active
end

--[[
  Fade in and out the Range property of a Light instance to create a somewhat
  realistic ignite/extinguish effect.
--]]
function LightSource:ManipulateRange(task)
  local light = self.Light
  local fire = self.Fire
  local startRange = light.Range
  local startTime = tick()


  local function grow()
    local endTime = startTime + self.IgniteSpeed

    if fire then
      fire.Enabled = true
    end

    while self.Range >= light.Range do
      local speed = timer(startTime, endTime)
      local range = startRange - (startRange - self.Range) * speed

      light.Range = range
      wait()
    end

    light.Range = self.Range
  end

  local function shrink()
    local endTime = startTime + self.ExtinguishSpeed

    if fire then
      fire.Enabled = false
    end

    -- The values are hard-coded because I don't expect for the light to be
    -- anything other than 0 when it's turned off.

    while 0 < light.Range do
      local speed = timer(startTime, endTime)

      light.Range = startRange - (startRange * speed)
      wait()
    end

    light.Range = 0
  end

  if task == "Increase" then
    grow()
  elseif task == "Decrease" then
    shrink()
  else
    return error("\""..task.."\" is not an applicable task of the ManipulateRange method.")
  end
end

-- Aliases for the Increase and Decrease tasks.
function LightSource:IncreaseRange()
  self:ManipulateRange("Increase")
end

function LightSource:DecreaseRange()
  self:ManipulateRange("Decrease")
end

--[[
  Used to increase and decrease the 'Brightness' property of a PointLight
  instance over a period of time.

  A very big thank-you to StackOverflow user Odoth. Without his formula I
  wouldn't have been able to get this functioning.

  http://stackoverflow.com/q/23554388/2097156
--]]
function LightSource:ManipulateBrightness(task)
  local light = self.Light
  local startBrightness = light.Brightness
  local startTime = tick()

  local function increase()
    local endTime = startTime + self.BrightenSpeed

    while light.Brightness <= self.Brightness do
      local speed = timer(startTime, endTime)
      local brightness = startBrightness - (startBrightness - self.Brightness) * speed

      light.Brightness = brightness
      wait()
    end

    light.Brightness = self.Brightness
  end

  local function decrease()
    local endTime = startTime + self.DarkenSpeed

    while light.Brightness >= self.FadedBrightness do
      local speed = timer(startTime, endTime)
      local brightness = startBrightness - (startBrightness - self.FadedBrightness) * speed

      light.Brightness = brightness
      wait()
    end

    light.Brightness = self.FadedBrightness
  end

  if task == "Increase" then
    increase()
  elseif task == "Decrease" then
    decrease()
  end
end

-- Aliases for the Increase and Decrease tasks
function LightSource:IncreaseBrightness()
  self:ManipulateBrightness("Increase")
end

function LightSource:DecreaseBrightness()
  self:ManipulateBrightness("Decrease")
end


function timer(startTime, endTime)
  return (tick() - startTime) / (endTime - startTime)
end

-- Allow for use or the RGB format when creating new Color3 values.
function rgb(r, g, b)
  return Color3.new(r/255, g/255, b/255)
end

-- Make use of the TestService to output warning messages to the console.
function warn(message, condition)
  local TestService = game:GetService("TestService")
  TestService:Warn(condition or false, message)
end

return LightSource
