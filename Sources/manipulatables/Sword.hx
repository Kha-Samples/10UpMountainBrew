package manipulatables;

import kha.Image;
import kha.Loader;

// Schwert
class Sword extends UseableSprite
{
	public function new( px : Int, py : Int) 
	{
		super("Sword", Loader.the.getImage("pizza_pixel"), px, py);
	}
}