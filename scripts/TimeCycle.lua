
-- Ambient        : 44,44,44
-- Brightness     : 1.5
-- OutdoorAmbient : 80,80,80

--[===================================[--
	@Description
		This function is used to change the time of day.

		It outputs the time to values inside of this script so other scripts
		can hook into those values and adjust based on the time.
--]===================================]--

-- I don't think Variables is a function, so if this script doesn't output anything adjust this.
repeat wait() until _G.variables

local l = game:service("Lighting")
local wait_time = _G.base_wait_time

function time_cycle()
	while wait(wait_time) do
		print(l:GetMinutesAfterMidnight()) -- Print the current time to the output.
		l:SetMinutesAfterMidnight(l:GetMinutesAfterMidnight() + 4)

		if _G.time_cycle_sun_ambient == true then
			sunrise_start = _G.time_cycle_sunrise
			sunrise_end   = _G.time_cycle_sunrise + 60
			sunset_start  = _G.time_cycle_sunset
			sunset_end    = _G.time_cycle_sunset + 60

			-- Durring sunrise and sunset make the sky a nice orange color
			if l:GetMinutesAfterMidnight() > sunrise_start and l:GetMinutesAfterMidnight() < sunrise_end then
				-- If the time is after sunrise
				print("Sunrise")
				print(math.random(1,10))
			elseif l:GetMinutesAfterMidnight() > sunset_start and l:GetMinutesAfterMidnight() < sunset_end then
				-- Otherwise if it's after sunset
				l.OutdoorAmbient.Color3 = Color3.new(100/255, 80/255, 80/255)
				print("Sunset")
				print(math.random(1,10))
			-- elseif l:GetMinutesAfterMidnight() > sunrise_end and l:GetMinutesAfterMidnight() < sunset_end then
			-- 	print("Day")
			-- else
			-- 	print("Night")
			end
		end
	end
end

print("time_cycle Loaded")

time_cycle()