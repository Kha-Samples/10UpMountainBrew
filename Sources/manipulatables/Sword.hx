package manipulatables;

import kha.Assets;
import dialogue.Bla;
import manipulatables.UseableSprite;
import kha.Image;
import manipulatables.ManipulatableSprite.OrderType;

// Schwert
class Sword extends UseableSprite
{
	public function new( px : Int, py : Int) 
	{
		super("Sword", Assets.images.sword, px, py);
		z = 3;
	}
	
	override public function getOrder(selectedItem:UseableSprite):OrderType 
	{
		if ( GuyWithExtinguisher.the.firstTime ) {
			return GuyWithExtinguisher.the.getOrder(selectedItem);
		}
		return super.getOrder(selectedItem);
	}
	
	override public function executeOrder(order:OrderType):Void 
	{
		if (order == OrderType.Bla) {
			GuyWithExtinguisher.the.executeOrder(order);
			return;
		} else if (order == OrderType.Take) {
			Dialogue.set([new Bla("L2A_Squire_2", Jumpman.getInstance())]);
		}
		super.executeOrder(order);
	}
}
