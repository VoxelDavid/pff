--[===================================[--
	Description:
		All of the children of this script are used throughout
		the game by multiple objects.

		Without the functions being global they would have to be copied
		many times throughout the game and if a change is made, then all
		scripts containging the function need to be updated.

		It's not a perfect solution. Some times the scripts used to call
		the global functions need to be edited, but overall this is much
		better than copying a big function everywhere.
--]===================================]--