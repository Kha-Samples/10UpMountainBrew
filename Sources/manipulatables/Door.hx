package manipulatables;

import kha.Animation;
import kha.Direction;
import kha.Image;
import kha.Loader;
import kha.Scene;
import kha.Sprite;
import manipulatables.ManipulatableSprite;

// Tür
class Door extends Sprite implements ManipulatableSprite {
	private static var currentLevel: String = null;
	
	public function new(x: Int, y: Int) {
		super(Loader.the.getImage("door"));
		this.x = x;
		this.y = y;
		accy = 0;
		z = 0;
	}
	
	function get_name() : String {
		return "Door";
	}
	
	public var name(get, null) : String;
	
	public function getOrder(selectedItem : UseableSprite) : OrderType {
		return OrderType.Enter;
	}
	
	public function executeOrder(order : OrderType) : Void {
		var lastLevel = currentLevel;
		// Hackathon
		if (currentLevel == null || currentLevel == "level1") {
			if (Jumpman.getInstance().hasHelmet || Jumpman.getInstance().hasSurgicalMask) {
				currentLevel = "level2";
				Jumpman.getInstance().setSpawn(70);
			}
			else {
				Dialogue.set(["I won't go out naked! I have to get dressed. Or maybe disguise myself."], [Jumpman.getInstance()]);
			}
		}
		else if (currentLevel == "level2") {
			if (x < 200) {
				currentLevel = "level1";
				Jumpman.getInstance().setSpawn(700);
			}
			else {
				currentLevel = "level3";
				Jumpman.getInstance().setSpawn(70);
			}
		}
		else {
			currentLevel = "level2";
			Jumpman.getInstance().setSpawn(1170);
		}
		if (currentLevel != lastLevel) Level.load(currentLevel, initLevel);
	}
	
	public function initLevel() : Void {
		Jumpman.getInstance().reset();
		Scene.the.addHero(Jumpman.getInstance());
	}
}
