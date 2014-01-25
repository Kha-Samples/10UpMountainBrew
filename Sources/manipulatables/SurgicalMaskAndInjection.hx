package manipulatables;
import kha.Loader;
import manipulatables.ManipulatableSprite.OrderType;
import manipulatables.UseableSprite;



class SurgicalMaskAndInjection extends UseableSprite
{

	public function new(px : Int, py : Int) 
	{
		super("Surgical Mask and Injection", Loader.the.getImage("pizza_pixel"), px, py);
	}
	
	override public function getOrder(selectedItem:UseableSprite):OrderType 
	{
		if (!Jumpman.getInstance().hasHelmet) {
			return OrderType.Take;
		} else {
			return OrderType.Nothing;
		}
	}
	
	override public function executeOrder(order:OrderType):Void 
	{
		super.executeOrder(order);
		if (order == OrderType.Take) {
			Jumpman.getInstance().hasSurgicalMask = true;
			name = "Injection";
			// TODO: change image to only injection
		}
	}
}