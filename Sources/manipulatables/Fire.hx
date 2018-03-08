package manipulatables;

import kha.Assets;
import kha2d.Sprite;
import manipulatables.UseableSprite;
import manipulatables.ManipulatableSprite.OrderType;

// Feuer
class Fire extends Sprite implements ManipulatableSprite {
	public function new(px: Int, py: Int) {
		super(Assets.images.pizza_pixel);
		x = px;
		y = py;
	}
	
	/* INTERFACE manipulatables.ManipulatableSprite */
	
	function get_name(): String {
		return "Fire";
	}
	
	public var name(get_name, null): String;
	
	public function getOrder(selectedItem: UseableSprite): OrderType {
		if (Std.is(selectedItem, Extinguisher)) {
			return OrderType.Extinguish;
		}
		else if (selectedItem != null) {
			return OrderType.WontWork;
		}
		return OrderType.Nothing;
	}
	
	public function executeOrder(order: OrderType): Void {
		
	}
}
