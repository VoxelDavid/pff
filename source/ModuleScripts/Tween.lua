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

    gui:TweenPosition(position)
  end
}

--[[
  Combines two tables together, overriding key/value pairs if nessecary.
]]
function merge(table1, table2)
  -- I tried a simpler method which returned 'table2', but that was overwriting
  -- the original table for whatever reason.

  -- http://stackoverflow.com/a/7470789

  local merge = {}

  for k,v in pairs(table1) do -- Make a copy of table2's values.
    merge[k] = v
  end

  for k,v in pairs(table2) do -- Override the copied values
    merge[k] = v
  end

  return merge
end

return Tween
