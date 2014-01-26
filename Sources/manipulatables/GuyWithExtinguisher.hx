package manipulatables;
import dialogue.Bla;
import kha.Animation;
import kha.Loader;
import kha.Rectangle;
import kha.Scene;
import manipulatables.UseableSprite;

import kha.Image;
import kha.Sprite;
import manipulatables.ManipulatableSprite.OrderType;

// Typ mit Feuerlöscher
class GuyWithExtinguisher extends Sprite implements ManipulatableSprite
{
	private var danceAnimation: Animation;
	private var repairLeftAnimation: Animation;
	private var repairRightAnimation: Animation;
	private var walkLeft: Animation;
	private var walkRight: Animation;
	private var standLeft: Animation;
	private var standRight: Animation;
	private var jumpLeft: Animation;
	private var jumpRight: Animation;

	public function new(px : Int, py : Int, name : String = null, image : Image = null) 
	{
		if (image == null) {
			image = Loader.the.getImage("mechanic");
		}
		super(image, Std.int(410 / 10) * 2, Std.int(455 / 7) * 2);
		x = px;
		y = py - 40;
		
		if (name == null) {
			this.name = "Mechanic";
		} else {
			this.name = name;
		}
		
		if (this.image == image) {
			collider = new Rectangle(20, 30, 41 * 2 - 40, (65 - 1) * 2 - 30);
			walkLeft = Animation.createRange(11, 18, 4);
			walkRight = Animation.createRange(1, 8, 4);
			standLeft = Animation.create(10);
			standRight = Animation.create(0);
			jumpLeft = Animation.create(12);
			jumpRight = Animation.create(2);
			
			danceAnimation = new Animation([40,40,40,40,40,40,40,40,40,40,
41,41,41,41,41,41,41,41,41,41,
40,40,40,40,40,40,40,40,40,40,
41,41,41,41,41,41,41,41,41,41,
40,40,40,40,40,40,40,40,40,40,

42,42,42,42,42,42,42,42,42,42,
43,43,43,43,43,43,43,43,43,43,
42,42,42,42,42,42,42,42,42,42,
43,43,43,43,43,43,43,43,43,43,
40,40,40,40,40,40,40,40,40,40,

44,44,44, 45,45,45, 46,46,46, 47,47,47,
44,44,44, 45,45,45, 46,46,46, 47,47,47,
48,48,48,48,48,48,48,48,48,48,48,48,
44,44,44, 45,45,45, 46,46,46, 47,47,47,
44,44,44, 45,45,45, 46,46,46, 47,47,47,
49,49,49,49,49,49,49,49,49,49,49,49,

44,44,44, 45,45,45, 46,46,46, 47,47,47,
44,44,44, 45,45,45, 46,46,46, 47,47,47,
48,48,48,48,48,48,48,48,48,48,48,48,
44,44,44, 45,45,45, 46,46,46, 47,47,47,
44,44,44, 45,45,45, 46,46,46, 47,47,47,
49,49,49,49,49,49,49,49,49,49,49,49,

40,40,40,40,40,40,40,40,40,40,

50,50,50,50,50,50,50,50,50,
51,51,51,51,51,51,51,51,51,51,51,51,
50,50,50,50,50,50,50,50,50,
51,51,51,51,51,51,51,51,51,51,51,51,
50,50,50,50,50,50,50,50,50,
51,51,51,51,51,51,51,51,51,51,51,51,
50,50,50,50,50,50,50,50,50,
51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,51,

40, 40, 40, 40, 40, 40, 40, 40, 40, 40], 2);
		}
	}
	
	/* INTERFACE manipulatables.ManipulatableSprite */
	
	function get_name():String 
	{
		return name;
	}
	
	public var name(get_name, null):String;
	
	public var firstTime = true;
	public function getOrder(selectedItem:UseableSprite):OrderType 
	{
		if (selectedItem == null) {
			if (firstTime) {
				return OrderType.Bla;
			} else {
				return sprite.getOrder(selectedItem);
			}
		} else {
			return OrderType.WontWork;
		}
	}
	
	var sprite : UseableSprite;
	public function executeOrder(order:OrderType):Void 
	{
		var jmpMan = Jumpman.getInstance();
		if (order == OrderType.Bla) {
			firstTime = false;
			if (jmpMan.hasHelmet) {
				firstTime = false;
				Dialogue.set([new Bla("L2A_Squire_1a", jmpMan),
							  new Bla("L2A_Squire_1b", jmpMan),
							  new Bla("L2A_Squire_1c", jmpMan),
							  new Bla("L2A_Squire_1d", this)]);
			}
		} else if (order == OrderType.Take) {
			sprite.executeOrder(order);
		}
	}
	
	public function spawnItem() : Void {
		if (name == "Squire") {
			sprite = new Sword(Std.int(x), Std.int(y)); // TODO: set position and orientation and animation?
		} else {
			sprite = new Extinguisher(Std.int(x), Std.int(y)); // TODO: set position and orientation and animation?
		}
		sprite.guy = this;
		Scene.the.addHero(sprite);
	}
}