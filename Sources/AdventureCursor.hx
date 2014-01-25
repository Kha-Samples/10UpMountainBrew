package;

import kha.AnimatedImageCursor;
import kha.Animation;
import kha.Color;
import kha.Font;
import kha.FontStyle;
import kha.Loader;
import kha.Painter;
import kha.Scene;
import kha.Sprite;

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
			drawTooltip(painter, inventoryItem.name, x, y - 16);
		}
		else {
			var worldX = x + Scene.the.screenOffsetX;
			var worldY = y + Scene.the.screenOffsetY;
			var items = Scene.the.getHeroesBelowPoint(worldX, worldY);
			if (items.length > 0) {
				var item: Sprite = items[0];
				if (Std.is(item, UseableSprite)) {
					drawTooltip(painter, cast(item, UseableSprite).name, x, y + 32);
				}
			}
		}
	}
	
	private function drawTooltip(painter: Painter, tip: String, x: Int, y: Int): Void {
		painter.setColor(Color.fromBytes(0, 0, 0));
		painter.fillRect(x - 2, y - 2, font.stringWidth(tip) + 4, font.getHeight() + 4);
		painter.setColor(Color.fromBytes(255, 255, 255));
		painter.drawString(tip, x, y);
	}
}
