package ;

import kha.Image;
import kha.Painter;
import kha.Scene;
import kha.Sprite;

class UseableSprite extends Sprite
{
	public function new(image:Image, width:Int=0, height:Int=0, z:Int=1) {
		super(image, width, height, z);
	}
	
	public function take() {
		Scene.the.removeHero(this);
		Inventory.pick(this);
	}
	
	public function loose(px : Int, py : Int) {
		x = px;
		y = py;
		Scene.the.addHero(this);
	}
	
	public function renderForInventory(painter : Painter, x : Int, y : Int, drawWidth : Int, drawHeight : Int) {
		if (image != null) {
			painter.drawImage2(image, Std.int(animation.get() * width) % image.width, Math.floor(animation.get() * width / image.width) * height, width, height, x, y, drawWidth, drawHeight, null);
		}
	}
}
