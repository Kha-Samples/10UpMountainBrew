package;

import kha.Assets;
import kha.Color;
import kha.Font;
import kha.FontStyle;
import kha.graphics2.Graphics;
import kha2d.Scene;
import kha2d.Sprite;

class BlaBox {
	private static var left: Bool;
	private static var pointed: Sprite;
	private static var font: Font;
	private static var fontSize: Int;
	private static var text: String = null;
	
	public static function pointAt(sprite: Sprite): Void {
		pointed = sprite;
	}
	
	public static function setText(text: String): Void {
		if (text != null) {
			BlaBox.text = Localization.getText(text);
		} else {
			BlaBox.text = null;
		}
	}
	
	public static function render(g: Graphics): Void {
		if (pointed == null || text == null) return;
		if (font == null) {
			font = Assets.fonts.LiberationSans_Regular;
			fontSize = 20;
		}
		
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
	
		g.color = Color.White;
		g.fillRect(x, 300, 400, 100);
		g.color = Color.Black;
		g.drawRect(x, 300, 400, 100, 4);
		g.color = Color.White;
		g.fillTriangle(sx - 5, 400 - 5, sx + 5, 400 - 5, sx, 420);
		g.color = Color.Black;
		g.drawLine(sx - 5, 400 - 5, sx, 420, 4);
		g.drawLine(sx + 5, 400 - 5, sx, 420, 4);
		g.font = font;
		g.fontSize = fontSize;
		
		var tx: Float = x + 10;
		var ty: Float = 300 + 10;
		var t = 0;
		var word = "";
		var first = true;
		while (t < text.length + 1) {
			if (text.length == t || text.charAt(t) == " ") {
				var txnext: Float = 0;
				if (first) txnext = tx + font.width(fontSize, word);
				txnext = tx + font.width(fontSize, " ") + font.width(fontSize, word);
				if (txnext > x + 380) {
					tx = x + 10;
					ty += font.height(fontSize);
					g.drawString(word, tx, ty);
					tx = tx + font.width(fontSize, word);
				}
				else {
					if (first) g.drawString(word, tx, ty);
					else g.drawString(" " + word, tx, ty);
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
