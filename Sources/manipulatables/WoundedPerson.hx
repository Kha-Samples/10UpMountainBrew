package manipulatables;
import kha.Direction;
import kha.Loader;

import kha.Image;
import kha.Sprite;
import manipulatables.ManipulatableSprite.OrderType;
import manipulatables.UseableSprite;


// Verwundeter
class WoundedPerson extends Director
{
	public function new(px : Int, py : Int) 
	{
		super(px, py, "wounded Person", Loader.the.getImage("pixel_pizza"));
		x = px;
		y = py;
	}
}