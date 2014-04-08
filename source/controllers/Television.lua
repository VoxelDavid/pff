
local sp = script.Parent
local screen = sp.Screen
local button = sp.ClickDetector
local lightSource = screen.PointLight

local offColor = "Black"
local screenProducesLight = true

local tvIsActive = false -- Unconfigurable.

function toggleState()
  if tvIsActive == false then
    tvIsActive = not tvIsActive
    turnOnTV()
  else
    tvIsActive = not tvIsActive
    turnOffTV()
  end
end
button.MouseClick:connect(toggleState)

function turnOnTV()
  local loopSpeed = .6

  while true do
    local randomColor = Color3.new(math.random(), math.random(), math.random())

    if tvIsActive == false then break end

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
  changeScreenColorTo(offColor)
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

