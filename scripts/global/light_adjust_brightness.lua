--[===================================[--
	Dim a light source in the day time.

	I think this will have to be used as a coroutine since
	I'll probably run multiple functions through a while loop.

	How will I go about this? Will I have to add a loop to
	every single function call? I can't think of any other
	way right now.
--]===================================]--

-- I don't think Variables is a function, so if this script doesn't output anything adjust this.
repeat wait() until _G.config

function adjust_brightness()
	-- Called inside of a while loop:

	-- if between start_time and end_time then
		-- fade out lights
	-- else
		-- fade in lights
	-- end
end

print("adjust_brightness Loaded")