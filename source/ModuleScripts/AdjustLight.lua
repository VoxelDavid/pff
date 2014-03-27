--[[
  This script simply hooks into the TimeOfDay global value and fades the brightness
  in or out depending on the value.
]]

local brightnessWhenDay   = .3
local brightnessWhenNight = 1

repeat wait(.1) until _G.TimeOfDay

function adjustBrightness(lightSource)
  local timeOfDay = _G.TimeOfDay

  if timeOfDay.Value == "sunrise" or timeOfDay.Value == "day" then
    fadeOut(lightSource)
  elseif timeOfDay.Value == "sunset" or timeOfDay.Value == "night" then
    fadeIn(lightSource)
  end
end

function fadeOut(lightSource)
  while lightSource.Brightness > brightnessWhenDay do
    lightSource.Brightness = lightSource.Brightness - .03
    wait(.1)
  end
end

function fadeIn(lightSource)
  while lightSource.Brightness < brightnessWhenNight do
    lightSource.Brightness = lightSource.Brightness + .03
    wait(.1)
  end
end

return adjustBrightness
