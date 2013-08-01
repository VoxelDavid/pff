--[[--
  |--------------------------------------------------------------------------
  | Time Cycle
  |--------------------------------------------------------------------------
  |
  | This function loops through the Day/Night and will output if it's Sunrise,
  | Day, Sunset or Night to the _G.conf.time_of_day value so other scripts can
  | hook into it and adjust based on the time.
  |
  | Associated variables:
  | _G.time_cycle
  |   enabled      (Bool) Controls whether the while loop will run or not.
  |   speed        (Int)  How quickly the cycle goes
  |
  |--------------------------------------------------------------------------
--]]--

repeat wait() until _G.config

function time_cycle()

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

		-- Check the time against the 4 grouped variables above and output the time of day acordingly.
		if l:GetMinutesAfterMidnight() > sunrise_start and l:GetMinutesAfterMidnight() < sunrise_end then
			-- Sunrise
			time_of_day.Value = 1
		elseif l:GetMinutesAfterMidnight() > sunrise_end and l:GetMinutesAfterMidnight() < sunset_start then
			-- Day
			time_of_day.Value = 2
		elseif l:GetMinutesAfterMidnight() > sunset_start and l:GetMinutesAfterMidnight() < sunset_end then
			-- Sunset
			time_of_day.Value = 3
		elseif l:GetMinutesAfterMidnight() > sunset_end and l:GetMinutesAfterMidnight() < sunrise_start then
			-- Night
			time_of_day.Value = 4
		end

	end

end

print("Loaded " .. script.Name)

time_cycle()
