[===================================[
  Edits a PointLight and Fire to create a somewhat realistic candle effect.

  Clicking once expands the PointLight's range to a predefined (range) value
  below and then enabling the Fire.

  Clicking it again "extinguises" the candle by shrinking the PointLight's range
  to 0 and disabling the Fire.

  @ToDo:
   The If block could use some revising, as well as the while loops.
]===================================]

_G["light_candle"] = function()
  sp = script.Parent
  light  = sp.PointLight
  flame  = sp.Flame.Fire
  config = {
    range   = 15, -- The Range value of the light source.
    flicker = 3,  -- The frequency at which the light will flicker.
  }

  -- @TODO I need to make these while loops better.
  if not active then
    -- If the light is active, extinguise it quickly.
    flame.Enabled = false

    while light.Range > 0 do wait()
      light.Range = light.Range - 5
    end

    active = false
  else
    -- If the light is off, quickly, but smoothly, fade it in.
    flame.Enabled = true

    -- @TODO What's some better math to ensure it stops exactly at the predefined range?
    -- Would a repeat loop work better?
    while light.Range < config.range do wait()
      light.Range = light.Range + 2.5
    end

    active = true
  end
end