--[===================================[--
  This function loops through the Day/Night and will output if
  it's Sunrise, Day, Sunset or Night to _G.conf.time_of_day so
  other scripts can hook into it and adjust based on the time.

  Associated variables:
  _G.time_cycle
    enabled      (Bool)
    sun_ambient  (Bool)
    speed        (Int)
    day_length   (Int)
    night_length (Int)
--]===================================]--

-- Wait for the configuration file before doing anything else.
repeat wait() until _G.config

function time_cycle()

	-- If the time cycle is disabled don't do anything else.
	if _G.time_cycle.enabled == false then return end

	while wait() do

		local l = game:service("Lighting")

		local time_of_day = _G.conf.time_of_day

		local sunrise_start = 360
		local sunrise_end   = sunrise_start + 60
		local sunset_start  = 1060
		local sunset_end    = sunset_start + 60

		-- The time cycle
		l:SetMinutesAfterMidnight(l:GetMinutesAfterMidnight() + _G.time_cycle.speed)

		-- During sunrise and sunset make the sky a nice orange color
		if l:GetMinutesAfterMidnight() > sunrise_start and l:GetMinutesAfterMidnight() < sunrise_end then
			time_of_day.Value = 1 -- Sunrise

		-- Between Sunrises's end and Sunset's start
		elseif l:GetMinutesAfterMidnight() > sunrise_end and l:GetMinutesAfterMidnight() < sunset_start then
			time_of_day.Value = 2 -- Day

		-- Between Sunset's start and Sunset's end
		elseif l:GetMinutesAfterMidnight() > sunset_start and l:GetMinutesAfterMidnight() < sunset_end then
			time_of_day.Value = 3 -- Sunset

		-- Between Sunset's end and Sunrise's start
		elseif l:GetMinutesAfterMidnight() > sunset_end and l:GetMinutesAfterMidnight() < sunrise_start then
			time_of_day.Value = 4 -- Night
		end

	end

end

print("Loaded " .. script.Name)

time_cycle()
