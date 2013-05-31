
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


sp = script.Parent

-- Light the fire
function candle()
  local active -- Debounce
  local light  = sp.PointLight
  local flame  = sp.Flame.Fire
  local config = {
    range   = 15, -- The Range value of the light source.
    flicker = 3,  -- The frequency at which the light will flicker.
  }

  -- @TODO I need to make these while loops better.
  if active == true then
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
end

-- Connections go at the bottom for easy editing if there are multiples.
sp.ClickDetector.MouseClick:connect(candle)


--[[ Unused code. Keeping as a sort of archive.

while true do wait(0.5)
  -- Quick test to see if the function can be used while this is looping.
  -- Update: They can!
  words = {"Cats","Butts","Oranges","Rabbits","DEER HEAD"}
  for i = 1,#words do
    print(words[math.random(i)])
    wait()
  end
end

while true do wait(2)
  local time_of_day = game.Lighting:GetMinutesAfterMidnight()
  print(time_of_day)
end
]]