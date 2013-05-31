
game_root  = game.Workspace
game_light = game.Lighting

-- Dim light.Brightness depending on Time of Day
-- I'd like to have a single script that checks for PointLights every couple seconds

-- If I can't figure out how to do this from a single script, I'm
-- going to need to put while loops in all of my light sources.
function find_light_sources()
  local time = game_light:GetMinutesAfterMidnight()

  print("Searching...")
  for i,v in pairs(game_root:GetChildren()) do
    if v:IsA("PointLight") or v:IsA("SpotLight") then
      print("Found a light source!")
      if v:findFirstChild("DimsWhenDay") then
        print("Light source should dim when its day")
      end
    -- else
    --   print("Found nothing")
    end
  end
end

while wait() do
 find_light_sources()
end