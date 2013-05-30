
--[[ TODO: (Do not include in final Script)
   Get the time of day and adjust the brightness so it's dim
   (almost unnoticable) in the daylight and extremely visible
   at night.

   Flickering light.

   If I decide not to use a global script to manage
   everything change the active variable to true,
   and remove .Value from all changes to it.
]]


sp = script.Parent
game_light = game.Lighting

-- Light the fire
function set_alight()
  local active = sp.Active
  local light  = sp.PointLight
  local flame  = sp.Flame.Fire
  local range  = 15 -- The Range value of the light.

  -- @TODO I need to make these while loops better.
  if active.Value == true then
    -- If the light is active, extinguise it quickly.
    flame.Enabled = false

    -- Fade out the light.
    while light.Range > 0 do wait()
      light.Range = light.Range - 5
    end

    active.Value = false
  else
    -- If the light is off, quickly, but smoothly, fade it in.
    -- @TODO What's some better math to ensure it stops exactly at the predefined range?
    flame.Enabled = true

    -- Fade in the light.
    while light.Range < range do wait()
      light.Range = light.Range + 2.5
    end

    active.Value = true
  end
end

-- Connections go at the bottom for easy editing if there are multiples.
sp.ClickDetector.MouseClick:connect(set_alight)


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