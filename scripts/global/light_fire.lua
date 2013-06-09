--[===================================[--
  Description:
    Manage every fire based light throughout the game... In a single script!

    Edits a PointLight and Fire object to create a somewhat realistic fire effect.

    Clicking once expands the PointLight's range to the Range variable defined in
    the function call and enables the Fire.

    Clicking it again "extinguish" the candle by shrinking the PointLight's
    range to 0 and disabling the Fire.

	Prerequisites:
		Copy one of the fire based lighting models from assets_models in the root directory
		of the repo to the game.

  Calling the function:
    repeat wait() until _G.light_fire -- Wait for the function to load before calling it.

    local enabled
    local sp = script.Parent

    -- Variables
    local object = " "                  -- Applicable types: Candle, Fireplace, Torch
    local light  = sp.Light.PointLight  -- Path to the light source.
    local flame  = sp.Light.Fire        -- Path to Fire.
    local active = sp.Active            -- Path to Active boolean.

    sp.ClickDetector.MouseClick:connect(function()
    	if not enabled then
    		enabled = true
    		_G.light_fire(object, light, flame, active)
    		enabled = false
    	end
    end)
--]===================================]--

-- Wait for the configuration file before doing anything else.
repeat wait() until _G.config

function _G.light_fire(object, light, flame, active)
	-- Get the type of object specified in the function call and lowercase it.
	local object = string.lower(object)

	if active.Value == false then
		-- If the light is off fade it in
		flame.Enabled = true
		while light.Range < _G.lighting[object].range do
			wait()
			-- Divide the object's range by it's speed to make sure it always stops at the correct range.
			light.Range = light.Range + _G.lighting[object].range / _G.lighting[object].light_speed
		end
		active.Value = true
	else
		-- Otherwise if the light is on, "extinguish" it.
		flame.Enabled = false
		while light.Range > 0 do
			-- Divide the object's range by ext_speed. This value is lower than light_speed so it goes out quicker.
			light.Range = light.Range - _G.lighting[object].range/_G.lighting[object].ext_speed
			wait()
		end
		active.Value = false
	end
end

print("Loaded _G." .. script.Name)