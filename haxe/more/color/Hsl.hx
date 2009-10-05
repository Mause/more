/** Hsl.hx
 *
 * Copyright 2009 Mark de Bruijn (kramieb@gmail.com | Dykam.nl)
 * 
 * Licensed under the apache License, Version 2.0 (the "License");
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
package haxe.more.color;
import haxe.more.exceptions.ArgumentNullException;
import haxe.more.data.structures.ReadOnlyArray;
import haxe.more.exceptions.NotImplementedException;
using haxe.more.color.Hsl;
using haxe.more.data.Manipulation;
using haxe.more.Helpers;
using Std;
#if neko
import haxe.Int32;
using haxe.Int32;
#end

class Hsl implements IHsl {	
	var _h:Float; // The alpha shade, 8 bits for him
	var _s:Float; // The alpha shade, 8 bits for him
	var _l:Float; // The alpha shade, 8 bits for him
	var _a:Float; // The alpha shade, 8 bits for him
	
	public function new(h:Float, s:Float, l :Float, a:Float = 0) {
		this.h = h;
		this.s = s;
		this.l = l;
		this.a = a;
	}
	
	public function toString():String
		return "hsla( " + h + ", " + s + ", " + l + ", " + a + ")"
	
	/**
	 * The alpha component of this color.
	 */
	public var a(gA, sA):Float;
	function gA():Float {
		return _a;
	}
	function sA(value:Float):Float {
		return _a = cap(0, 1, value);
	}
	
	/**
	 * The hue component of this color.
	 */
	public var h(gH,sH):Float;
	function gH():Float {
		return _h;
	}
	function sH(value:Float):Float {
		return _h = mod(360, value);
	}
	
	/**
	 * The saturation component of this color.
	 */
	public var s(gS, sS):Float;
	function gS():Float {
		return _s;
	}
	function sS(value:Float):Float {
		return _s = cap(0, 1, value);
	}
	
	/**
	 * The lightness component of this color.
	 */
	public var l(gL, sL):Float;
	function gL():Float {
		return _l;
	}
	function sL(value:Float):Float {
		return _l = cap(0, 1, value);
	}
	
	/** Using methods **/	
	/**
	 * Clones [a].
	 * @param	a The color to clone.
	 * @return A clone of [a].
	 */
	public static inline function clone(a:IFixedHsl):Hsl
		return new Hsl(a.h, a.s, a.l, a.a)
	
	/** Converters **/
	/** Hsl to Rgb * http://en.wikipedia.org/wiki/HSL_and_HSV#Conversion_from_HSL_to_RGB **/
	public static function toRgb32(hsl:IFixedHsl):Rgb32 {
		throw new NotImplementedException("Hsl.toRgb32");
		var s = hsl.s;
		var l = hsl.l;
		if (s == 0) {
			var value = (l * 255).int();
			return new Rgb32(value.int(), value.int(), value.int(), (hsl.a * 255).int());
		}
		var h = hsl.h / 360;
		var q = l < .5 ? l * (1 + s) : l + s - (l * s);
		var p = 2 * l - q;
		var tr = sMod(h + 1 / 3, 1);
		var tg = sMod(h, 1);
		var tb = sMod(h - 1 / 3, 1);
		var r = (limit(tr, q, p) * 255).int();
		var g = (limit(tg, q, p) * 255).int();
		var b = (limit(tb, q, p) * 255).int();
		return new Rgb32(r, g, b, (hsl.a * 255).int());
	}
	
	static inline function limit(c:Float, q:Float, p:Float) { return
		if (c < 1 / 6)
			p + ((q - p) * 6 * c);
		else if (c < 1 / 2)
			 q;
		else if (c < 2 / 3)
			p + ((q - p) * 6 * (2 / 3 - c));
		else
			p;
	}
	
		/** Helpers **/
	static inline function max(a:Float, b) return a > b ? a : b	
	static inline function min(a:Float, b) return a < b ? a : b
	static inline function cap(minimum:Float, maximum, value) return min(maximum, max(minimum, value))
	static inline function mod(moderator:Float, value) return value >= moderator ? value % moderator : value < 0 ? value % moderator + moderator : value
	static inline function sMod(c:Float, value) return value < 0 ? value + c : value > c ? value - c : value
	
	/** Presets **/
	
	static var init = (function() {
		known = new ReadOnlyArray([		
		red = new Hsl(0, 1, .5),
		green = new Hsl(120, 1, .5),
		blue = new Hsl(240, 1, .5),
		
		/*magenta = ,
		cyan = ,
		yellow = ,
		
		rose = ,
		violet = ,
		azure = ,
		springGreen = ,
		chartreuse = ,
		orange = */
		]);
		
		clear = new Hsl(255, 255, 255, 255);
	})();
	
	/** Primary * http://en.wikipedia.org/wiki/Primary_color **/
	public static var red(default, null):IFixedHsl;
	public static var green(default, null):IFixedHsl;
	public static var blue(default, null):IFixedHsl;
	
	/** Secondary * http://en.wikipedia.org/wiki/Secondary_color **/
	public static var yellow(default, null):IFixedHsl;
	public static var cyan(default, null):IFixedHsl;
	public static var magenta(default, null):IFixedHsl;
	
	/** Tertiary * http://en.wikipedia.org/wiki/Tertiary_color **/
	public static var azure(default, null):IFixedHsl;
	public static var violet(default, null):IFixedHsl;
	public static var rose(default, null):IFixedHsl;
	public static var orange(default, null):IFixedHsl;
	public static var chartreuse(default, null):IFixedHsl;
	public static var springGreen(default, null):IFixedHsl;
	
	/** Obvious ones **/
	public static var clear(default, null):IFixedHsl;
	
	public static var known(default, null):ReadOnlyArray<IFixedHsl>;
}