--[[
  This script takes care of server-specific lighting tasks.

  The main functionality consists of a time cycle, and creating a 'time of day'
  value for other scripts to hook into.
]]

local timeIncrement = .75 -- The amount added on to the current time every recurrence.
local loopSpeed = .25     -- How long the loop will wait() before adding timeIncrement.

local lighting = game.Lighting

--[[ Note: the 'currentTime' variable needs to be defined inside of the functions
     that will be looped. If it's defined here, it will never get updated by the
     loop redefining it every recurrence. ]]

repeat wait() until _G.ready

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
  local currentTime = lighting:GetMinutesAfterMidnight()

  local timeOfDay = _G.values.TimeOfDay

  local sunrise = 360
  local day     = sunrise + 60
  local sunset  = 1060
  local night   = sunset + 60

  -- Check the time against the four grouped variables above and
  -- output the time of day acordingly.
  if currentTime > sunrise and currentTime < day then
    timeOfDay.Value = "sunrise"
  elseif currentTime > day and currentTime < sunset then
    timeOfDay.Value = "day"
  elseif currentTime > sunset and currentTime < night then
    timeOfDay.Value = "sunset"
  elseif currentTime > night and currentTime < sunrise then
    timeOfDay.Value = "night"
  end
end

function generateTimeValue()
  -- Generate the TimeOfDay value if it doesn't already exist.
  if not _G.values:FindFirstChild("TimeOfDay") then
    local timeValue = Instance.new("StringValue", _G.values)
    timeValue.Name = "TimeOfDay"
  end
end

print("Loaded " .. script.Name)

-- Generate the TimeOfDay value and get the loop started.
generateTimeValue()
runLightingLoop()
