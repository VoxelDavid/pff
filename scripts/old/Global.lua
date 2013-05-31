--[[
  This script holds all of the functions and major
  values used throughout the game.

  Authored By: VoxelDavid (On Roblox as D3lego & MonsterBone)

  @ToDo:
    Make all light have the option to flicker from either
    a predefined value and/or putting an IntValue/NumberValue
    with the script call.

    Make all lights dim to around 0.1 brightness durring the
    day and at night go back to the default brightness of 1.

  @Reminder:
  To prevent theft of my code I could add script:Destroy()
  to the end of the file, and the _G table will retain all my
  functions. I have the project open sources on Github, so that
  seems a little silly, but it's something to keep in mind

  Use with the flickering function.
  math.random(range - light_flicker_frequecy, range)
]]


[===================================[
    VARIABLES
]===================================]
_G.light_flicker_frequency       = 3     -- The frequency of how many times a fire based light will flicker each second.
_G.light_brightness_when_day     = 0.1   -- How bright a light should be in the day.
_G.light_brightness_when_night   = 1     -- How bright a light should be at night.



[===================================[
    FUNCTIONS
]===================================]

--========= General Use Functions =========--

--[[ _G.debounce
  Used to prevent functions from repeating until they've completed.

  Usage: [Path].[Action]:connect(_G.debounce( [function to call]() ))
  Example: script.Parent.Touched:connect(_G.debounce( onTouched() ))
]]

-- I think because it's executing in the Global script it can't be used by other functions.
_G["debounce"] = function(function_to_debounce)
  local enabled = false
  return function(...)
    if not enabled then
      enabled = true
      function_to_debounce(...)
      enabled = false
    end
  end
end

--========= LIGHTING =========--

--[[ _G.light_candle
  Edits a PointLight and Fire to create a somewhat realistic candle effect.

  Clicking once expands the PointLight's range to a predefined (range) value
  below and then enabling the Fire.

  Clicking it again "extinguises" the candle by shrinking the PointLight's range
  to 0 and disabling the Fire.

  @ToDo:
   The If block could use some revising, as well as the while loops.
]]
_G["light_candle"] = function()
  sp = script.Parent
  active -- Debounce

  light  = sp.PointLight
  flame  = sp.Flame.Fire
  config = {
    range   = 15, -- The Range value of the light source.
    flicker = 3,  -- The frequency at which the light will flicker.
  }

  -- @TODO I need to make these while loops better.
  if not active then
    -- If the light is active, extinguise it quickly.
    flame.Enabled = false

    while light.Range > 0 do wait()
      light.Range = light.Range - 5
    end

    active = false
  else
    -- If the light is off, quickly, but smoothly, fade it in.
    flame.Enabled = true

    -- @ToDo What's some better math to ensure it stops exactly at the predefined range?
    -- Would a repeat loop work better?
    while light.Range < config.range do wait()
      light.Range = light.Range + 2.5
    end

    active = true
  end
end

-- Dim a light source in the day time.
--[[ _G.brightness_adjustments
]]
_G["brightness_adjustments"] = function()
  -- Put inside of a while loop:

  -- if between start_time and end_time then
    -- fade out lights
  -- else
    -- fade in lights
  -- end

  -- Set global variables for when lights should
  -- start dimming and when they should brighten back up.
end

--[[ _G.get_the_time
  Get MinutesAfterMidnighit()/60 and if it's a certain time, do something.
]]
_G["get_the_time"] = function()
end

-- Once done print to the output that everything is running smoothly.
print("Master Script Loaded Successfully")



--[[ Archive

-- _G test function.
_G[script] = {} -- Create the "Script" sub-table that will hold all the functions.
gb = _G[script] -- Asign the new sub-table a quick alias (Stands for "Global").

gb.YouTouchMyTralala = function()
  print("Mmm, my ding ding dong")
end

]]
