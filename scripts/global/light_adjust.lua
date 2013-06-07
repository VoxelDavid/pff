--[===================================[--
	Dim a light source in the day time.

	How will I go about this? Will I have to add a loop to
	every single function call? I can't think of any other
	way right now.

	The call script needs to have the while loop inside of it. I can't execute
	the while loop somewhere else... Only problem with this is that I want the
	brightness adjustment to happen very quickly, but I want the flicker to
	only happen a few times a second to optimize performance... Hmm
--]===================================]--

repeat wait() until _G.config -- Wait for the configuration file before doing anything else.

function _G.light_adjust(light)
	local conf = game.Configuration
	local times = {
		sunset  = conf.time_sunset,
		sunrise = conf.time_sunrise,
		day     = conf.time_day,
		night   = conf.time_night,
	}

	print(math.random(1,10))
	for i,v_ in pairs(times) do
		print(times[i], times[i].Value)
	end

	if times.sunset.Value == true or times.night.Value == true then
		-- Code
	else
		-- Code
	end
end

print("_G.light_adjust Loaded")

_G.light_adjust() -- Call the function for testing.