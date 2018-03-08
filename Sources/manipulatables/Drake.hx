package manipulatables;

import kha.Assets;
import kha2d.Sprite;
import manipulatables.UseableSprite;
import manipulatables.ManipulatableSprite.OrderType;

// (mytischer) Drache
class Drake extends Director {
	public function new(px: Int, py: Int) {
		super(px, py, "Drake", Assets.images.dragon, Std.int(240 * 2 / 3), 64 * 2);
	}
}
