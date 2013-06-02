--[===================================[--
	@Calling the function:
		repeat wait() until _G.light_fireplace -- Wait for the function to load before calling it.

		local enabled
		local sp = script.Parent
		script.Parent.ClickDetector.MouseClick:connect(function()
		  if not enabled then
		    enabled = true
		    _G.light_fireplace(sp.Light.PointLight, sp.Light.Fire, sp.Active)
		    enabled = false
		  end
		end)
--]===================================]--

function _G.light_fireplace()
end

print("_G.light_fireplace Loaded")