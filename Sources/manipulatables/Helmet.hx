package manipulatables;

import kha.Assets;
import dialogue.Bla;
import kha2d.Animation;
import kha2d.Scene;
import manipulatables.UseableSprite;
import kha.Image;
import kha2d.Sprite;
import manipulatables.ManipulatableSprite.OrderType;

// Helm
class Helmet extends Sprite implements ManipulatableSprite
{

	public function new(px : Int, py : Int) 
	{
		super(Assets.images.armor, 72, 70);
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
	
	var take = true;
	public function getOrder(selectedItem:UseableSprite):OrderType 
	{
		if (take) {
			return OrderType.Take;
		}
		return OrderType.Nothing;
	}
	
	public function executeOrder(order:OrderType):Void 
	{
		if (order == OrderType.Take) {
			var jmpMan = Jumpman.getInstance();
			if (jmpMan.hasSurgicalMask) {
				Dialogue.set([new Bla("TakeHelmet_Mask", jmpMan)]);
			} else {
				jmpMan.hasHelmet = true;
				setAnimation(Animation.create(1));
				Jumpman.getInstance().helmet();
				Dialogue.set([new Bla("TakeHelmet", jmpMan)]);
			}
		}
	}
	
}