package;

import AdventureCursor;
import kha.Assets;
import kha.Framebuffer;
import kha.graphics2.Graphics;
import kha.Image;
import kha.math.FastMatrix3;
import kha.Scaler;
import manipulatables.Door;
import manipulatables.ManipulatableSprite;
import manipulatables.Pizza;
import manipulatables.UseableSprite;
import kha.Color;
import kha.Font;
import kha.FontStyle;
//import kha.ImageCursor;
import kha2d.Scene;
import kha.Storage;
import kha2d.Tile;
import kha2d.Tilemap;
import kha.Scheduler;
import kha.System;
import kha.input.KeyCode;

enum Mode {
	Init;
	Game;
	BlaBlaBla;
}

class BrewingOfTenUp {
	public static inline var width = 800;
	public static inline var height = 600;
	static var instance : BrewingOfTenUp;
	private var backbuffer: Image;
	var highscoreName : String;
	var shiftPressed : Bool;
	private var font: Font;
	private var fontSize: Int;
	public var mode : Mode;
	private var scene: Scene;
	
	public function new() {
		instance = this;
		shiftPressed = false;
		highscoreName = "";
		mode = Mode.Init;
		System.init({width: 800, height: 600, title: "Mountain Brew"}, init);
	}
	
	public static function getInstance() : BrewingOfTenUp {
		return instance;
	}
	
	function init(): Void {
		backbuffer = Image.createRenderTarget(800, 600);
		Assets.loadEverything(function () {
			Level.load("level1", initLevel);
			scene = Scene.the;
			System.notifyOnRender(render);
			Scheduler.addTimeTask(update, 0, 1 / 60);
		});
	}

	public function initLevel(): Void {
		font = Assets.fonts.LiberationSans_Regular;
		fontSize = 14;
		startGame();
	}
	
	public function startGame() {
		//getHighscores().load(Storage.defaultFile());
		
		Inventory.init();
		Jumpman.getInstance().reset();
		Scene.the.addHero(Jumpman.getInstance());
		
		adventureCursor = new AdventureCursor();
		Mouse.pushCursor(adventureCursor);
		
		//Dialogue.set(["Hallo", "Holla"], [Jumpman.getInstance(), Jumpman.getInstance()]);
	}
	
	function update() {
		switch (mode) {
			case Mode.Game:
				currentOrder.update();
				scene.update();
				Scene.the.camx = Std.int(Jumpman.getInstance().x) + Std.int(Jumpman.getInstance().width / 2);
			case Mode.BlaBlaBla:
				scene.update();
				Dialogue.update();
				Scene.the.camx = Std.int(Jumpman.getInstance().x) + Std.int(Jumpman.getInstance().width / 2);
			case Mode.Init:
				scene.update();
		}
	}
	
	function render(frame: Framebuffer) {
		if (Jumpman.getInstance() == null) return;
		
		var g = backbuffer.g2;
		g.begin();
		g.font = font;
		switch (mode) {
		case Init:
				// Nothing todo yet.
		case Game, BlaBlaBla:
			scene.render(g);
			g.transformation = FastMatrix3.identity();
			BlaBox.render(g);
			Inventory.paint(g);
			//break;
		}
		Mouse.render(g);
		g.end();
		
		frame.g2.begin();
		Scaler.scale(backbuffer, frame, System.screenRotation);
		frame.g2.end();
	}

	function buttonDown(button: KeyCode) : Void {
		switch (mode) {
		case Game:
			switch (button) {
			case Up, Control:
				Jumpman.getInstance().setUp();
			case Left:
				Jumpman.getInstance().left = true;
			case Right:
				Jumpman.getInstance().right = true;
			default:
			}
		default:
		}
	}
	
	function buttonUp(button: KeyCode) : Void {
		switch (mode) {
		case Game:
			switch (button) {
			case Up, Control:
				Jumpman.getInstance().up = false;
			case Left:
				Jumpman.getInstance().left = false;
			case Right:
				Jumpman.getInstance().right = false;
			default:
			}	
		default:
		}
	}
	
	public var adventureCursor(default, null) : AdventureCursor;
	public var currentOrder(default, null) : MouseOrder = new MouseOrder();
	
	function mouseUp(x:Int, y:Int) : Void {
		switch (mode) {
		case Mode.Game:
			currentOrder.cancel();
			currentOrder.type = adventureCursor.hoveredType;
			currentOrder.x = x + scene.screenOffsetX;
			currentOrder.y = y + scene.screenOffsetY;
			currentOrder.object = adventureCursor.hoveredObject;
		case Mode.BlaBlaBla:
			Dialogue.next();
		default:
		}
	}
	
	function rightMouseDown(x:Int, y:Int) : Void {
		switch (mode) {
		case Mode.Game:
			Jumpman.getInstance().setUp();
		default:
		}
	}
	
	function rightMouseUp(x:Int, y:Int) : Void {
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
	public var object : ManipulatableSprite = null;
	
	public function cancel() : Void {
		var jmpMan = Jumpman.getInstance();
		jmpMan.left = false;
		jmpMan.right = false;
	}
	private function moveTo() : Bool {
		var jmpMan = Jumpman.getInstance();
		if (x < jmpMan.x + 0.3 * jmpMan.width) {
			jmpMan.left = true;
			jmpMan.right = false;
		} else if (jmpMan.x + 0.7 * jmpMan.width < x) {
			jmpMan.left = false;
			jmpMan.right = true;
		} else {
			jmpMan.left = false;
			jmpMan.right = false;
			return false;
		}
		return true;
	}
	public function update() {
		switch(type) {
		case Nothing, ToolTip:
			// Nothing to do
			return;
		case WontWork:
			// TODO: say something
		case MoveTo:
			if (!moveTo()) {
				type = Nothing;
			}
			return;
		case Take, Eat, Enter, Slay, Extinguish, Apply:
			if (moveTo()) {
				return;
			}
		case InventoryItem, Bla:
		}
		object.executeOrder(type);
		type = Nothing;
	}
}
