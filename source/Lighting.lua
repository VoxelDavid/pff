--[[
  This script takes care of server-specific lighting tasks.

  The main functionality consists of a time cycle, and creating a 'time of day'
  value for other scripts to hook into.
--]]

local Lighting = {
  -- The amount added on to the current time each loop.
  TimeIncrement = 1.5,

  -- How long the loop will wait() before adding TimeIncrement.
  LoopSpeed = 0
}

--[[
  The primary method that controls what gets applied to the game.
--]]
function Lighting:Init()
  self:GenerateTimeValue()

  while wait(self.LoopSpeed) do
    self:OutputTimeOfDay()
    self:ChangeAmbiance()
    self:TimeCycle()
  end
end

--[[
  Increments a value onto the current time to cycle through the day/night.
--]]
function Lighting:TimeCycle()
  local light = game.Lighting
  local currentTime = light:GetMinutesAfterMidnight()

  light:SetMinutesAfterMidnight(currentTime + self.TimeIncrement)
end

--[[
  Uses variables to denote the times of the day, checks them against the
  current time and returns a string of the time of day.
--]]
function Lighting:GetCurrentTime()
  local currentTime = lighting:GetMinutesAfterMidnight()

  local midnight = 0
  local dawn     = 300
  local morning  = 360
  local midday   = 720
  local evening  = 1050
  local dusk     = 1100

  -- The '>=' operator is needed or else there's a point where no value is true,
  -- causing the script to break.

  if currentTime >= midnight and currentTime < dawn then
    return "midnight"
  elseif currentTime >= dawn and currentTime < morning then
    return "dawn"
  elseif currentTime >= morning and currentTime < midday then
    return "morning"
  elseif currentTime >= midday and currentTime < evening then
    return "midday"
  elseif currentTime >= evening and currentTime < dusk then
    return "evening"
  -- 'midnight' is a smaller value than 'dusk', need to use the 'or' operator.
  elseif currentTime >= dusk or currentTime < midnight then
    return "dusk"
  end
end

--[[
  Changes the map's ambiance according to the values returned by
  GetCurrentTime().
--]]
function Lighting:ChangeAmbiance()
  local currentTime = self:GetCurrentTime()

  local ambient

  if currentTime == "midnight" then
    ambient = rgb(50,50,50)
  elseif currentTime == "dawn" then
    ambient = rgb(80,80,80)
  elseif currentTime == "morning" then
    ambient = rgb(120,120,120)
  elseif currentTime == "midday" then
    ambient = rgb(168,168,168)
  elseif currentTime == "evening" then
    ambient = rgb(120,120,120)
  elseif currentTime == "dusk" then
    ambient = rgb(80,80,80)
  end

  lighting.Ambient = ambient
  lighting.OutdoorAmbient = ambient
end

--[[
  Creates the TimeOfDay value if it doesn't exist, and defines it as a global
  variable for other scripts to hook into.
--]]
function Lighting:GenerateTimeValue()
  if not script:FindFirstChild("TimeOfDay") then
    local timeValue = Instance.new("StringValue", script)
    timeValue.Name = "TimeOfDay"
  end

  _G.TimeOfDay = script.TimeOfDay
end

--[[
  Takes the returned string from GetCurrentTime() and applies it to the TimeOfDay
  value.
--]]
function Lighting:OutputTimeOfDay()
  local timeOfDay = script.TimeOfDay

  -- Only update the time if it's changed.
  if timeOfDay.Value ~= self:GetCurrentTime() then
    timeOfDay.Value = self:GetCurrentTime()
  end
end

-- Run the script
Lighting:Init()
