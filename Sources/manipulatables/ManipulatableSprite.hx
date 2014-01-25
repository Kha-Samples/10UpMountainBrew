package manipulatables;

enum ObjectType {
	// Direktor
	Director;
	// Verwundeter
	WoundedPerson;
	// Ritter
	Knight;
	// Ritterrüstung
	KnightsArmour;
	// Typ mit Feuerlöscher
	GuyWithExtinguisher;
	// Arztkittel
	LabCoat;
	// Spritze
	Injection;
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
}

interface ManipulatableSprite {
	public var name(get, null): String;
	
	public function getOrder(selectedItem : UseableSprite) : OrderType;
	
	public function executeOrder(order : OrderType) : Void;
}