package manipulatables;

import kha.Assets;
import manipulatables.ManipulatableSprite.OrderType;
import manipulatables.UseableSprite;

// Ritter
class Knight extends GuyWithExtinguisher {
	public function new(px:Int, py:Int) {
		super(px, py, "Squire", Assets.images.mechanic);
	}
}
