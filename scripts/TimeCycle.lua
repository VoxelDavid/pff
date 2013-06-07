
-- Ambient        : 44,44,44
-- Brightness     : 1.5
-- OutdoorAmbient : 80,80,80

--[===================================[--
	@Description
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
			local sunrise_start = 300
			local sunrise_end   = sunrise_start + 60
			local sunset_start  = 1020
			local sunset_send   = sunset_start + 60

			-- Durring sunrise and sunset make the sky a nice orange color
			if l:GetMinutesAfterMidnight() > sunrise_start and l:GetMinutesAfterMidnight() < sunrise_end then
				-- If the time is after sunrise
			elseif l:GetMinutesAfterMidnight() > sunset_start and l:GetMinutesAfterMidnight() < sunset_end then
				-- Otherwise if it's after sunset
				l.OutdoorAmbient = Color3.new(100/255, 80/255, 80/255)
			end
		end
	end
end

print("time_cycle Loaded")

time_cycle()