package dialogue;

import Dialogue.DialogueItem;
import manipulatables.ManipulatableSprite;

enum ActionType {
	Sleep;
	WakeUp;
}

class Action implements DialogueItem {
	var autoAdvance : Bool = true;
	var started : Bool = false;
	var sprites : Array<ManipulatableSprite>;
	var type : ActionType;
	var counter : Int = 0;
	public var finished(default, null) : Bool = false;
	public function new(sprites: Array<ManipulatableSprite>, type: ActionType) {
		this.sprites = sprites;
		this.type = type;
	}
	
	@:access(Dialogue.isActionActive) 
	public function execute() : Void {
		if (!started) {
			started = true;
			counter = 0;
			switch(type) {
				case ActionType.Sleep:
					for (sprite in sprites) {
						try {
							untyped sprite.sleep();
						} catch (e : Dynamic){ }
					}
				case ActionType.WakeUp:
					for (sprite in sprites) {
						try {
							untyped sprite.unsleep();
						} catch (e : Dynamic){ }
					}
			}
			return;
		} else {
			switch(type) {
				case ActionType.Sleep:
					++counter;
					if (counter < 100) {
						return;
					}
				case ActionType.WakeUp:
						
			}
		}
		actionFinished();
	}
	
	@:access(Dialogue.isActionActive) 
	function actionFinished() {
		finished = true;
		if (autoAdvance) {
			Dialogue.next();
		}
	}
}
