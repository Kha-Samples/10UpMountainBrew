package manipulatables;

import kha.Image;
import kha.Painter;
import kha.Scene;
import kha.Sprite;
import manipulatables.ManipulatableSprite.OrderType;

class UseableSprite extends Sprite implements ManipulatableSprite
{
	public var isInInventory(default, null) : Bool = false;
	
	public function new(name: String, image: Image, width: Int = 0, height: Int = 0, z: Int = 1) {
		super(image, width, height, z);
		this.name = name;
	}
	
	public var name(default, null) : String;
	
	public function canBeManipulatedWith(item : UseableSprite) : Bool {
		throw "Not implemented.";
	}
	
	public function getOrder(selectedItem : UseableSprite) : OrderType {
		if (isInInventory)
			return OrderType.WontWork;
		else
			return OrderType.Take;
	}
	
	public function take() {
		isInInventory = true;
		Scene.the.removeHero(this);
		Inventory.pick(this);
	}
	
	public function loose(px : Int, py : Int) {
		x = px;
		y = py;
		isInInventory = false;
		Scene.the.addHero(this);
	}
	
	public function renderForInventory(painter : Painter, x : Int, y : Int, drawWidth : Int, drawHeight : Int) {
		if (image != null) {
			painter.drawImage2(image, Std.int(animation.get() * width) % image.width, Math.floor(animation.get() * width / image.width) * height, width, height, x, y, drawWidth, drawHeight, null);
		}
	}
}
