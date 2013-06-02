--[===================================[--
  @Description
    Edits a PointLight and Fire to create a somewhat realistic candle effect.

    Clicking once expands the PointLight's range to the Range variable below and
    hen enabling the Fire.

    Clicking it again "extinguish" the candle by shrinking the PointLight's
    range to 0 and disabling the Fire.

  @ToDo:
    What's some better math to ensure the while loops stop exactly
    at the predefined range? Would a repeat loop get that job done better?

  @Prerequisites:
    Make sure that these objects exists in the same Parent as the Call script:
    Boolean named "Active",
    Part named "Light",
      PointLight and Fire inside of Light.

  @Calling the Function:
    repeat wait() until _G.light_candle -- Wait for the function to load before calling it.

    local enabled
    local sp = script.Parent

    -- There has to be a better way to pass variables to a global function.
    -- Until I find that solution I'll have to define the variables in the Call script.
    light  = sp.Light.PointLight
    flame  = sp.Light.Fire
    active = sp.Active

    script.Parent.ClickDetector.MouseClick:connect(function()
      if not enabled then
        enabled = true
        _G.light_candle(light, flame, active)
        enabled = false
      end
    end)
--]===================================]--

function _G.light_candle(light, flame, active)
  if not light or not flame or not active then
    error("One or more required objects is missing!")
  end

  if active.Value == false then
    -- If the light is off fade it in
    print("Candle is out... Lighting.") -- Testing message, remove later.
    flame.Enabled = true
    while light.Range < _G.light_candle_range do
      light.Range = light.Range + 2.5
      wait()
    end
    active.Value = true
  else
    -- Otherwise if the light is on, "extinguish" it.
    print("Candle is lit... Extinguishing") -- Testing message, remove later.
    flame.Enabled = false
    while light.Range > 0 do
      light.Range = light.Range - 5
      wait()
    end
    active.Value = false
  end
end

print("_G.light_candle Loaded")