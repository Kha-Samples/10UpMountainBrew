package manipulatables;

import kha.Loader;

// Pizza
class Pizza extends UseableSprite
{
	public function new(px : Int, py : Int) {
		super("Pizza", Loader.the.getImage("pizza_pixel"));
		x = px;
		y = py;
	}
	
}