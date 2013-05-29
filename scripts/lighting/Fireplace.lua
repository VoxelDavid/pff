sp = script.Parent
game_light = game.Lighting

-- Light the fire
function set_alight()
  local active = sp.Active
  local light  = sp.Flame.PointLight
  local flame  = sp.Flame.Fire
  local range  = 15 -- The Range value of the light.

  print("FIRE!")
end
sp.Click.ClickDetector.MouseClick:connect(set_alight)