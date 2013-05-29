sp = script.Parent
game_light = game.Lighting

-- Light the fire
function set_alight()
  local active = sp.Active
  local light  = sp.PointLight
  local flame  = sp.Flame.Fire
  local range  = 15 -- The Range value of the light.

  if active.Value == true then
    -- If the light is active, extinguise it immediately.
    flame.Enabled = false
    while light.Range > 0 do wait()
      light.Range = light.Range - 5
    end
    active.Value = false
  else
    -- If the light is off, quickly, but smoothly, fade it in.
    -- What's some better math to ensure it stops exactly at the predefined range?
    flame.Enabled = true
    while light.Range <= range do wait()
      light.Range = light.Range + 2.5
    end
    active.Value = true
  end
end
sp.ClickDetector.MouseClick:connect(set_alight)

--[[
while true do wait(0.5)
  -- Quick test to see if the function can be used while this is looping.
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