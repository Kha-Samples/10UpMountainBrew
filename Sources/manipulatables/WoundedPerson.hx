package manipulatables;

import kha.Assets;
import kha2d.Direction;
import kha.Image;
import kha2d.Sprite;
import manipulatables.ManipulatableSprite.OrderType;
import manipulatables.UseableSprite;

// Verwundeter
class WoundedPerson extends Director {
	public function new(px: Int, py: Int) {
		super(px, py, "Wounded", Assets.images.boss_hurt, Std.int(192 * 2 / 3), 32 * 2);
		x = px;
		y = py;
	}
}
