package;

import haxe.xml.Parser;
import kha.Assets;

enum LanguageType {
	en;
	de;
}

class Localization {
	static var defaultLanguage : LanguageType = en;
	static public var language : LanguageType = en;
	static var texts : Map < String, Map < LanguageType, String >> = null;
	
	static public function init(filename : String, force = false) {
		if (texts != null && !force) {
			return;
		}
		texts = new Map();
		var xml = Parser.parse(Assets.blobs.get(filename).toString());
		for (item in xml.elements()) {
			var key = item.nodeName;
			if (key == "DefaultLanguage") {
				try {
					defaultLanguage = Type.createEnum(LanguageType, item.firstChild().nodeValue.toLowerCase());
				} catch (e : Dynamic) {}
			} else {
				texts[key] = new Map();
				for (language in item.elements()) {
					try {
						var l = Type.createEnum(LanguageType, language.nodeName.toLowerCase());
						texts[key][l] = language.firstChild().nodeValue;
					} catch (e : Dynamic) {}
				}
			}
		}
	}
	
	static public function getText(key : String) {
		var t = texts[key];
		if (t != null) {
			if (t.exists(language)) {
				return t[language];
			} else if (t.exists(defaultLanguage)) {
				return t[defaultLanguage];
			}
		}
		return key;
	}
}
