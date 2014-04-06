--[[
  This module aims to make the already pretty straightforward Gui Tweening even
  easier with the use of Tables.

  With the way option parameters are passed to the tweening functions you can
  have them in any order you like.

  Example usage:

    local frame = script.Parent.Frame

    Tween:position(frame, {.325,0, .2,0}, {
      -- Order doesn't matter here.
      easingStyle = "Elastic",
      speed = 3,
      override = true
    })

  You can see the possible options that can go into the second table a few lines
  below this comment, but they are also the same as the default Tweening params.

  Feel free to edit the default options as well, just remember that they will
  apply to everything.

  ToDo:
  - Shorthand options. Eg. {"Out", "Quad", 1, true}
  - Allowing the Offset to be omitted from UDim. Eg. {.325, .2}
]]

local Tween = {
  options = {
    easingDirection = "Out", -- http://wiki.roblox.com/index.php?title=EasingDirection
    easingStyle = "Quad",    -- http://wiki.roblox.com/index.php?title=EasingStyle
    time = 1,
    override = false,
    callback = nil
  },

  position = function(self, gui, udim, options)
    local opts = merge(options, self.options) or self.options
    local position = UDim2.new(unpack(udim))

    gui:TweenPosition(position, opts.easingDirection, opts.easingStyle, opts.time, opts.override, opts.callback)
  end,

  size = function(self, gui, udim, options)
    local opts = merge(options, self.options) or self.options
    local position = UDim2.new(unpack(udim))

    gui:TweenSize(position, opts.easingDirection, opts.easingStyle, opts.time, opts.override, opts.callback)
  end,

  sizeAndPosition = function(self, gui, udimSize, udimPos, options)
    local opts = merge(options, self.options) or self.options
    local size = UDim2.new(unpack(udimSize))
    local position = UDim2.new(unpack(udimPos))

    gui:TweenSizeAndPosition(position, size, opts.easingDirection, opts.easingStyle, opts.time, opts.override, opts.callback)
  end
}

--[[
  Combines two tables together, overriding key/value pairs if nessecary.
]]
function merge(options, defaultOptions)
  local mergedOptions = {}

  if options then
    for k,v in pairs(defaultOptions) do
      mergedOptions[k] = v
    end

    for k,v in pairs(options) do
      mergedOptions[k] = v
    end

    return mergedOptions
  else
    return false
  end
end

return Tween
