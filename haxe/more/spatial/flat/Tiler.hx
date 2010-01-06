/**
 * ...
 * @author 
 */

package haxe.more.spatial.flat;
import haxe.more.data.flow.Enumerable;
import haxe.more.spatial.flat.Rectangle;
using haxe.more.spatial.flat.Rectangle;
using haxe.more.data.Manipulation;
using Std;

class Tiler {
	public var target:RectangleDef;
	
	public function new(targetTile:RectangleDef) {
		this.target = targetTile;
	}
	
	public function tile(toCover:RectangleDef):Enumerable<RectangleDef> {
		var toCover = toCover.asRectangle();
		var left = ((toCover.left - target.x) / target.width - 1).int() * target.width;
		var top = ((toCover.top - target.y) / target.height - 1).int() * target.height;
		var right = ((toCover.right - target.x) / target.width).int() * target.width;
		var bottom = ((toCover.bottom - target.y) / target.height).int() * target.height;
		var x = left;
		var y = top;
		
		var tiles = new Array<RectangleDef>();
		while (y <= bottom) {
			while(x <= right) {
				tiles.push(
					new Rectangle(
						target.width,
						target.height,
						x,
						y
					)
				);
			x += target.width;
			}
			y += target.height;
			x = left;
		}
		
		tiles.push(new Rectangle(target.width, target.height, left, top));
		
		return tiles.asEnumerable();
	}
}