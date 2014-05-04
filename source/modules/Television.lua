
Television = {
  OffColor = "Black", -- BrickColor of the screen when it's off.
  ScreenProducesLight = true -- If the PointLight will be used or not.
}

Television.__index = Television

function Television.new(screen, light, active)
  local instance = {
    screen = screen,
    light = light,
    active = active
  }

  return setmetatable(instance, Television)
end

function Television:Toggle()
  local active = self.active

  if active.Value then
    active.Value = not active.Value -- false
    self:TurnOff()
  else
    active.Value = not active.Value -- true
    self:TurnOn()
  end
end

function Television:TurnOn()
  local loopSpeed = .6

  while true do
    if self.active.Value == false then
      break -- Break out of the loop if the TV is off.
    end

    local randomColor = Color3.new(math.random(), math.random(), math.random())

    -- Change the randomly chosen color if it's the same as the current color.
    while randomColor == self.screen.Color do
      randomColor = randomColor
    end

    changeScreenColorTo(self.screen, randomColor)

    if self.ScreenProducesLight then
      changeScreenLightColorTo(self.light, randomColor)
    end

    wait(loopSpeed) -- Wait at the end of the loop so it can be run first.
  end
end

function Television:TurnOff()
  self.light.Enabled = false
  changeScreenColorTo(self.screen, self.OffColor)
end

function changeScreenLightColorTo(light, color)
  light.Enabled = true
  light.Color = color
end

function changeScreenColorTo(screen, color)
  screen.BrickColor = BrickColor.new(color)
end

return Television
