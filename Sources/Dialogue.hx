package;

import BrewingOfTenUp.Mode;
import kha.Scene;

interface DialogueItem {
	public function execute() : Void;
	public var finished(default, null) : Bool;
}

class Dialogue {
	private static var items: Array<DialogueItem>;
	private static var index: Int;
	public static var isActionActive(default,null): Bool = false;
	
	public static function set(items: Array<DialogueItem>): Void {
		Dialogue.items = items;
		index = -1;
		BrewingOfTenUp.getInstance().mode = Mode.BlaBlaBla;
		kha.Sys.mouse.hide();
		next();
	}
	
	public static function update() : Void {
		if (index >= 0 && !items[index].finished) {
			items[index].execute();
		}
	}
	
	public static function next(): Void {
		if (index >= 0 && !items[index].finished) {
			items[index].execute();
			return;
		}
		
		++index;
		BlaBox.pointAt(null);
		BlaBox.setText(null);
		
		if (index >= items.length) {
			BrewingOfTenUp.getInstance().mode = Mode.Game;
			kha.Sys.mouse.show();
			return;
		}
		
		items[index].execute();
	}
}
