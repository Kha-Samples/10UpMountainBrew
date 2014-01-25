package;

import kha.Animation;
import kha.Direction;
import kha.Image;
import kha.Loader;
import kha.Scene;
import kha.Sprite;

class Door extends UseableSprite {	
	public function new(x: Int, y: Int) {
		super(Loader.the.getImage("door"), "Door");
		this.x = x;
		this.y = y;
		accy = 0;
	}
	
	override public function take() {
		Loader.the.loadRoom("level2", initLevel);
	}
	
	private function initLevel(): Void {
		
	}
	
	override public function loose(px: Int, py: Int) {
		
	}
}
