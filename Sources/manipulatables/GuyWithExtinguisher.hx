package manipulatables;
import kha.Loader;
import manipulatables.UseableSprite;

import kha.Image;
import kha.Sprite;
import manipulatables.ManipulatableSprite.OrderType;

// Typ mit Feuerlöscher
class GuyWithExtinguisher extends Sprite implements ManipulatableSprite
{

	public function new(px : Int, py : Int) 
	{
		super(Loader.the.getImage("pixel_pizza"));
		
	}
	
	/* INTERFACE manipulatables.ManipulatableSprite */
	
	function get_name():String 
	{
		return "Ms. M";
	}
	
	public var name(get_name, null):String;
	
	public function getOrder(selectedItem:UseableSprite):OrderType 
	{
		if (selectedItem == null) {
			return OrderType.Nothing;
		} else {
			return OrderType.WontWork;
		}
	}
	
	public function executeOrder(order:OrderType):Void 
	{
		
	}
	
}