package ;

import kha.Image;
import kha.Scene;
import kha.Sprite;

class UseableSprite extends Sprite
{
	public function new(image:Image, width:Int=0, height:Int=0, z:Int=1) 
	{
		super(image, width, height, z);
		
	}
	
	public function take() {
		Scene.the.removeHero(this);
		// TODO: add to inventory
	}
}
