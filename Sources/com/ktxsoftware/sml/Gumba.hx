package com.ktxsoftware.sml;

import com.ktxsoftware.kha.Animation;
import com.ktxsoftware.kha.Direction;
import com.ktxsoftware.kha.Image;
import com.ktxsoftware.kha.Loader;
import com.ktxsoftware.kha.Scene;

class Gumba extends Enemy {
	static var image : Image;
	var killcount : Int;
	static var initialized = false;
	
	static function init() {
		if (!initialized) {
			image = Loader.getInstance().getImage("gumba.png");
			initialized = true;
		}
	}
	
	public function new(x : Int, y : Int) {
		init();
		super(Gumba.image, Std.int(96 / 3), 32);
		this.x = x;
		this.y = y;
		setAnimation(new Animation([0, 2], 14));
		speedx = -1 * Math.round(Math.pow(1.2, Jumpman.getInstance().getRound()));
		killcount = -1;
	}
	
	public override function kill() {
		super.kill();
		setAnimation(Animation.create(1));
		speedx = 0;
		killcount = 30;
	}
	
	public override function update() {
		super.update();
		if (killcount > 0) {
			--killcount;
			if (killcount == 0) Scene.getInstance().removeEnemy(this);
		}
	}
	
	public override function hitFrom(dir : Direction) {
		if (dir == Direction.LEFT) {
			speedx = -1 * Math.round(Math.pow(1.2, Jumpman.getInstance().getRound()));
		}
		else if (dir == Direction.RIGHT) {
			speedx = 1 * Math.round(Math.pow(1.2, Jumpman.getInstance().getRound()));
		}
	}
}