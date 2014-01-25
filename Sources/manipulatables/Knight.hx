package manipulatables;

import kha.Loader;
import manipulatables.ManipulatableSprite.OrderType;
import manipulatables.UseableSprite;

// Ritter
class Knight extends GuyWithExtinguisher
{
	public function new(px:Int, py:Int) 
	{
		super(px, py, "Knight", Loader.the.getImage("mechanic"));
	}
}