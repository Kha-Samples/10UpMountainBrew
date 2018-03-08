package dialogue;

import dialogue.Action;
import kha2d.Sprite;
import manipulatables.ManipulatableSprite;

class ActionWithBla extends Action {
	var bla : Bla;
	
	public function new(bla : Bla, sprites: Array<ManipulatableSprite>, type: ActionType) {
		super(sprites, type);
		this.bla = bla;
		autoAdvance = false;
	}
	
	override public function execute():Void 
	{
		if (!started) {
			bla.execute();
		}
		super.execute();
	}
}
