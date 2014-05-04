
Television = {
  OffColor = "Black", -- BrickColor of the screen when it's off.
  ScreenProducesLight = true -- If the PointLight will be used or not.
}

Television.__index = Television

function Television.new(screen, light, active)
  local instance = {
    Screen = screen,
    Light  = light,
    Active = active or false
  }

  return setmetatable(instance, Television)
end

function Television:Toggle()
  if self.Active then
    self.Active = not self.Active -- false
    self:TurnOff()
  else
    self.Active = not self.Active -- true
    self:TurnOn()
  end
end

function Television:TurnOn()
  local loopSpeed = .6

  while true do
    if not self.Active then
      break -- Break out of the loop if the TV is off.
    end

    local randomColor = Color3.new(math.random(), math.random(), math.random())

    -- Change the randomly chosen color if it's the same as the current color.
    while randomColor == self.Screen.Color do
      randomColor = randomColor
    end

    changeScreenColorTo(self.Screen, randomColor)

    if self.ScreenProducesLight then
      changeScreenLightColorTo(self.Light, randomColor)
    end

    wait(loopSpeed) -- Wait at the end of the loop so it can be run first.
  end
end

function Television:TurnOff()
  self.Light.Enabled = false
  changeScreenColorTo(self.Screen, self.OffColor)
end

function changeScreenLightColorTo(light, color)
  light.Enabled = true
  light.Color = color
end

function changeScreenColorTo(screen, color)
  screen.BrickColor = BrickColor.new(color)
end

return Television
