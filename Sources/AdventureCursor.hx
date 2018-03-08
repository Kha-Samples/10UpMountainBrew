package;

//import kha.AnimatedImageCursor;
import kha2d.Animation;
import kha.Assets;
import kha.Color;
import kha.Font;
import kha.FontStyle;
import kha.graphics2.Graphics;
//import kha.ImageCursor;
import kha2d.Scene;
import kha2d.Sprite;
import manipulatables.ManipulatableSprite;
import manipulatables.UseableSprite;

class AdventureCursor implements Cursor {
	private var font: Font;
	private var fontSize: Int;
	private var toolTip : String;
	private var toolTipY : Int;
	
	public var width(get,never): Int;
	public var height(get, never): Int;
	public var clickX(get,never): Int;
	public var clickY(get, never): Int;
	
	private function get_clickX() : Int {
		if (currentCursor != null)
			return currentCursor.clickX;
		else
			return 3;
	}
	private function get_clickY() : Int {
		if (currentCursor != null)
			return currentCursor.clickY;
		else
			return 3;
	}
	private function get_width() : Int {
		if (currentCursor != null)
			return currentCursor.width;
		else
			return 16;
	}
	private function get_height() : Int {
		if (currentCursor != null)
			return currentCursor.height;
		else
			return 16;
	}
	
	var currentCursor : Cursor;
	var cursors : Map<OrderType, Cursor> = new Map();
	
	public var hoveredType : OrderType = Nothing;
	public var hoveredObject : ManipulatableSprite = null;
	
	public var forcedTooltip : String = null;
	
	public function new() {
		cursors[MoveTo] = new ImageCursor(Assets.images.cursor, 16, 16);
		cursors[Take] = new ImageCursor(Assets.images.handcursor, 6, 9);
		cursors[InventoryItem] = new ImageCursor(Assets.images.handcursor, 6, 9);
		cursors[WontWork] = new ImageCursor(Assets.images.pizza_pixel, 5, 5); // TODO: cursor
		cursors[Eat] = new ImageCursor(Assets.images.pizza_pixel, 15, 15); // TODO: cursor
		cursors[Enter] = new ImageCursor(Assets.images.cursor, 16, 16); // TODO: cursor
		currentCursor = null;
		Mouse.forceSystemCursor(true);
		font = Assets.fonts.LiberationSans_Regular;
		fontSize = 14;
	}
	
	public function render(g: Graphics, x: Int, y: Int): Void {
		if (currentCursor != null) {
			currentCursor.render(g, x, y);
			
			if (forcedTooltip != null) {
				drawTooltip(g, forcedTooltip, x, toolTipY);
			} else if (toolTip != null) {
				drawTooltip(g, toolTip, x, toolTipY);
			}
		}
	}
	
	private function drawTooltip(g: Graphics, tip: String, x: Int, y: Int): Void {
		g.font = font;
		g.fontSize = fontSize;
		g.color = Color.Black;
		g.fillRect(x - 2, y - 2, font.width(fontSize, tip) + 4, font.height(fontSize) + 4);
		g.color = Color.White;
		g.drawString(tip, x, y);
	}
	
	public function update(x : Int, y : Int) {
		var toolTipTop : Bool = false;
		hoveredType = OrderType.Nothing;
		hoveredObject = Inventory.getItemBelowPoint(x, y);
		var jmpMan = Jumpman.getInstance();
		if (hoveredObject != null) {
			toolTipTop = true;
			toolTip = Localization.getText(hoveredObject.name);
			hoveredType = OrderType.InventoryItem;
		} else if (y >= Inventory.y) {
			toolTipTop = true;
			toolTip = null;
		} else {
			var worldX = x + Scene.the.screenOffsetX;
			var worldY = y + Scene.the.screenOffsetY;
			for (obj in Scene.the.getSpritesBelowPoint(worldX, worldY)) {
				if (Std.is(obj, ManipulatableSprite)) {
					hoveredObject = cast obj;
					hoveredType = hoveredObject.getOrder(Inventory.getSelectedItem());
					if (hoveredType == OrderType.Nothing) {
						hoveredObject = null;
						toolTip = null;
					} else {
						if (hoveredType == OrderType.ToolTip) {
							toolTip = Localization.getText(hoveredObject.name);
						} else if (hoveredType == OrderType.MoveTo) {
							toolTip = null;
						} else if (Inventory.getSelectedItem() != null) {
							toolTip = Localization.getText(Inventory.getSelectedItem().name + "_" + hoveredType + "_" + hoveredObject.name);
						} else {
							toolTip = Localization.getText(hoveredType + "_" + hoveredObject.name);
						}
					}
					break;
				}
			}
			if (hoveredObject == null) {
				if (worldX < jmpMan.x || jmpMan.x + jmpMan.width < worldX) {
					hoveredType = OrderType.MoveTo;
				}
			}
		}
		
		if (cursors.exists(hoveredType)) {
			currentCursor = cursors[hoveredType];
			Mouse.forceSystemCursor(false);
			currentCursor.update(x, y);
		} else {
			Mouse.forceSystemCursor(true);
			currentCursor = null;
		}
		if (toolTipTop) {
			toolTipY = y - clickY - 16;
		} else {
			toolTipY = y - clickY + height;
		}
	}
}
