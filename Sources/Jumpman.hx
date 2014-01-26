package;

import kha.Animation;
import kha.Direction;
import kha.Image;
import kha.Loader;
import kha.math.Vector2;
import kha.Music;
import kha.Painter;
import kha.Rectangle;
import kha.Rotation;
import kha.Sound;
import kha.Sprite;
import manipulatables.ManipulatableSprite;
import manipulatables.Pizza;
import manipulatables.UseableSprite;

class Jumpman extends Sprite implements ManipulatableSprite {
	static var instance : Jumpman;
	public var left : Bool;
	public var right : Bool;
	public var up : Bool;
	public var lookRight(default, null) : Bool;
	public var walking: Bool = false;
	public var index: Int;
	private var zzzzz: Image;
	private var zzzzzIndex: Int = 0;
	var standing : Bool;
	var killed : Bool;
	var jumpcount : Int;
	var lastupcount : Int;
	var walkLeft : Animation;
	var walkRight : Animation;
	var standLeft : Animation;
	var standRight : Animation;
	var jumpLeft : Animation;
	var jumpRight : Animation;
	var score : Int;
	var round : Int;
	private var spawnX: Float = 50;
	
	public var hasHelmet : Bool = false;
	public var hasSurgicalMask : Bool = false;
	public var hasWinterCoat : Bool = false;
	
	public function new() {
		super(Loader.the.getImage("agent"), Std.int(410 / 10) * 2, Std.int(455 / 7) * 2, 2);
		instance = this;
		x = y = 50;
		standing = false;
		walkLeft = Animation.createRange(11, 18, 4);
		walkRight = Animation.createRange(1, 8, 4);
		standLeft = Animation.create(10);
		standRight = Animation.create(0);
		jumpLeft = Animation.create(31);
		jumpRight = Animation.create(30);
		setAnimation(jumpRight);
		collider = new Rectangle(20, 30, 41 * 2 - 40, (65 - 1) * 2 - 30);
		score = 0;
		round = 1;
		up = false;
		right = false;
		left = false;
		lookRight = true;
		killed = false;
		jumpcount = 0;
		zzzzz = Loader.the.getImage("zzzzz");
		name = "Player";
	}
	
	public static function getInstance() : Jumpman {
		return instance;
	}
	
	public function setSpawn(x: Float): Void {
		spawnX = x;
	}
	
	public function reset() {
		x = spawnX;
		y = 350;
		standing = false;
		setAnimation(jumpRight);
	}
	
	public function selectCoin() {
		score += 50;
	}
	
	public function getScore() : Int {
		return score;
	}
	
	public function getRound() : Int {
		return round;
	}
	
	public function nextRound() {
		++round;
	}
	
	private var baseSpeed = 4.0;
	public override function update(): Void {
		walking = false;
		if (lastupcount > 0) --lastupcount;
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
	
	public var name(get, null):String;
	
	public function getOrder(selectedItem:UseableSprite) : OrderType 
	{
		if (Std.is(selectedItem, Pizza)) {
			return Eat;
		}
		return OrderType.ToolTip;
	}
	
	public function executeOrder(order:OrderType):Void 
	{
		if (order == Eat) {
			Inventory.loose(Inventory.getSelectedItem());
		}
	}
}