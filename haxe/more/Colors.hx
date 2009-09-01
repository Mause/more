/** Colors.hx
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
package haxe.more;
import flash.filters.ColorMatrixFilter;

using haxe.more.Colors;
using Std;

// Surely more have to be added.
class Colors {
	static var init = (function() {
		red = new Color(255, 0, 0);
		green = new Color(0, 255, 0);
		blue = new Color(0, 0, 255);
		
		yellow = red.add(green);
		cyan = green.add(blue);
		magenta = blue.add(red);
		#if compiler fixed
		yellow = avarage(red, green);
		cyan = avarage(green, blue);
		magenta = avarage(blue, red);
		#end
	})();
	
	/** Primary **/
	public static var red(default, null):Color;
	public static var green(default, null):Color;
	public static var blue(default, null):Color;
	
	/** Secondary **/
	public static var yellow(default, null):Color;
	public static var cyan(default, null):Color;
	public static var magenta(default, null):Color;
	
	/** Using methods, keeps the colors clean **/
	public inline static function add(a:Color, b:Color):Color {
		return new Color(min(255, a.R + b.R), min(255, a.G + b.G), min(255, a.B + b.B), Std.int((a.A + b.A) / 2));
	}
	public static function avarage(a:Color, b:Color, padding:Float = 0.5):Color {
		return padding == 0.5
			? new Color(
					Std.int((a.R + b.R) * .5),
					Std.int((a.G + b.G) * .5),
					Std.int((a.B + b.B) * .5),
					Std.int((a.A + b.A) * .5)
				)
			: new Color(
					Std.int(padding * a.R + (1 - padding) * b.R),
					Std.int(padding * a.G + (1 - padding) * b.G),
					Std.int(padding * a.B + (1 - padding) * b.B),
					Std.int(padding * a.A + (1 - padding) * b.A)
				);
	}
	
	static inline function max(a, b) {
		return a > b ? a : b;
	}
	
	static inline function min(a, b) {
		return a < b ? a : b;
	}
}