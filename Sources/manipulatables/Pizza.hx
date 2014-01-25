package manipulatables;

import kha.Loader;

class Pizza extends UseableSprite
{
	public function new() {
		super("Pizza", Loader.the.getImage("pizza_pixel"));
	}
	
}