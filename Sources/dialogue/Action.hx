package dialogue;

import Dialogue.DialogueItem;
import manipulatables.ManipulatableSprite;

enum ActionType {
	Sleep;
	WakeUp;
}

typedef ActionFinished = Void -> Void;
typedef ActionFunc = Array<ManipulatableSprite> -> ActionType -> ActionFinished -> Void;

class Action implements DialogueItem {
	var sprites : Array<ManipulatableSprite>;
	var type : ActionType;
	var func : ActionFunc;
	public var finished(default, null) : Bool = false;
	public function new(sprites: Array<ManipulatableSprite>, type: ActionType, func: ActionFunc) {
		this.sprites = sprites;
		this.type = type;
		this.func = func;
	}
	
	@:access(Dialogue.isActionActive) 
	public function execute() : Void {
		if (func != null) {
			func(sprites, type, actionFinished);
		} else {
			actionFinished();
		}
	}
	
	@:access(Dialogue.isActionActive) 
	function actionFinished() {
		finished = true;
	}
}
