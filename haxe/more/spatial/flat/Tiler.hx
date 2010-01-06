/** Tiler.hx
 *
 * Copyright 2009 Mark de Bruijn (kramieb@gmail.com | Dykam.nl)
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/
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