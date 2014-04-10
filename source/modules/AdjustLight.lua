--[[
  This script simply hooks into the TimeOfDay global value and fades the
  brightness in or out depending on the value.
--]]

local brightnessWhenDay = .3
local brightnessWhenNight = 1

repeat wait(.1) until _G.TimeOfDay

local AdjustLight = function(lightSource)
  local timeOfDay = _G.TimeOfDay

  --[[
    'morning' and 'dusk' are included incase the game's time is set in a place
    where it won't be triggered by 'dawn' or 'evening' for a while, fading out
    the light at the start of the game.
  --]]
  if timeOfDay.Value == "dawn" or timeOfDay.Value == "morning" then
    fadeOut(lightSource)
  elseif timeOfDay.Value == "evening" or timeOfDay.Value == "dusk" then
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

return AdjustLight
