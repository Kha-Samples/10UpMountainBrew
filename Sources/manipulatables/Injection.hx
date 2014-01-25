package manipulatables;

import kha.Image;
import kha.Loader;

// Spritze
class Injection extends UseableSprite
{

	public function new(px:Int, py:Int) 
	{
		super("Injection", Loader.the.getImage("pizza_pixel"), px, py);
		
	}
	
}