package;

import kha.AnimatedImageCursor;
import kha.Color;
import kha.Font;
import kha.FontStyle;
import kha.Loader;
import kha.Painter;
import kha.Scene;
import kha.Sprite;

class BlaBox {
	private static var left: Bool;
	private static var pointed: Sprite;
	private static var font: Font;
	private static var text: String = null;
	
	public static function pointAt(sprite: Sprite): Void {
		pointed = sprite;
	}
	
	public static function setText(text: String): Void {
		BlaBox.text = text;
	}
	
	public static function render(painter: Painter): Void {
		if (pointed == null || text == null) return;
		if (font == null) font = Loader.the.loadFont("Liberation Sans", new FontStyle(false, false, false), 30);
		
		var sx = pointed.x + pointed.width / 2 - Scene.the.screenOffsetX;
		
		if (sx < 400) {
			left = true;
		}
		else {
			left = false;
		}
		
		var x: Float = 380;
		if (left) {
			x = 20;
		}
	
		painter.setColor(Color.fromBytes(255, 255, 255));
		painter.fillRect(x, 300, 400, 100);
		painter.setColor(Color.fromBytes(0, 0, 0));
		painter.drawRect(x, 300, 400, 100, 4);
		painter.setColor(Color.fromBytes(255, 255, 255));
		painter.fillTriangle(sx - 5, 400 - 5, sx + 5, 400 - 5, sx, 420);
		painter.setColor(Color.fromBytes(0, 0, 0));
		painter.drawLine(sx - 5, 400 - 5, sx, 420, 4);
		painter.drawLine(sx + 5, 400 - 5, sx, 420, 4);
		
		var tx: Float = x + 10;
		var ty: Float = 300 + 10;
		var t = 0;
		var word = "";
		var first = true;
		while (t < text.length + 1) {
			if (text.length == t || text.charAt(t) == " ") {
				var txnext: Float = 0;
				if (first) txnext = tx + font.stringWidth(word);
				txnext = tx + font.stringWidth(" ") + font.stringWidth(word);
				if (txnext > x + 380) {
					tx = x + 10;
					ty += font.getHeight();
					painter.drawString(word, tx, ty);
					tx = tx + font.stringWidth(word);
				}
				else {
					if (first) painter.drawString(word, tx, ty);
					else painter.drawString(" " + word, tx, ty);
					tx = txnext;
				}
				word = "";
			}
			else {
				word += text.charAt(t);
			}
			++t;
		}
	}
}
