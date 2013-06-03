--[===================================[--
	Dim a light source in the day time.

	I think this will have to be used as a coroutine since
	I'll probably run multiple functions through a while loop.
--]===================================]--

repeat wait() until _G.variables()

function _G.brightness_adjustments()
	-- Called inside of a while loop:

	-- if between start_time and end_time then
		-- fade out lights
	-- else
		-- fade in lights
	-- end
end

print("_G.brightness_adjustments Loaded")