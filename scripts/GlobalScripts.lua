--[===================================[--
	@Description:
		All of the children of this script are used throughout
		the game by multiple objects.

		Without the functions being global they would have to be copied
		many times throughout the game and if I make a change then I have
		to do that all over again.

		It's not a perfect solution. Some times the scripts used to call
		the global functions need to be edited, but overall this is much
		better than copying a big function everywhere.
--]===================================]--

-- If I am going to destroy scripts after I might want to just do it in each function,
-- just to be sure they get removed AFTER initialization instead of before.
--wait(2)          -- Wait 2 seconds to make sure everything initializes.
--script:Destroy() -- Destroy the scripts to prevent theft