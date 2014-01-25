package;
import kha.Color;
import kha.Configuration;
import kha.Game;
import kha.Loader;
import kha.LoadingScreen;
import kha.Scene;
import kha.Tile;
import kha.Tilemap;
import manipulatables.Door;

class Level {
	private static var levelName: String;
	private static var done: Void -> Void;
	
	public static function load(levelName: String, done: Void -> Void): Void {
		Level.levelName = levelName;
		Level.done = done;
		Configuration.setScreen(new LoadingScreen());
		Loader.the.loadRoom(levelName, initLevel);
	}
	
	private static function initLevel(): Void {
		if (Jumpman.getInstance() == null) new Jumpman();

		var tileColissions = new Array<Tile>();
		for (i in 0...140) {
			tileColissions.push(new Tile(i, isCollidable(i)));
		}
		var blob = Loader.the.getBlob(levelName + ".map");
		var levelWidth: Int = blob.readS32BE();
		var levelHeight: Int = blob.readS32BE();
		var originalmap = new Array<Array<Int>>();
		for (x in 0...levelWidth) {
			originalmap.push(new Array<Int>());
			for (y in 0...levelHeight) {
				originalmap[x].push(blob.readS32BE());
			}
		}
		var map = new Array<Array<Int>>();
		for (x in 0...originalmap.length) {
			map.push(new Array<Int>());
			for (y in 0...originalmap[0].length) {
				map[x].push(0);
			}
		}
		var spriteCount = blob.readS32BE();
		var sprites = new Array<Int>();
		for (i in 0...spriteCount) {
			sprites.push(blob.readS32BE());
			sprites.push(blob.readS32BE());
			sprites.push(blob.readS32BE());
		}
		
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
				default:
					map[x][y] = originalmap[x][y];
				}
			}
		}
		
		for (i in 0...spriteCount) {
			var sprite: kha.Sprite;
			switch (sprites[i * 3]) {
			case 0:
				sprite = new Coin(sprites[i * 3 + 1], sprites[i * 3 + 2]);
				Scene.the.addHero(sprite);
			case 1:
				sprite = new Gumba(sprites[i * 3 + 1], sprites[i * 3 + 2]);
				Scene.the.addHero(sprite);
			case 2:
				sprite = new Koopa(sprites[i * 3 + 1], sprites[i * 3 + 2]);
				Scene.the.addHero(sprite);
			case 3:
				sprite = new Fly(sprites[i * 3 + 1], sprites[i * 3 + 2]);
				Scene.the.addHero(sprite);
			case 4:
				sprite = new Door(sprites[i * 3 + 1], sprites[i * 3 + 2]);
				Scene.the.addOther(sprite);
			default:
				trace("That should never happen! We are therefore going to ignore it.");
				continue;
			}
		}
		Configuration.setScreen(BrewingOfTenUp.getInstance());
		done();
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
}
