package manipulatables;
import dialogue.Bla;
import manipulatables.UseableSprite;

import kha.Image;
import kha.Loader;
import manipulatables.ManipulatableSprite.OrderType;

// Schwert
class Sword extends UseableSprite
{
	public function new( px : Int, py : Int) 
	{
		super("Sword", Loader.the.getImage("sword"), px, py);
		z = 3;
	}
	
	override public function getOrder(selectedItem:UseableSprite):OrderType 
	{
		if ( guy.firstTime ) {
			return guy.getOrder(selectedItem);
		}
		return super.getOrder(selectedItem);
	}
	
	override public function executeOrder(order:OrderType):Void 
	{
		if ( guy.firstTime ) {
			guy.executeOrder(order);
			return;
		}
		Dialogue.set([new Bla("L2A_Squire_2", Jumpman.getInstance())]);
		super.executeOrder(order);
	}
}