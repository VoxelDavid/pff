--[===================================[--
	Description
		Manage every fire based light throughout the game... In a single script!

		Edits a PointLight and Fire object to create a somewhat realistic fire effect.

		Clicking once expands the PointLight's range to the Range variable defined in
		the function call and enables the Fire.

		Clicking it again "extinguish" the candle by shrinking the PointLight's
		range to 0 and disabling the Fire.

	Prerequisites:
		Make sure that these objects exists in the same Parent as the Call script:
		Boolean named "Active",
		ClickDetector,
		Part named "Light",
		PointLight and Fire inside of Light.

		File structure should look like this:
		- Part
		|- Active
		|- ClickDetector
		|- call_light_fire -- The function calling script (Copy the below into it)
		|- Light
		|-|- Fire
		|-|- PointLight

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

repeat wait() until _G.config -- Wait for the configuration file before doing anything else.

function _G.light_fire(object, light, flame, active)
	local object = string.lower(object) -- Get the type of object specified in the function call and lowercase it.

	if active.Value == false then
		-- If the light is off fade it in
		flame.Enabled = true
		while light.Range < _G.lighting[object].range do
			wait()
			-- Divide the object's range by it's speed to make sure it always stops at the correct range.
			light.Range = light.Range + _G.lighting[object].range / _G.lighting[object].speed
		end
		active.Value = true
	else
		-- Otherwise if the light is on, "extinguish" it.
		flame.Enabled = false
		while light.Range > 0 do
			-- Divide the object's range by extinguish_speed. This value is lower than
			-- the object specific speed so it goes out very quickly.
			light.Range = light.Range - _G.lighting[object].range/_G.lighting.extinguish_speed
			wait()
		end
		active.Value = false
	end
end

print("Loaded _G.light_fire")