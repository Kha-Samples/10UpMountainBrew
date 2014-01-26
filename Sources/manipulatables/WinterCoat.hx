package manipulatables;
import kha.Loader;
import kha.Scene;
import manipulatables.UseableSprite;

import kha.Image;
import kha.Sprite;
import manipulatables.ManipulatableSprite.OrderType;

// Helm
class WinterCoat extends Sprite implements ManipulatableSprite
{

	public function new(px : Int, py : Int) 
	{
		super(Loader.the.getImage("pizza_pixel"));
		x = px;
		y = py;
		accy = 0;
	}
	
	/* INTERFACE manipulatables.ManipulatableSprite */
	
	function get_name():String 
	{
		return "Helmet";
	}
	
	public var name(get_name, null):String;
	
	public function getOrder(selectedItem:UseableSprite):OrderType 
	{
		return OrderType.Take;
	}
	
	public function executeOrder(order:OrderType):Void 
	{
		if (order == OrderType.Take) {
			Scene.the.removeHero(this);
			Jumpman.getInstance().hasWinterCoat = true; 
			if (Jumpman.getInstance().hasHelmet) Jumpman.getInstance().coatHelmet();
			else Jumpman.getInstance().coatDoc();
		}
	}
	
}