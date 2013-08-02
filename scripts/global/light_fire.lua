--[==[--
  |--------------------------------------------------------------------------
  | Light Fire
  |--------------------------------------------------------------------------
  |
  | When clicked it will toggle between "lit" and "extinguished", editing a
	| PointLight and Fire object to create a somewhat realistic fire effect.
  |
  |--------------------------------------------------------------------------
--]==]--

-- Wait for the configuration file before doing anything else.
repeat wait() until _G.config

function _G.light_fire(object, light, flame, active)

	-- Get the type of object specified in the function call and lowercase it.
	local object = string.lower(object)

	-- If the light is extinguised, fade it in, otherwise if it's lit extinguish it quickly.
	if active.Value == false then

		flame.Enabled = true

		while light.Range < _G.lighting[object].range do
			wait()
			-- Divide the object's range by light_speed. This ensures it will stop at exactly the right Range.
			light.Range = light.Range + _G.lighting[object].range / _G.lighting[object].light_speed
		end

		active.Value = true

	else

		flame.Enabled = false

		while light.Range > 0 do
			-- Divide the object's range by ext_speed. This value is lower than light_speed so it goes out quicker.
			light.Range = light.Range - _G.lighting[object].range / _G.lighting[object].ext_speed
			wait()
		end

		active.Value = false

	end

end

print("Loaded _G."..script.Name)
