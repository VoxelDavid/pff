--[[
  This module aims to make the already pretty straightforward Gui Tweening even
  easier with some JavaScript style parameters.

  With the way extra parameters are passed to the tweening functions you can
  have them in any order you like.

  Example usage:

    local frame = script.Parent.Frame

    Tween:position(frame, {.325, .2}, {
      easingStyle = "Elastic",
      speed = 3,
      override = true
    })

  ToDo:
  - Shorthand options. Eg. {"Out", "Quad", 1, true}
  - Allowing the Offset to be omitted from UDim. Eg. {.325, .2}
]]

local Tween = {
  options = {
    easingDirection = "Out", -- http://wiki.roblox.com/index.php?title=EasingDirection
    easingStyle = "Quad",    -- http://wiki.roblox.com/index.php?title=EasingStyle
    speed = 1,
    override = false,
    callback = nil
  },

  position = function(self, gui, udim, options)
    local options = merge(options, self.options) or self.options
    local position = UDim2.new(unpack(udim))

    gui:TweenPosition(
      position,
      options.easingDirection,
      options.easingStyle,
      options.speed,
      options.override,
      options.callback
    )
  end
}

--[[
  Combines two tables together, overriding key/value pairs if nessecary.
]]
function merge(table1, table2)
  -- http://stackoverflow.com/a/7470789
  for k,v in pairs(table1) do
    table2[k] = v
  end
  return table2
end

return Tween
