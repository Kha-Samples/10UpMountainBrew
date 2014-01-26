package;

import kha.Scene;

interface DialogueItem {
	public function execute() : Void;
	public var finished(default, null) : Bool;
}

class Dialogue {
	private static var items: Array<DialogueItem>;
	private static var index: Int;
	public static var active: Bool = false;
	public static var isActionActive(default,null): Bool = false;
	
	public static function set(items: Array<DialogueItem>): Void {
		Dialogue.items = items;
		index = -1;
		active = true;
		next();
	}
	
	public static function next(): Void {
		if (index >= 0 && !items[index].finished) {
			return;
		}
		
		++index;
		BlaBox.pointAt(null);
		BlaBox.setText(null);
		
		if (index >= items.length) {
			active = false;
			return;
		}
		
		items[index].execute();
	}
}
