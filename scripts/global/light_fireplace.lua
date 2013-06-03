--[===================================[--
	@Calling the Function:
		repeat wait() until _G.light_candle -- Wait for the function to load before calling it.

		local enabled
		local sp = script.Parent

		-- There has to be a better way to pass variables to a global function.
		-- Until I find that solution I'll have to define the variables in the Call script.
		light  = sp.Light.PointLight
		flame  = sp.Light.Fire
		active = sp.Active

		script.Parent.ClickDetector.MouseClick:connect(function()
			if not enabled then
				enabled = true
				_G.light_candle(light, flame, active)
				enabled = false
			end
		end)
--]===================================]--

function _G.light_fireplace(light, flame, active)

end

print("_G.light_fireplace Loaded")