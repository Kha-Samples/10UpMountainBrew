package manipulatables;

enum ObjectType {
	// Feuer
	Fire;
	// Direktor
	Director;
	// Verwundeter
	WoundedPerson;
	// Ritter
	Knight;
	// Ritterrüstung
	KnightsArmour;
	// Schwert
	Sword;
	// Typ mit Feuerlöscher
	GuyWithExtinguisher;
	// Feuerlöscher
	Extinguisher;
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
}

interface ManipulatableSprite {
	public var name(get, null): String;
	
	public function getOrder(selectedItem : UseableSprite) : OrderType;
	
	public function executeOrder(order : OrderType) : Void;
}