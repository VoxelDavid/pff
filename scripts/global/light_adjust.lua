--[===================================[--
  Description:
    Adjust light source depending on time of day.

    TimeCycle controls everything to do with time passing, and outputs
    if it's Sunrise, Day, Sunset or Night to the time_of_day value.

    This script hooks into that value and if the value is 1 (Sunrise),
    it decreases the Brightness and if the value is 3 (Sunset) it
    returns it to normal.

    Calling the function:
    [Add the function call code]
--]===================================]--

repeat wait() until _G.config -- Wait for the configuration file before doing anything else.

function _G.light_adjust(light)
	local time_of_day = _G.values.time_of_day

	-- 1 = Sunrise, 2 = Day, 3 = Sunset, 3 = Night.
	if time_of_day.Value == 1 then

		while light.Brightness > _G.lighting.brightness_when_day do
			wait(_G.wait_time)
			light.Brightness = light.Brightness - 0.05
		end

	elseif time_of_day.Value == 3 then
		-- Fade in the brightness of the light if it's night time
		while light.Brightness < _G.lighting.brightness_when_night do
			wait(_G.wait_time)
			light.Brightness = light.Brightness + 0.05
		end

	end
end

print("Loaded _G.light_adjut")