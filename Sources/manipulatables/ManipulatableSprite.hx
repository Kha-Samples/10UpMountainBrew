package manipulatables;

enum ObjectType {
	// (mytischer) Drache
	Drake;
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
	// Pizza
	Pizza;
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
}

interface ManipulatableSprite {
	public var name(default, null): String;
	
	public function getOrder(selectedItem : UseableSprite) : OrderType;
}