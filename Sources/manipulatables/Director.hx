package manipulatables;
import dialogue.Action;
import dialogue.ActionWithBla;
import dialogue.Bla;
import kha.Loader;
import manipulatables.UseableSprite;

import kha.Image;
import kha.Sprite;
import manipulatables.ManipulatableSprite.OrderType;

// Direktor
class Director extends Sprite implements ManipulatableSprite
{
	static public var the;
	public function new(px : Int, py : Int, name : String = null, image:Image = null, w: Int = 0, h: Int = 0) 
	{
		py -= 40;
		if (image == null) {
			image = Loader.the.getImage("boss");
			w = Std.int(192 * 2 / 6);
			h = 64 * 2;
		}
		super(image, w, h);
		x = px;
		y = py;
		if (name == null) {
			this.name = "Director";
		} else {
			this.name = name;
		}
		the = this;
	}
	
	/* INTERFACE manipulatables.ManipulatableSprite */
	
	function get_name():String 
	{
		return name;
	}
	
	public var name(get_name, null):String;
	
	public function getOrder(selectedItem:UseableSprite):OrderType 
	{
		if (selectedItem == null) {
			return OrderType.Bla;
		} else if (Std.is(selectedItem, Injection)) {
			return OrderType.Apply;
		} else if (Std.is(selectedItem, Sword)) {
			return OrderType.Slay;
		} else if (Std.is(selectedItem, Pizza)) {
			return OrderType.Eat;
		} else {
			return OrderType.WontWork;
		}
	}
	
	public function executeOrder(order:OrderType):Void 
	{
		var jmpMan = Jumpman.getInstance();
		switch (order) {
			case Eat:
				Inventory.loose(Inventory.getSelectedItem());
				Dialogue.set([new Bla("L2A_Drake_Groah",this)]);
			case Slay:
				Dialogue.set([new ActionWithBla(new Bla("L2A_Drake_a", jmpMan),[this], ActionType.Slay),
							  new ActionWithBla(new Bla("L2A_Drake_b", GuyWithExtinguisher.the), [GuyWithExtinguisher.the], ActionType.Run)]);
				// TODO: Slay Dragon
			case Bla:
				Dialogue.set([new Bla("L2A_Drake_NoSword_a", jmpMan),
							  new Bla("L2A_Drake_Groah", this),
							  new Bla("L2A_Drake_NoSword_b", jmpMan)]);
			default:
				// Nothing todo yet.
		}
	}
	
}