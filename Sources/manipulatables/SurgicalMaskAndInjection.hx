package manipulatables;
import dialogue.Bla;
import kha.Loader;
import manipulatables.ManipulatableSprite.OrderType;
import manipulatables.UseableSprite;



class SurgicalMaskAndInjection extends UseableSprite
{

	public function new(px : Int, py : Int) 
	{
		super("Surgical Mask and Injection", Loader.the.getImage("docstuff"), px, py + 30);
	}
	
	override public function getOrder(selectedItem:UseableSprite):OrderType 
	{
		return OrderType.Take;
	}
	
	override public function executeOrder(order:OrderType):Void 
	{
		if (order == OrderType.Take) {
			var jmpMan = Jumpman.getInstance();
			if (jmpMan.hasHelmet) {
				Dialogue.set([new Bla("TakeMask_Helmet", jmpMan)]);
			} else {
				kha.Scene.the.removeHero(this);
				jmpMan.hasSurgicalMask = true;
				Jumpman.getInstance().doc();
				Dialogue.set([new Bla("TakeMask", jmpMan)]);
				super.executeOrder(order);
			}
		}
	}
}