This folder holds all Global functions used throughout the game.

Each function has it's own file to make them easy to maintain and manage.

Using a Global Function:

+ Prerequisites:
	+ Make sure `GlobalScripts` exists inside the Workspace of the game.
	+ If the `config` script does not exist as a child of GlobalScripts add it and paste in config.lua's contents.
+ Add a new script as a child of GlobalScripts and paste the global function you want inside the new script.
+ Make a new script in the area you want to call the function from.
+ Take the Call function included in the global function's documentation and paste it into the new script.
+ And edit the connection to fit your needs if you're deviating from the default.
