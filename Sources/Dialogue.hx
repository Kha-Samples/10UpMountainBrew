package;

import kha.Scene;
import kha.Sprite;

class Dialogue {
	private static var texts: Array<String>;
	private static var sprites: Array<Sprite>;
	private static var index: Int;
	public static var active: Bool = false;
	
	public static function set(texts: Array<String>, sprites: Array<Sprite>): Void {
		Dialogue.texts = texts;
		Dialogue.sprites = sprites;
		index = 0;
		active = true;
		next();
	}
	
	public static function next(): Void {
		if (index >= texts.length) {
			active = false;
		}
		BlaBox.pointAt(sprites[index]);
		BlaBox.setText(texts[index]);
		++index;
	}
}
