--[[
  This script holds all of the functions and major
  values used throughout the game.

  Authored By: VoxelDavid (On Roblox as D3lego & MonsterBone)

  @ToDo
]]

-- Used with the flickering function.
-- math.random(range - light_flicker_frequecy, range)


--[===================================[--
    VARIABLES
--]===================================]--
_G.light_flicker_frequency       = 3     -- The frequency of how many times a fire based light will flicker each second.
_G.light_brightness_when_day     = 0.1   -- How bright a light should be in the day.
_G.light_brightness_when_night   = 1     -- How bright a light should be at night.



--[===================================[--
    FUNCTIONS
--]===================================]--
_G[script] = {} -- Create the "Script" sub-table that will hold all the functions.
gb = _G[script] -- Asign the new sub-table a quick alias (Stands for "Global").


--========= LIGHTING =========--

gb.light_candle = function()

  --[[ ToDo: (Do not include in final Script)
   Get the time of day and adjust the brightness so it's dim
   (almost unnoticable) in the daylight and extremely visible
   at night.

   Flickering light.

   The if block in the candle function does not seem as good
   as it could be. Try to revise it.

   If I decide not to use a global script to manage
   everything change the active variable to true,
   and remove .Value from all changes to it.
  ]]

  local sp = script.Parent
  local active -- Debounce

  local light  = sp.PointLight
  local flame  = sp.Flame.Fire
  local config = {
    range   = 15, -- The Range value of the light source.
    flicker = 3,  -- The frequency at which the light will flicker.
  }

  -- @TODO I need to make these while loops better.
  if active then
    -- If the light is active, extinguise it quickly.
    flame.Enabled = false

    while light.Range > 0 do wait()
      light.Range = light.Range - 5
    end

    active = false
  else
    -- If the light is off, quickly, but smoothly, fade it in.
    flame.Enabled = true

    -- @TODO What's some better math to ensure it stops exactly at the predefined range?
    -- Would a repeat loop work better?
    while light.Range < config.range do wait()
      light.Range = light.Range + 2.5
    end

    active = true
  end
  -- Bring in the Candle script and tweak them to
  -- work properly.
end

-- Dim a light source in the day time.
gb.dim_light_in_day = function()
  -- Set global variables for when lights should
  -- start dimming and when they should brighten back up.
end

-- Brighten a light source at night time.
gb.brighten_light_at_night = function()
end

--Get the minutes after midnight / 60 and if it's a certain time do something.
gb.get_the_time = function()
end

-- Once done print to the output that everything is running smoothly.
print("Master Script Loaded Successfully")



--[[ Archive

-- _G test function.
gb.YouTouchMyTralala = function()
  print("Mmm, my ding ding dong")
end

]]
