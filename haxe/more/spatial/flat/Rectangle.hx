/**
 * ...
 * @author 
 */

package haxe.more.spatial.flat;
import haxe.more.data.flow.Enumerable;
import haxe.more.Default;
using haxe.more.spatial.flat.Rectangle;
using haxe.more.data.Manipulation;

class Rectangle {
	public var width(default, default):Float;
	public var height(default, default):Float;
	public var x(default, default):Float;
	public var y(default, default):Float;
	
	public var left(gLeft, sLeft):Float;
	inline function gLeft() return getLeft(this)
	inline function sLeft(value)return setLeft(this, value)
	public var right(gRight, sRight):Float;
	inline function gRight() return getRight(this)
	inline function sRight(value:Float) return setRight(this, value)
	public var top(gTop, sTop):Float;
	inline function gTop() return getTop(this)
	inline function sTop(value) return setTop(this, value)
	public var bottom(gBottom, sBottom):Float;
	inline function gBottom() return getBottom(this)
	inline function sBottom(value:Float) return setBottom(this, value)
	
	public function new(width:Float, height:Float, x:Float = 0, y:Float = 0) {
		this.width = width;
		this.height = height;
		this.x = x;
		this.y = y;
	}
	
	public static inline function asRectangle(object:RectangleDef):Rectangle {
		return new Rectangle(object.width, object.height, object.x, object.y);
	}
	
	public static function boundingBox(rect1:RectangleDef, rect2:RectangleDef):Rectangle {
		var result = new Rectangle(0, 0);
		result.left = Default.min(rect1.getLeft(), rect2.getLeft());
		result.right = Default.max(rect1.getRight(), rect2.getRight());
		result.top = Default.min(rect1.getTop(), rect2.getTop());
		result.bottom = Default.max(rect1.getBottom(), rect2.getBottom());
		return result;
	}
	
	public static function boundingBoxOfAll(rectangles:Enumerable<RectangleDef>):Rectangle {
		return
			rectangles
			.fold(function(rect, box:Rectangle) return rect == box ? rect.asRectangle() : rect.boundingBox(box));
	}
	
	public static inline function getLeft(rect:RectangleDef) return rect.x
	public static inline function setLeft(rect:Rectangle, value:Float) return rect.x = value
	public static inline function getRight(rect:RectangleDef) return rect.x + rect.width
	public static inline function setRight(rect:Rectangle, value:Float) return rect.width = value - rect.x
	public static inline function getTop(rect:RectangleDef) return rect.y
	public static inline function setTop(rect:Rectangle, value:Float) return rect.y = value
	public static inline function getBottom(rect:RectangleDef) return rect.y + rect.height
	public static inline function setBottom(rect:Rectangle, value:Float) return rect.height = value - rect.y
	
	public function toString():String {
		return "{ x: " + x + ", y: " + y + ", width: " + width + ", height: " + height + " }";
	}
}

typedef RectangleDef = {
	var width(default, null):Float;
	var height(default, null):Float;
	var x(default, null):Float;
	var y(default, null):Float;
}