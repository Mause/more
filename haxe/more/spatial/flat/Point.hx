/** Point.hx
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

class Point {
	public var x:Float;
	public var y:Float;
	
	public static var zero(gZero, null):Point;
	static inline function gZero() return new Point()
	
	public function new(x:Float = 0, y:Float = 0) {
		this.x = x;
		this.y = y;
	}
	
	public static inline function add(object1:PointDef, object2:PointDef):Point {
		return new Point(object1.x + object2.x, object1.y + object2.y);
	}
	
	public static inline function sub(object1:PointDef, object2:PointDef):Point {
		return new Point(object1.x - object2.x, object1.y - object2.y);
	}
	
	public static inline function asPoint(object:PointDef):Point {
		return new Point(object.x, object.y);
	}	
	
	public function toString():String {
		return "{ x: " + x + ", y: " + y + " }";
	}
}

typedef PointDef = {
	var x(default, null):Float;
	var y(default, null):Float;
}