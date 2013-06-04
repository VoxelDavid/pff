--[===================================[--
	@Description:
		All of the children of this script are used throughout
		the game by multiple objects.

		Without the functions being global they would have to be copied
		many times throughout the game and if a change is made, then all
		scripts containging the function need to be updated.

		It's not a perfect solution. Some times the scripts used to call
		the global functions need to be edited, but overall this is much
		better than copying a big function everywhere.

	@Creating a Function:
		repeat wait() until _G.config    -- Wait for the configuration file before doing anything else.

		function _G.function_name()      -- Create the function.
			-- Code
		end

		print("_G.function_name Loaded") -- Output to the console that the script is loaded.
--]===================================]--