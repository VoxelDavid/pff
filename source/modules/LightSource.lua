--[[
  A robust module used to handle in-game light sources. Candles, fireplaces,
  lamps, you name it!

  Creating your own light source is super easy. Just require the module and
  then it's used almost identically to Instance.new().

    local LightSource = require(game.ServerScriptService.LightSource)

    local light = LightSource.new("Candle", script.Parent)
    light.Range = 20
    light.IgniteSpeed = 1
    light.ExtinguishSpeed = 2
--]]

local LightSource = {
  --
  Active = true,

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
      Range = 14
    },
    Fire = {
      Heat = 20,
      Size = 2
    }
  },

  Fireplace = {
    Light = {
      Color = { 240, 120, 6 },
      Range = 20
    },
    Fire = {
      Heat = 12,
      Size = 7.5
    }
  }
}

--[[
  Create a new light source instance.

  @param String/Table preset
    A string containing the name of a table in Presets, or a table with custom
    preset data.
  @param Instance lightRoot
    The container where a PointLight instance and an optional Fire instance are
    stored.
--]]
function LightSource.new(preset, lightRoot)
  --[[
    Performs checks on the 'preset' parameter that's passed when calling the
    method.

    @return Table/Tuple
      The function will either return a single table or a tuple with two tables.
  --]]
  local function getPresetProperties()
    -- If the preset is a string then do a lookup in the 'Presets' table, if it
    -- doesn't exist throw an error.
    if type(preset) == "string" then
      preset = Presets[preset]

      if not preset then
        error("The preset name passed to LightSource.new() could not be found.")
      end
    end

    --[[
      If a preset contains a Light and Fire instance it requires that two
      tables be used to seperate their individual properties.

      However, if only a Light instance is used, then the properties can be
      placed directly into the preset, omitting the sub-tables.
    --]]
    if not preset.Light and not preset.Fire then
      return preset
    else
      return preset.Light, preset.Fire
    end
  end

  --[[
    Used to take the key/value pairs in the 'properties' argument and override
    the properties with matching names in 'instance'.

    @param Instance instance
      An in-game object whose properties will be matched against the
      'properties' parameter.
    @param Table properties
      A table containing key/value pairs. The key name being the cooresponding
      property found in the instance, and a value to overwrite the property.
  --]]
  local function applyProperties(instance, properties)
    for prop,value in pairs(properties) do
      -- If the key in 'properties' matches a property.
      if instance[prop] then
        --[[
          Special handling for colors.

          Note: 'type(prop)' returns 'userdata' in this case, so it can not be
          used to see if the current property is a Color3 value.
        --]]
        if prop == "Color" or prop == "SecondaryColor" then
          value = rgb(value)
        end

        instance[prop] = value
      end
    end
  end

  local lightProps, fireProps = getPresetProperties()
  local lightInst = Instance.new("PointLight", lightRoot)

  -- Apply the preset's properties to the new light instance
  applyProperties(lightInst, lightProps)

  local newLight = {
    Light = lightInst,
    Range = lightInst.Range,
    Brightness = lightInst.Brightness
  }

  if fireProps then
    local fireInst = Instance.new("Fire", lightRoot)

    -- Apply the preset's properties to the new fire instance
    applyProperties(fireInst, fireProps)

    newLight.Fire = fireInst
  end

  return setmetatable(newLight, LightSource)
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
    self.Active = true
  elseif task == "Decrease" then
    shrink()
    self.Active = false
  else
    error(taskDoesNotExist(task, "ManipulateBrightness"))
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
  else
    error(taskDoesNotExist(task, "ManipulateBrightness"))
  end
end

-- Aliases for the Increase and Decrease tasks
function LightSource:IncreaseBrightness()
  self:ManipulateBrightness("Increase")
end

function LightSource:DecreaseBrightness()
  self:ManipulateBrightness("Decrease")
end

--[[
  Used with the Increase and Decrease methods for the Brightness and Range
  properties.

  A very big thank-you to StackOverflow user Odoth. Without his help I never
  would have gotten the above mentioned methods functioning how I wanted.

  http://stackoverflow.com/q/23554388/2097156
--]]
function timer(startTime, endTime)
  return (tick() - startTime) / (endTime - startTime)
end

--[[
  Allow for use of the RGB format when creating new Color3 values.

  @param Int/Table r
    The "red" value, or a table containing all three, eg. '{ 123, 123, 123 }'
  @param Int g
    The "green" value.
  @param Int b
    The "blue" value.
--]]
function rgb(r, g, b)
  if type(r) == "table" then
    r,g,b = unpack(r)
  end

  return Color3.new(r/255, g/255, b/255)
end

--[[
  Used by ManipulateRange and ManipulateBrightness to throw errors if the
  specified task can't be found.
--]]
function taskDoesNotExist(taskName, methodName)
  return "\""..taskName.."\" is not an applicable task of the "..methodName.." method."
end

return LightSource
