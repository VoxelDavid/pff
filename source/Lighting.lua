--[[
  This script takes care of server-specific lighting tasks.

  The main functionality consists of a time cycle, and creating a 'time of day'
  value for other scripts to hook into.
--]]

local timeIncrement = 1.5 -- The amount added on to the current time every recurrence.
local loopSpeed = 0       -- How long the loop will wait() before adding timeIncrement.

local lighting = game.Lighting

--[[ Note: the 'currentTime' variable needs to be defined inside of the functions
     that will be looped. If it's defined here, it will never get updated by the
     loop redefining it every recurrence. ]]

function runLightingLoop()
  while wait(loopSpeed) do
    outputTimeOfDay()
    timeCycle()
  end
end

function timeCycle()
  local currentTime = lighting:GetMinutesAfterMidnight()

  lighting:SetMinutesAfterMidnight(currentTime + timeIncrement)
end

function outputTimeOfDay()
  local timeOfDay = script.TimeOfDay

  -- Only update the time if it's changed.
  if timeOfDay.Value ~= getCurrentTime() then
    timeOfDay.Value = getCurrentTime()
  end
end

function getCurrentTime()
  local currentTime = lighting:GetMinutesAfterMidnight()

  local sunrise = 360
  local day     = sunrise + 60
  local sunset  = 1060
  local night   = sunset + 60

  -- Check the time against the four grouped variables above and
  -- output the time of day acordingly.

  -- The '>=' operand is needed or else there's a point where no value is true,
  -- causing the script to break.
  if currentTime >= sunrise and currentTime < day then
    return "sunrise"
  elseif currentTime >= day and currentTime < sunset then
    return "day"
  elseif currentTime >= sunset and currentTime < night then
    return "sunset"
  -- Sunrise is a smaller value than night, need to use 'or' instead of 'and'.
  elseif currentTime >= night or currentTime < sunrise then
    return "night"
  end
end

function generateTimeValue()
  -- Generate the TimeOfDay value if it doesn't already exist.
  if not script:FindFirstChild("TimeOfDay") then
    local timeValue = Instance.new("StringValue", script)
    timeValue.Name = "TimeOfDay"

    _G.TimeOfDay = script:FindFirstChild("TimeOfDay")
  end
end

print("Loaded " .. script.Name)

-- Generate the TimeOfDay value and get the loop started.
generateTimeValue()
runLightingLoop()
