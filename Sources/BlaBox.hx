package;

import kha.Color;
import kha.Painter;
import kha.Scene;
import kha.Sprite;

class BlaBox {
	private static var left: Bool;
	private static var pointed: Sprite;
	
	public static function pointAt(sprite: Sprite): Void {
		pointed = sprite;
	}
	
	public static function render(painter: Painter): Void {
		if (pointed == null) pointed = Jumpman.getInstance();
		
		if (pointed.x - Scene.the.screenOffsetX < 400) {
			left = true;
		}
		else {
			left = false;
		}
		
		var x = 380;
		if (left) {
			x = 20;
		}
	
		painter.setColor(Color.fromBytes(255, 255, 255));
		painter.fillRect(x, 300, 400, 100);
		painter.setColor(Color.fromBytes(0, 0, 0));
		painter.drawRect(x, 300, 400, 100, 4);
		painter.setColor(Color.fromBytes(255, 255, 255));
		var sx = pointed.x + pointed.width / 2 - Scene.the.screenOffsetX;
		painter.fillTriangle(sx - 5, 400 - 5, sx + 5, 400 - 5, sx, 420);
		painter.setColor(Color.fromBytes(0, 0, 0));
		painter.drawLine(sx - 5, 400 - 5, sx, 420, 4);
		painter.drawLine(sx + 5, 400 - 5, sx, 420, 4);
	}
}
