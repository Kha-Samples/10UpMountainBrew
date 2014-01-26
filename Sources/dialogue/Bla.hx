package dialogue;

import Dialogue.DialogueItem;
import kha.Sprite;

class Bla implements DialogueItem {
	var text : String;
	var speaker : Sprite;
	
	public var finished(default, null) : Bool = true;
	
	public function new (text : String, speaker : Sprite) {
		this.text = text;
		this.speaker = speaker;
	}
	
	public function execute() : Void {
		BlaBox.pointAt(speaker);
		BlaBox.setText(text);
	}
}
