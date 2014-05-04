
local offColor = "Black" -- BrickColor of the screen when it's off.
local screenProducesLight = true -- If the PointLight will be used or not.

local Television = {}




function Television:Toggle(screen, light, active)
  if active.Value then
    active.Value = not active.Value -- false
    self:TurnOff(screen, light)
  else
    active.Value = not active.Value -- true
    self:TurnOn(screen, light, active)
  end
end

function Television:TurnOn(screen, light, active)
  local loopSpeed = .6

  while true do
    if active.Value == false then
      break -- Break out of the loop if the TV is off.
    end

    local randomColor = Color3.new(math.random(), math.random(), math.random())

    -- Change the randomly chosen color if it's the same as the current color.
    while randomColor == screen.Color do
      randomColor = randomColor
    end

    changeScreenLightColorTo(light, randomColor)
    changeScreenColorTo(screen, randomColor)
    wait(loopSpeed)
  end
end

function Television:TurnOff(screen, light, active)
  light.Enabled = false
  changeScreenColorTo(screen, offColor)
end

function changeScreenLightColorTo(light, color)
  if screenProducesLight == true then
    light.Enabled = true
    light.Color = color
  end
end

function changeScreenColorTo(screen, color)
  screen.BrickColor = BrickColor.new(color)
end

return Television
