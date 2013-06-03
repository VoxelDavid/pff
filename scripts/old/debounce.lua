--[===================================[--
  ! This Function no longer in use.
  ! A Global function with debounce can not be used properly.
  ! If you were to call it from multiple scripts it would only work for one.
  ! Added debounce to all functions calls instead to remedy this.

  Used to prevent functions from repeating until they've completed.

  Usage: [Path].[Event]:connect(_G.debounce( [function to call]() ))
  Example: script.Parent.Touched:connect(_G.debounce( onTouched() ))
--]===================================]--

local enabled = false
_G["debounce"] = function(function_to_debounce)
  return function(...)
    if not enabled then
      enabled = true
      function_to_debounce(...)
      enabled = false
    end
  end
end
print("_G.debounce Loaded")