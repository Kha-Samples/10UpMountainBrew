package;

import kha.Animation;
import kha.Color;
import kha.Game;
import kha.Loader;
import kha.Painter;

class Inventory {
	public static var PORTEMONEIE = 1;
	public static var KEY = 2;
	public static var NOISEMAKER = 3;
	public static var GUN = 4;
	public static var TEETH = 5;
	public static var GLASSES = 6;
	public static var HEARINGAID = 7;
	
	//private static Image image;
	static var sprite : kha.Sprite;
	public static var max : Int = 17;
	public static var width = 37;
	public static var height = 32;
	static var has : Array<Bool> = new Array<Bool>(); // [max];
	static var activated = false;
	static var position = 0;
	static var count = 0;
	
	public static function init() {
		sprite = new kha.Sprite(Loader.the.getImage("Inventory"), width, height, 0);
	}
	
	public static function isEmpty() : Bool {
		return count == 0;
	}
	
	public static function pick(num : Int) {
		has[num] = true;
		++count;
		position = 0;
	}
	
	public static function loose(num : Int) {
		has[num] = false;
		--count;
		position = 0;
	}
	
	public static function activate() {
		activated = true;
	}
	
	public static function deactivate() {
		activated = false;
	}
	
	public static function next() {
		++position;
		if (position >= count - 1) position = count - 1;
	}
	
	public static function previous() {
		--position;
		if (position < 0) position = 0;
	}
	
	public static function current() : Int {
		var currentPosition = 0;
		for (i in 0...max) {
			if (has[i]) {
				if (position == currentPosition) return i;
				++currentPosition;
			}
		}
		return -1;
	}
	
	public static function paint(painter : Painter) {
		var x = 0;
		for (i in 0...max) {
			if (has[i]) x += width;
		}
		var scrollx = 0;
		while (x + scrollx > Game.the.width) scrollx -= width;
		painter.translate(scrollx, 0);
		x = 0;
		for (i in 0...max) {
			if (has[i]) {
				sprite.setAnimation(Animation.create(i));
			}
			else {
				sprite.setAnimation(Animation.create(0));
			}
			sprite.x = x;
			sprite.y = Game.the.height - 32 - 1;
			sprite.render(painter);
			x += width;
		}
		while (x < Game.the.width) {
			sprite.setAnimation(Animation.create(0));
			sprite.x = x;
			sprite.y = Game.the.width - 32 - 1;
			sprite.render(painter);
			x += width;
		}
		if (activated) {
			///int top = ScrollingPanel.getInstance().getHeight() - 32 - 1;
			///int bottom = ScrollingPanel.getInstance().getHeight() - 1;
			painter.setColor(Color.fromBytes(255, 0, 255));
			///painter.drawLine(position * width, top, (position + 1) * width - 1, top);
			///painter.drawLine((position + 1) * width - 1, top, (position + 1) * width - 1, bottom);
			///painter.drawLine((position + 1) * width - 1, bottom, position * width, bottom);
			///painter.drawLine(position * width, bottom, position * width, top);
		}
		//g.drawImage(image, 0, 155, 0);
	}
}
