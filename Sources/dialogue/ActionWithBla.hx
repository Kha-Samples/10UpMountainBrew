package dialogue;

import dialogue.Action;
import kha.Sprite;
import manipulatables.ManipulatableSprite;

class ActionWithBla extends Action {
	var bla : Bla;
	
	public function new(bla : Bla, sprites: Array<ManipulatableSprite>, type: ActionType, func: ActionFunc) {
		super(sprites, type, func);
		this.bla = bla;
		autoAdvance = false;
	}
	
	override public function execute():Void 
	{
		super.execute();
		bla.execute();
	}
}
