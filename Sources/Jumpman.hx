package;

import kha.Assets;
import kha2d.Animation;
import kha.Color;
import kha2d.Direction;
import kha.graphics2.Graphics;
import kha.Image;
import kha.math.FastMatrix3;
import kha.math.Vector2;
import kha2d.Rectangle;
import kha.Rotation;
import kha2d.Scene;
import kha.Sound;
import kha2d.Sprite;
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
		super(Assets.images.agent, Std.int(360 / 9) * 2, Std.int(768 / 12) * 2, 2);
		instance = this;
		x = y = 50;
		standing = false;
		naked();
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
		zzzzz = Assets.images.zzzzz;
		name = "Player";
	}
	
	private function setAnim(indexStart: Int): Void {
		walkLeft = Animation.createRange(indexStart + 10, indexStart + 17, 4);
		walkRight = Animation.createRange(indexStart + 1, indexStart + 8, 4);
		standLeft = Animation.create(indexStart + 9);
		standRight = Animation.create(indexStart + 0);
		jumpLeft = Animation.create(indexStart + 9);
		jumpRight = Animation.create(indexStart + 0);
	}
	
	public function naked(): Void {
		setAnim(0);
	}
	
	public function coat(): Void {
		setAnim(18);
	}
	
	public function helmet(): Void {
		setAnim(36);
	}
	
	public function doc(): Void {
		setAnim(54);
	}
	
	public function coatHelmet(): Void {
		setAnim(54 + 18);
	}
	
	public function coatDoc(): Void {
		setAnim(54 + 18 + 18);
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
	
	public static var isWinter: Bool = true;
	
	private function initLevel() : Void {
		Jumpman.getInstance().reset();
		Scene.the.addHero(Jumpman.getInstance());
	}
	
	public override function update(): Void {
		walking = false;
		if (lastupcount > 0) --lastupcount;
		
		if (y > 470) {
			isWinter = false;
			naked();
			Jumpman.getInstance().setSpawn(500);
			Level.load("level3", initLevel);
		}
		
		if (Level.levelName == "level3") {
			if (!isWinter && x > 550) {
				x = 550;
			}
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
		originX = width / 2;
		originY = collider.height - 4;
		angle = Math.PI * 1.5;
		y += collider.height - collider.width;
		x += collider.width - collider.height;
		collider = new Rectangle(-collider.y, collider.x + collider.width, collider.height, collider.width);
		
		speedy = 0;
		speedx = 0;
		killed = true;
	}
	
	public function unsleep() {
		angle = 0;
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
	
	override public function render(g: Graphics): Void 
	{
		if (isSleeping()) {
			g.color = Color.White;
			//painter.drawImage2(image, 0, 0, width, height, x, y, width, height, rotation);
			if (angle != 0) g.pushTransformation(g.transformation.multmat(FastMatrix3.translation(x + originX, y + originY)).multmat(FastMatrix3.rotation(angle)).multmat(FastMatrix3.translation(-x - originX, -y - originY)));
			g.drawScaledSubImage(image, 0, 0, width, height, x - collider.x, y - collider.y, width, height);
			if (angle != 0) g.popTransformation();
			g.drawScaledSubImage(zzzzz, (Std.int(zzzzzIndex / 8) % 3) * zzzzz.width / 3, 0, zzzzz.width / 3, zzzzz.height, x + zzzzzXDif(), y - 15 - collider.height, zzzzz.width / 3, zzzzz.height);
		}
		else {
			super.render(g);
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