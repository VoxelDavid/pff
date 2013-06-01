--[===================================[--
  @Description
    Edits a PointLight and Fire to create a somewhat realistic candle effect.

    Clicking once expands the PointLight's range to the Range variable below and
    hen enabling the Fire.

    Clicking it again "extinguises" the candle by shrinking the PointLight's
    range to 0 and disabling the Fire.

  @ToDo:
    The If block could use some revising, as well as the while loops.
    What's some better math to ensure the while loops stop exactly
    at the predefined range? Would a repeat loop get that job done better?

  @Prerequisits:
    Make sure that these objects exists in the same Parent as the Call script:

    PointLight,
    Part named Flame,
      Fire inside Flame,
    Boolean named Active.

  @Calling the Function:
    repeat wait() until _G.light_candle -- Wait for the function to load before calling it.

    local enabled
    local sp = script.Parent
    script.Parent.ClickDetector.MouseClick:connect(function()
      if not enabled then
        enabled = true
        _G.light_candle(sp.PointLight, sp.Flame.Fire, sp.Active)
        enabled = false
      end
    end)
--]===================================]--

function _G.light_candle(light_path, flame_path, active_var)
  light_path = light
  fire_path  = flame
  active_var = active

  print("Start")
  if active.Value == false then
    print("Candle is out")
    -- If the light is off, quickly, but smoothly, fade it in.
    flame.Enabled = true
    print("Lighting")
    while light.Range < _G.light_candle_range do
      wait(_G.base_wait_time)
      light.Range = light.Range + 2.5
    end
    active.Value = true
  else
    print("Candle is lit")
    -- If the light is active, extinguise it quickly.
    flame.Enabled = false
    print("Extinguise")
    while light.Range > 0 do wait()
      light.Range = light.Range - 5
    end
    active.Value = false
  end
end
print("_G.light_candle Loaded")