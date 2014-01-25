package;

import kha.AnimatedImageCursor;
import kha.Animation;
import kha.Button;
import kha.Color;
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
	Highscore;
	EnterHighscore;
}

class BrewingOfTenUp extends Game {
	static var instance : BrewingOfTenUp;
	var music : Music;
	var tileColissions : Array<Tile>;
	var map : Array<Array<Int>>;
	var originalmap : Array<Array<Int>>;
	var highscoreName : String;
	var shiftPressed : Bool;
	private var font: Font;
	
	var mode : Mode;
	
	public function new() {
		super("SML", true);
		instance = this;
		shiftPressed = false;
		highscoreName = "";
		mode = Mode.Init;
	}
	
	public static function getInstance() : BrewingOfTenUp {
		return instance;
	}
	
	public override function init(): Void {
		Configuration.setScreen(new LoadingScreen());
		Loader.the.loadRoom("level1", initLevel);
	}

	public function initLevel(): Void {
		font = Loader.the.loadFont("Arial", new FontStyle(false, false, false), 12);
		tileColissions = new Array<Tile>();
		for (i in 0...140) {
			tileColissions.push(new Tile(i, isCollidable(i)));
		}
		var blob = Loader.the.getBlob("level.map");
		var levelWidth: Int = blob.readS32BE();
		var levelHeight: Int = blob.readS32BE();
		originalmap = new Array<Array<Int>>();
		for (x in 0...levelWidth) {
			originalmap.push(new Array<Int>());
			for (y in 0...levelHeight) {
				originalmap[x].push(blob.readS32BE());
			}
		}
		map = new Array<Array<Int>>();
		for (x in 0...originalmap.length) {
			map.push(new Array<Int>());
			for (y in 0...originalmap[0].length) {
				map[x].push(0);
			}
		}
		music = Loader.the.getMusic("level1");
		startGame();
	}
	
	public function startGame() {
		getHighscores().load(Storage.defaultFile());
		if (Jumpman.getInstance() == null) new Jumpman(music);
		Scene.the.clear();
		Scene.the.setBackgroundColor(Color.fromBytes(255, 255, 255));
		var tilemap : Tilemap = new Tilemap("sml_tiles", 32, 32, map, tileColissions);
		Scene.the.setColissionMap(tilemap);
		Scene.the.addBackgroundTilemap(tilemap, 1);
		var TILE_WIDTH : Int = 32;
		var TILE_HEIGHT : Int = 32;
		for (x in 0...originalmap.length) {
			for (y in 0...originalmap[0].length) {
				switch (originalmap[x][y]) {
				case 15:
					map[x][y] = 0;
					Scene.the.addEnemy(new Gumba(x * TILE_WIDTH, y * TILE_HEIGHT));
				case 16:
					map[x][y] = 0;
					Scene.the.addEnemy(new Koopa(x * TILE_WIDTH, y * TILE_HEIGHT - 16));
				case 17:
					map[x][y] = 0;
					Scene.the.addEnemy(new Fly(x * TILE_WIDTH - 32, y * TILE_HEIGHT - 8));
				case 46:
					map[x][y] = 0;
					Scene.the.addEnemy(new Coin(x * TILE_WIDTH, y * TILE_HEIGHT));
				case 52:
					map[x][y] = 52;
					Scene.the.addEnemy(new Exit(x * TILE_WIDTH, y * TILE_HEIGHT));
				case 56:
					map[x][y] = 1;
					Scene.the.addEnemy((new BonusBlock(x * TILE_WIDTH, y * TILE_HEIGHT)));
				default:
					map[x][y] = originalmap[x][y];
				}
			}
		}
		music.play();
		Inventory.init();
		Inventory.pick(new UseableSprite(Loader.the.getImage("pizza_pixel")));
		Jumpman.getInstance().reset();
		Scene.the.addHero(Jumpman.getInstance());
		Configuration.setScreen(this);
		mode = Mode.Game;
	}
	
	public function showHighscore() {
		Scene.the.clear();
		mode = Mode.EnterHighscore;
		music.stop();
	}
	
