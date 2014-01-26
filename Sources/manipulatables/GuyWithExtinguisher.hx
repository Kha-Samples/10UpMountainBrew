package manipulatables;
import dialogue.Bla;
import kha.Animation;
import kha.Direction;
import kha.Loader;
import kha.math.Vector2;
import kha.Painter;
import kha.Rectangle;
import kha.Rotation;
import kha.Scene;
import manipulatables.UseableSprite;

import kha.Image;
import kha.Sprite;
import manipulatables.ManipulatableSprite.OrderType;

// Typ mit Feuerlöscher
class GuyWithExtinguisher extends Sprite implements ManipulatableSprite
{
	public var left : Bool;
	public var right : Bool;
	public var up : Bool;
	public var lookRight(default, null) : Bool;
	public var walking: Bool = false;
	private var danceAnimation: Animation;
	private var repairLeftAnimation: Animation;
	private var repairRightAnimation: Animation;
	private var walkLeft: Animation;
	private var walkRight: Animation;
	private var standLeft: Animation;
	private var standRight: Animation;
	private var jumpLeft: Animation;
	private var jumpRight: Animation;
	var standing : Bool;
	var killed : Bool;
	var jumpcount : Int;
	var lastupcount : Int;
	var score : Int;
	var round : Int;
	private var zzzzz: Image;
	private var zzzzzIndex: Int = 0;

	static public var the;
	public function new(px : Int, py : Int, name : String = null, image : Image = null) 
	{
		the = this;
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
		
		zzzzz = Loader.the.getImage("zzzzz");
		
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
	
	
	public function getRound() : Int {
		return round;
	}
	
	public function nextRound() {
		++round;
	}
	
	private var baseSpeed = 6.0;
	
	public override function update(): Void {
		walking = false;
		if (lastupcount > 0) --lastupcount;
		
		if (x > 1000) {
			Scene.the.removeHero(this);
			return;
		}
		
		if (killed) {
			++zzzzzIndex;
		} else {
			if (right) {
				if (standing) {
					setAnimation(walkRight);
					walking = true;
				}
				speedx = baseSpeed * Math.round(Math.pow(1.1, getRound()));
				lookRight = true;
			}
			else if (left) {
				if (standing) {
					setAnimation(walkLeft);
					walking = true;
				}
				speedx = -baseSpeed * Math.round(Math.pow(1.1, getRound()));
				lookRight = false;
			}
			else {
				if (standing) setAnimation(lookRight ? standRight : standLeft);
				speedx = 0;
			}
			if (up && standing) {
				setAnimation(lookRight ? jumpRight : jumpLeft);
				speedy = -8.2;
			}
			else if (!standing && !up && speedy < 0 && jumpcount == 0) speedy = 0;
			
			if (!standing) setAnimation(lookRight ? jumpRight : jumpLeft);
			
			standing = false;
		}
		if (jumpcount > 0) --jumpcount;
		super.update();
	}
	
	public function setUp() {
		up = true;
		lastupcount = 8;
	}
	
	public override function hitFrom(dir : Direction) {
		if (dir == Direction.UP) {
			standing = true;
			if (lastupcount < 1) up = false;
		}
		else if (dir == Direction.DOWN) speedy = 0;
	}
	
	public function die() {
		setAnimation(Animation.create(0));
		speedy = -8;
		speedx = 0;
		collides = false;
		killed = true;
	}
	
	public function hitEnemy(enemy : Enemy) {
		if (killed) return;
		if (enemy.isKilled()) return;
		if (enemy.collisionRect().y + enemy.collisionRect().height > collisionRect().y + collisionRect().height + 4) {
			enemy.kill();
			speedy = -8;
			jumpcount = 10;
			standing = false;
			score += 100;
		}
		else die();
	}
	
	public function sleep() {
		setAnimation(Animation.create(0));
		rotation = new Rotation(new Vector2(width / 2, collider.height - 4), Math.PI * 1.5);
		y += collider.height - collider.width;
		x += collider.width - collider.height;
		collider = new Rectangle(-collider.y,collider.x + collider.width,collider.height,collider.width);
		
		speedy = 0;
		speedx = 0;
		killed = true;
	}
	
	public function unsleep() {
		rotation = null;
		collider = new Rectangle(collider.y - collider.height, -collider.x, collider.height, collider.width);
		y -= collider.height - collider.width;
		x -= collider.width - collider.height;
		if (lookRight) setAnimation(standRight);
		else setAnimation(standLeft);
		killed = false;
	}
	
	public function isSleeping(): Bool {
		return killed;
	}
	
	public function zzzzzXDif(): Float {
		return 20;
	}
	
	override public function render(painter:Painter):Void 
	{
		if (isSleeping()) {
			//painter.drawImage2(image, 0, 0, width, height, x, y, width, height, rotation);
			painter.drawImage2(image, 0, 0, width, height, x-collider.x, y-collider.y, width, height, rotation);
			painter.drawImage2(zzzzz, (Std.int(zzzzzIndex / 8) % 3) * zzzzz.width / 3, 0, zzzzz.width / 3, zzzzz.height, x + zzzzzXDif(), y - 15 - collider.height, zzzzz.width / 3, zzzzz.height);
		}
		else {
			super.render(painter);
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
		Scene.the.addHero(sprite);
	}
}