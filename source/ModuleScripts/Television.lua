
local offColor = "Black"
local screenProducesLight = true

local Television = {
  toggle = function(self, screen, light, active)
    if active.Value == false then
      active.Value = not active.Value
      self:turnOn(screen, light, active)
    else
      active.Value = not active.Value
      self:turnOff(screen, light)
    end
  end,

  turnOn = function(self, screen, light, active)
    local loopSpeed = .6

    while true do
      local randomColor = Color3.new(math.random(), math.random(), math.random())

      if active.Value == false then break end

      -- Change the randomly chosen color if it's the same as the current color.
      while randomColor == screen.Color do
        randomColor = randomColor
      end

      changeScreenLightColorTo(light, randomColor)
      changeScreenColorTo(screen, randomColor)
      wait(loopSpeed)
    end
  end,

  turnOff = function(self, screen, light)
    light.Enabled = false
    changeScreenColorTo(screen, offColor)
  end
}

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
