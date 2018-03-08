package manipulatables;

import kha.Assets;

class Extinguisher extends UseableSprite {
	public function new(px: Int, py: Int) {
		super("Extinguisher", Assets.images.extinguisher, px, py);
		z = 3;
	}
}
