package manipulatables;

import kha.Image;
import kha.Loader;

// Feuerlöscher
class Extinguisher extends UseableSprite
{
	public function new(px : Int, py : Int) {
		super("Extinguisher", Loader.the.getImage("pizza_pixel"), px, py);
		z = 3;
	}
	
}