package;

import AdventureCursor;
import kha.Button;
import kha.Color;
import kha.Cursor;
import kha.Font;
import kha.FontStyle;
import kha.Game;
import kha.HighscoreList;
import kha.ImageCursor;
import kha.Key;
import kha.Loader;
import kha.LoadingScreen;
import kha.Music;
import kha.Painter;
import kha.Scene;
import kha.Score;
import kha.Configuration;
import kha.Storage;
import kha.Tile;
import kha.Tilemap;

enum Mode {
	Init;
	Game;
}

class BrewingOfTenUp extends Game {
	static var instance : BrewingOfTenUp;
	var highscoreName : String;
	var shiftPressed : Bool;
	private var font: Font;
	var mode : Mode;
	
	public function new() {
		super("Brewing", false);
		instance = this;
		shiftPressed = false;
		highscoreName = "";
		mode = Mode.Init;
	}
	
	public static function getInstance() : BrewingOfTenUp {
		return instance;
	}
	
	public override function init(): Void {
		Level.load("level1", initLevel);
	}

	public function initLevel(): Void {
		font = Loader.the.loadFont("Arial", new FontStyle(false, false, false), 12);
		startGame();
	}
	
	public function startGame() {
		//getHighscores().load(Storage.defaultFile());
		
		Inventory.init();
		Inventory.pick(new UseableSprite(Loader.the.getImage("pizza_pixel"), "pizza"));
		Jumpman.getInstance().reset();
		Scene.the.addHero(Jumpman.getInstance());
		Configuration.setScreen(this);
		adventureCursor = new AdventureCursor();
		kha.Sys.mouse.pushCursor(adventureCursor);
		mode = Mode.Game;
	}
	
	public override function update() {
		currentOrder.update();
		super.update();
		if (Jumpman.getInstance() == null) return;
		Scene.the.camx = Std.int(Jumpman.getInstance().x) + Std.int(Jumpman.getInstance().width / 2);
	}
	
	public override function render(painter : Painter) {
		if (Jumpman.getInstance() == null) return;
		painter.setFont(font);
		switch (mode) {
		case Init:
				// Nothing todo yet.
		case Game:
			super.render(painter);
			painter.translate(0, 0);
			painter.setColor(Color.fromBytes(0, 0, 0));
			painter.drawString("Score: " + Std.string(Jumpman.getInstance().getScore()), 20, 25);
			painter.drawString("Round: " + Std.string(Jumpman.getInstance().getRound()), width - 100, 25);
			Inventory.paint(painter);
			//break;
		}
	}

	override public function buttonDown(button : Button) : Void {
		switch (mode) {
		case Game:
			switch (button) {
			case UP, BUTTON_1, BUTTON_2:
				Jumpman.getInstance().setUp();
			case LEFT:
				Jumpman.getInstance().left = true;
			case RIGHT:
				Jumpman.getInstance().right = true;
			default:
			}
		default:
		}
	}
	
	override public function buttonUp(button : Button) : Void {
		switch (mode) {
		case Game:
			switch (button) {
			case UP, BUTTON_1, BUTTON_2:
				Jumpman.getInstance().up = false;
			case LEFT:
				Jumpman.getInstance().left = false;
			case RIGHT:
				Jumpman.getInstance().right = false;
			default:
			}	
		default:
		}
	}
	
	override public function keyDown(key: Key, char: String) : Void {
		if (key == Key.CHAR) {

		}
		else {
			if (key == SHIFT) shiftPressed = true;
		}
	}
	
	override public function keyUp(key : Key, char : String) : Void {
		if (key != null && key == Key.SHIFT) shiftPressed = false;
	}
	
	public var adventureCursor(default, null) : AdventureCursor;
	public var currentOrder(default, null) : MouseOrder = new MouseOrder();
	
	override public function mouseUp(x:Int, y:Int) : Void {
		switch (mode) {
		case Mode.Game:
			currentOrder.type = adventureCursor.hoveredType;
			currentOrder.x = x + scene.screenOffsetX;
			currentOrder.y = y + scene.screenOffsetY;
			currentOrder.object = adventureCursor.hoveredObject;
		default:
		}
	}
	
	override public function rightMouseDown(x:Int, y:Int) : Void {
		switch (mode) {
		case Mode.Game:
			Jumpman.getInstance().setUp();
		default:
		}
	}
	override public function rightMouseUp(x:Int, y:Int) : Void {
		switch (mode) {
		case Mode.Game:
			Jumpman.getInstance().up = false;
		default:
		}
	}
}

class MouseOrder {
	public function new() { }
	public var type : OrderType = Nothing;
	public var x : Int = 0;
	public var y : Int = 0;
	public var object : UseableSprite = null;
	
	public function update() {
		var jmpMan = Jumpman.getInstance();
		switch(type) {
		case Nothing:
			// Nothing to do
		case MoveTo:
			if (x < jmpMan.x + 0.3 * jmpMan.width) {
				jmpMan.left = true;
				jmpMan.right = false;
			} else if (jmpMan.x + 0.7 * jmpMan.width < x) {
				jmpMan.left = false;
				jmpMan.right = true;
			} else {
				type = Nothing;
				jmpMan.left = false;
				jmpMan.right = false;
			}
		case Take:
			if (x < jmpMan.x + 0.3 * jmpMan.width) {
				jmpMan.left = true;
				jmpMan.right = false;
			} else if (jmpMan.x + 0.7 * jmpMan.width < x) {
				jmpMan.left = false;
				jmpMan.right = true;
			} else {
				type = Nothing;
				jmpMan.left = false;
				jmpMan.right = false;
				// TODO: take
			}
		case InventoryItem:
			Inventory.select(object);
			type = Nothing;
		}
	}
}
