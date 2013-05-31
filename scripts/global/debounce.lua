[===================================[
  Used to prevent functions from repeating until they've completed.

  Usage: [Path].[Action]:connect(_G.debounce( [function to call]() ))
  Example: script.Parent.Touched:connect(_G.debounce( onTouched() ))
]===================================]

-- I think because it's executing in the Global script it can't be used by other functions.
_G["debounce"] = function(function_to_debounce)
  local enabled = false
  return function(...)
    if not enabled then
      enabled = true
      function_to_debounce(...)
      enabled = false
    end
  end
end