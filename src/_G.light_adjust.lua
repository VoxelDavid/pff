
--[[
 Light Adjust
 ============

 Adjust light source depending on the time of day.

 LightingHandler controls everything to do with time passing and outputs if it's
 Sunrise, Day, Sunset or Night to _G.config.time_of_day.

 This script hooks into that value and if it is 1 (Sunrise), it decreases the
 Brightness of the PointLight specified through the 'light' parameter and if the
 value is 3 (Sunset), it returns the brightness to normal.
]]--

repeat wait() until _G.ready

function _G.light_adjust(light_source)
	-- 1 = Sunrise, 2 = Day, 3 = Sunset, 4 = Night.
	local time_of_day = _G.config.time_of_day

	-- If the time is Sunrise or Day.
	if time_of_day.Value == 1 or time_of_day.Value == 2 then
		-- Fade out the brightness to the predefined brightness in the global config.
		while light_source.Brightness > _G.lighting.brightness_when_day do
			wait(0.1)
			light_source.Brightness = light_source.Brightness - 0.03
		end

	-- If the time is Sunset or Night.
	elseif time_of_day.Value == 3 or time_of_Day.Value == 4 then
		-- Fade in the brightness back to normal.
		while light_source.Brightness < _G.lighting.brightness_when_night do
			wait(0.1)
			light_source.Brightness = light_source.Brightness + 0.03
		end
	end
end

-- The script is loaded!
print("Loaded _G."..script.Name)
