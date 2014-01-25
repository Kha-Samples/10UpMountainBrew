package manipulatables;

enum ObjectType {
	// Ritter
	Knight;
	// Ritterrüstung
	KnightsArmour;
	// Typ mit Feuerlöscher
	GuyWithExtinguisher;
	// Arztkittel
	LabCoat;
	// Knochensäge
	BoneSaw;
}

enum OrderType {
	Nothing;
	MoveTo;
	Take;
	InventoryItem;
	Enter;
	WontWork;
	Eat;
	Slay;
	Extinguish;
	Apply;
}

interface ManipulatableSprite {
	public var name(get, null): String;
	
	public function getOrder(selectedItem : UseableSprite) : OrderType;
	
	public function executeOrder(order : OrderType) : Void;
}