	private static function isCollidable(tilenumber : Int) : Bool {
		switch (tilenumber) {
		case 1: return true;
		case 6: return true;
		case 7: return true;
		case 8: return true;
		case 26: return true;
		case 33: return true;
		case 39: return true;
		case 48: return true;
		case 49: return true;
		case 50: return true;
		case 53: return true;
		case 56: return true;
		case 60: return true;
		case 61: return true;
		case 62: return true;
		case 63: return true;
		case 64: return true;
		case 65: return true;
		case 67: return true;
		case 68: return true;
		case 70: return true;
		case 74: return true;
		case 75: return true;
		case 76: return true;
		case 77: return true;
		case 84: return true;
		case 86: return true;
		case 87: return true;
		default:
			return false;
		}
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
		case Highscore:
			painter.setColor(Color.fromBytes(255, 255, 255));
			painter.fillRect(0, 0, width, height);
			painter.setColor(Color.fromBytes(0, 0, 0));
			var i : Int = 0;
			while (i < 10 && i < getHighscores().getScores().length) {
				var score : Score = getHighscores().getScores()[i];
				painter.drawString(Std.string(i + 1) + ": " + score.getName(), 100, i * 30 + 100);
				painter.drawString(" -           " + Std.string(score.getScore()), 200, i * 30 + 100);
				++i;
			}
			//break;
		case EnterHighscore:
			painter.setColor(Color.fromBytes(255, 255, 255));
			painter.fillRect(0, 0, width, height);
			painter.setColor(Color.fromBytes(0, 0, 0));
			painter.drawString("Enter your name", width / 2 - 100, 200);
			painter.drawString(highscoreName, width / 2 - 50, 250);
			//break;
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
			if (mode == Mode.EnterHighscore) {
				if (highscoreName.length < 20) highscoreName += shiftPressed ? char.toUpperCase() : char.toLowerCase();
			}
		}
		else {
			if (highscoreName.length > 0) {
				switch (key) {
				case ENTER:
					getHighscores().addScore(highscoreName, Jumpman.getInstance().getScore());
					getHighscores().save(Storage.defaultFile());
					mode = Mode.Highscore;
				case BACKSPACE:
					highscoreName = highscoreName.substr(0, highscoreName.length - 1);
				default:
				}
			}
			if (key == SHIFT) shiftPressed = true;
		}
	}
	
	override public function keyUp(key : Key, char : String) : Void {
		if (key != null && key == Key.SHIFT) shiftPressed = false;
	}
	
	public var currentOrder(default, null) : MouseOrder = new MouseOrder();
	public var hoveringType(default, null) : OrderType = OrderType.Nothing;
	public var hoveringUseable(default, null) : UseableSprite = null; 
	
	override public function mouseMove(x:Int, y:Int) : Void  {
		switch (mode) {
		case Mode.Game:
			hoveringUseable = Inventory.getItemBelowPoint(x, y);
			if (hoveringUseable != null) {
				hoveringType = InventoryItem;
			} else {
				var worldX = x + scene.screenOffsetX;
				var worldY = y + scene.screenOffsetY;
				var jmpMan = Jumpman.getInstance();
				if (jmpMan != null) {
					hoveringType = Nothing;
					if (worldX < jmpMan.x || jmpMan.x + jmpMan.width < worldX) {
						hoveringType = MoveTo;
					}
					for (hero in scene.getHeroesBelowPoint(worldX, worldY)) {
						if (Std.is(hero, UseableSprite)) {
							hoveringUseable = cast hero;
							hoveringType = Take;
							break;
						}
					}
				}
			}
		default:
		}
	}
	override public function mouseUp(x:Int, y:Int) : Void {
		switch (mode) {
		case Mode.Game:
			currentOrder.type = hoveringType;
			currentOrder.x = x + scene.screenOffsetX;
			currentOrder.y = y + scene.screenOffsetY;
			currentOrder.object = hoveringUseable;
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

enum OrderType {
	Nothing;
	MoveTo;
	Take;
	InventoryItem;
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
