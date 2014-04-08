
local sp = script.Parent
local screen = sp.Screen
local button = sp.ClickDetector
local active = false
local lightSource = screen.PointLight

local screenProducesLight = true

local OFF_COLOR = "Black"

function toggleState()
  if active == false then
    active = not active
    turnOnTV()
  else
    active = not active
    turnOffTV()
  end
end
button.MouseClick:connect(toggleState)

function turnOnTV()
  local loopSpeed = .6

  while true do
    local randomColor = Color3.new(math.random(), math.random(), math.random())

    if active == false then
      break
    end

    -- Change the randomly chosen color if it's the same as the current color.
    while randomColor == screen.Color do
      randomColor = randomColor
    end

    changeScreenLightColorTo(randomColor)
    changeScreenColorTo(randomColor)
    wait(loopSpeed)
  end
end

function turnOffTV()
  lightSource.Enabled = false
  changeScreenColorTo(OFF_COLOR)
end

function changeScreenLightColorTo(color)
  if screenProducesLight == true then
    lightSource.Enabled = true
    lightSource.Color = color
  end
end

function changeScreenColorTo(color)
  screen.BrickColor = BrickColor.new(color)
end

