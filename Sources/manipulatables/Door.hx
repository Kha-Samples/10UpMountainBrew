package manipulatables;

import kha.Animation;
import kha.Direction;
import kha.Image;
import kha.Loader;
import kha.Scene;
import kha.Sprite;
import manipulatables.ManipulatableSprite;

class Door extends Sprite implements ManipulatableSprite {	
	public function new(x: Int, y: Int) {
		super(Loader.the.getImage("door"));
		this.x = x;
		this.y = y;
		accy = 0;
		z = 0;
	}
	
	public var name(default, null) : String = "Door";
	
	public function getOrder(selectedItem : UseableSprite) : OrderType {
		return OrderType.Enter;
	}
	
	public function executeOrder(order : OrderType) : Void {
		Level.load("level2", initLevel);
	}
	
	public function initLevel() : Void {
		Jumpman.getInstance().reset();
		Scene.the.addHero(Jumpman.getInstance());
	}
}
