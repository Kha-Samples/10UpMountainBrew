package manipulatables;

import dialogue.Bla;
import kha.Assets;
import kha.Image;
import manipulatables.ManipulatableSprite.OrderType;

// Knochensäge
class BoneSaw extends UseableSprite {
	public function new(px: Int, py: Int) {
		super("Bone Saw", Assets.images.saw, px, py);
	}
	
	override public function executeOrder(order:OrderType): Void {
		if (order == OrderType.Take) {
			var jmpMan = Jumpman.getInstance();
			if (jmpMan.hasHelmet) {
				Dialogue.set([new Bla("TakeBoneSaw_Helmet", jmpMan)]);
				return;
			}
			else if (jmpMan.hasSurgicalMask) {
				Dialogue.set([new Bla("TakeBoneSaw", jmpMan)]);
			}
			else {
				Dialogue.set([new Bla("TakeBoneSaw_NoMask", jmpMan)]);
				return;
			}
		}
		super.executeOrder(order);
	}
}
