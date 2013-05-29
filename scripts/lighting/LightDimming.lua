game_root  = game.Workspace
game_light = game.Lighting

-- Dim light.Brightness depending on Time of Day
-- I'd like to have a single script that checks for PointLights every couple seconds
function find_light_source()
  local time = game_light:GetMinutesAfterMidnight()

  print("Searching...")
  for _,v in pairs(game_root:GetChildren()) do
    if v:IsA("PointLight") then
      print("Found a PointLight")
      if v.FindFirstChild("DimsWhenDay") then
        print("PointLight should dim when it is day")
      end
    else
      print("Found nothing")
    end
  end
end

while true do wait()
 find_light_source()
end