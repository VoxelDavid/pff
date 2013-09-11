--[==[--
  |--------------------------------------------------------------------------
  | Light Adjust
  |--------------------------------------------------------------------------
  |
  | Adjust light source depending on the time of day.
  |
  | TimeCycle controls everything to do with time passing, and outputs if
	| it's Sunrise, Day, Sunset or Night to _G.conf.time_of_day.
	|
  | This scripts hooks into that value and if the value is 1 (Sunrise), it
  | decreases the Brightness of the PointLight specified through the Light
  | parameter and if the value is 3 (Sunset), it returns it to normal.
  |
  |--------------------------------------------------------------------------
--]==]--

-- Wait for the configuration file before doing anything else.
repeat wait() until _G.ready

function _G.light_adjust(light)
	local time_of_day = _G.conf.time_of_day

	-- 1 = Sunrise, 2 = Day, 3 = Sunset, 3 = Night.
	if time_of_day.Value == 1 then

		-- Fade out the brightness to the pre-defined brightness in the global config.
		while light.Brightness > _G.lighting.brightness_when_day do
			wait(0.1)
			light.Brightness = light.Brightness - 0.03
		end

	elseif time_of_day.Value == 3 then

		-- Fade in the brightness back to normal.
		while light.Brightness < _G.lighting.brightness_when_night do
			wait(0.1)
			light.Brightness = light.Brightness + 0.03
		end

	end

end

print("Loaded _G."..script.Name)
