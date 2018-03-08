package manipulatables;

import kha.Assets;
import dialogue.Bla;
import kha2d.Sprite;
import manipulatables.ManipulatableSprite.OrderType;
import manipulatables.UseableSprite;

class SurgicalMaskAndInjection extends Sprite implements ManipulatableSprite
{

	public function new(px : Int, py : Int) 
	{
		super(Assets.images.docstuff);
		x = px;
		y = py + 30;
		accy = 0;
		name = "Surgical Mask and Injection";
	}
	
	function get_name():String 
	{
		return name;
	}
	
	public var name(get_name, null):String;
	
	public function getOrder(selectedItem:UseableSprite):OrderType 
	{
		return OrderType.Take;
	}
	
	public function executeOrder(order:OrderType):Void 
	{
		if (order == OrderType.Take) {
			var jmpMan = Jumpman.getInstance();
			if (jmpMan.hasHelmet) {
				Dialogue.set([new Bla("TakeMask_Helmet", jmpMan)]);
			} else {
				kha2d.Scene.the.removeHero(this);
				jmpMan.hasSurgicalMask = true;
				Jumpman.getInstance().doc();
				Inventory.pick(new Injection(0, 0));
				Dialogue.set([new Bla("TakeMask", jmpMan)]);
			}
		}
	}
}