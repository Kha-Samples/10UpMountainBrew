package;

import kha.AnimatedImageCursor;
import kha.Animation;
import kha.Color;
import kha.Font;
import kha.FontStyle;
import kha.Loader;
import kha.Painter;

class AdventureCursor extends AnimatedImageCursor {
	private var font: Font;
	private var tip: String;
	
	public function new() {
		super(Loader.the.getImage("gumba"), Std.int(96 / 3), 32, new Animation([0, 2], 14), 16, 16);
		font = Loader.the.loadFont("Arial", new FontStyle(false, false, false), 12);
		tip = null;
	}
	
	override public function render(painter: Painter, x: Int, y: Int): Void {
		super.render(painter, x, y);
		var inventoryItem = Inventory.getItemBelowPoint(x, y);
		if (inventoryItem != null) {
			painter.setColor(Color.fromBytes(0, 0, 0));
			painter.fillRect(x - 2, y - 16 - 2, font.stringWidth(inventoryItem.name) + 4, font.getHeight() + 4);
			painter.setColor(Color.fromBytes(255, 255, 255));
			painter.drawString(inventoryItem.name, x, y - 16);
		}
	}
}
