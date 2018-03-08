package;

import kha.Image;

class ImageCursor implements Cursor {
	public function new(img: Image, width: Int, height: Int) {

	}

	public var clickX(get, never): Int;

	function get_clickX(): Int {
		return 0;
	}

	public var clickY(get, never): Int;

	function get_clickY(): Int {
		return 0;
	}
	
	public var width(get, never): Int;

	function get_width(): Int {
		return 10;
	}
	
	public var height(get, never): Int;

	function get_height(): Int {
		return 10;
	}
	
	public function render(g: kha.graphics2.Graphics, x: Int, y: Int): Void {

	}
	
	public function update(x: Int, y: Int): Void {

	}
}
