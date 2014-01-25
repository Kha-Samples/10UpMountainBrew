package manipulatables;

import kha.Image;
import kha.Loader;

// Knochensäge
class BoneSaw extends UseableSprite
{
	public function new( px : Int, py : Int) 
	{
		super("Bone Saw", Loader.the.getImage("pizza_pixel"), px, py);
	}
}