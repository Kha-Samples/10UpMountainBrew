package manipulatables;

import kha.Assets;

class Pizza extends UseableSprite {
	public function new(px : Int, py : Int) {
		super("Pizza", Assets.images.pizza_pixel, px, py);
	}
}
