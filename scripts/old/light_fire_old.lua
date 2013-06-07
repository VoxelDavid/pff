--[===================================[--
	@Description
		Manage every fire based light throughout the game... In a single script!

		Edits a PointLight and Fire object to create a somewhat realistic fire effect.

		Clicking once expands the PointLight's range to the Range variable defined in
		the function call and enables the Fire.

		Clicking it again "extinguish" the candle by shrinking the PointLight's
		range to 0 and disabling the Fire.

	@ToDo:
		What's some better math to ensure the while loops stop exactly
		at the predefined range? Would a repeat loop get that job done better?

	@Prerequisites:
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

	@Calling the function:
		repeat wait() until _G.light_fire -- Wait for the function to load before calling it.

		local enabled
		local sp = script.Parent

		-- Variables
		local light  = sp.Light.PointLight  -- Path to the light source.
		local flame  = sp.Light.Fire        -- Path to Fire.
		local active = sp.Active            -- Path to Active boolean.

		sp.ClickDetector.MouseClick:connect(function()
			if not enabled then
				enabled = true
				_G.light_fire(light, flame, active)
				enabled = false
			end
		end)
--]===================================]--

repeat wait() until _G.config -- Wait for the configuration file before doing anything else.

function _G.light_fire(light, flame, active)
	if active.Value == false then
		-- If the light is off fade it in
		flame.Enabled = true
		while light.Range < _G.lighting.ranges.candle do
			light.Range = light.Range + 2.5
			wait()
		end
		active.Value = true
	else
		-- Otherwise if the light is on, "extinguish" it.
		flame.Enabled = false
		while light.Range > 0 do
			light.Range = light.Range - 5
			wait()
		end
		active.Value = false
	end
end

print("_G.light_fire Loaded")