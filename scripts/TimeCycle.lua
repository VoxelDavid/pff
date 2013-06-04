
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
local wait_time = _G.base_wait_time -- (0.06)

function time_cycle()
	if _G.time_cycle_enabled == false then return end
	while wait(wait_time) do
		print(l:GetMinutesAfterMidnight()) -- Print the current time to the output (Testing).
		-- Time Cycle
		l:SetMinutesAfterMidnight(l:GetMinutesAfterMidnight() + _G.time_cycle_speed)

		-- If Sunsets and Sunrises should change the ambient color, then:
		if _G.time_cycle_sun_ambient == true then
			sunrise_start = 300
			sunrise_end   = sunrise_start + 60
			sunset_start  = 1020
			sunset_send   = sunset_start + 60

			-- Durring sunrise and sunset make the sky a nice orange color
			if l:GetMinutesAfterMidnight() > sunrise_start and l:GetMinutesAfterMidnight() < sunrise_end then
				-- If the time is after sunrise
				print("Sunrise")
				print(math.random(1,10)) -- Print a random number to show the output is still going.
			elseif l:GetMinutesAfterMidnight() > sunset_start and l:GetMinutesAfterMidnight() < sunset_end then
				-- Otherwise if it's after sunset
				l.OutdoorAmbient = Color3.new(100/255, 80/255, 80/255)
				print("Sunset")
				print(math.random(1,10)) -- Print a random number to show the output is still going.
			end
		end
	end
end

print("time_cycle Loaded")

time_cycle()