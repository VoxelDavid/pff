--[===================================[--
	Description:
		This function is used to change the time of day.

		It outputs the time to values inside of this script so other scripts
		can hook into those values and adjust based on the time.
--]===================================]--

repeat wait() until _G.config -- Wait for the configuration file before doing anything else.

local l = game:service("Lighting")

function time_cycle()
	if _G.time_cycle.enabled == false then return end
	while wait(_G.wait_time) do
		-- Time Cycle
		l:SetMinutesAfterMidnight(l:GetMinutesAfterMidnight() + _G.time_cycle.speed)

		-- If Sunsets and Sunrises should change the ambient color, then:
		if _G.time_cycle.sun_ambient == true then
			local time_of_day   = _G.values.time_of_day

			-- These values should remain the same. They've been set to a very specific time.
			local sunrise_start = 300
			local sunrise_end   = sunrise_start + 60
			local sunset_start  = 1020
			local sunset_end   = sunset_start + 60

			--[[
				So far this works as intended aside from the ambient changing. Something I'm unsure about is,
				if I use while loops to change the lighting, will that stop the rest of the script from functioning?
				WIll this be my first use of coroutines?

				Another thing is, how can I still get time_of_day to be changed even if the ambient is set to off?
			]]

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
end

print("Loaded TimeCycle")

time_cycle()