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
		super(px, py, "wounded Person", Loader.the.getImage("boss_hurt"), Std.int(192 * 2 / 3), 32 * 2);
		x = px;
		y = py;
	}
}