/** Rgb.hx
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
using haxe.more.color.Rgb;
using haxe.more.data.Manipulation;
using haxe.more.Default;
using Std;
#if neko
import haxe.Float32;
using haxe.Float32;
#end

class Rgb implements IRgb {
	var _r:Float;
	var _g:Float;
	var _b:Float;
	var _a:Float; // The alpha shade, 8 bits for him
	
	public function new(r:Float, g:Float, b:Float, a:Float = 0) {
		this.r = r;
		this.g = g;
		this.b = b;
		this.a = a;
	}
	
	public function toString():String
		return "rgba( " + r + ", " + g + ", " + b + ", " + a + ")"
	
	
	/** Below all the code to correctly apply the colors **/
	
	/**
	 * The alpha component of this color.
	 */
	public var a(gA, sA):Float;
	function gA():Float {
		return _a;
	}
	function sA(value:Float):Float {
		_a = max(0, min(1, value));
		return _a;
	}
		
	/**
	 * The red component of this color.
	 */
	public var r(gR, sR):Float;
	function gR():Float {
		return _r;
	}
	function sR(value:Float):Float {
		_r = max(0, min(1, value));
		return _r;
	}
		
	/**
	 * The green component of this color.
	 */
	public var g(gG, sG):Float;
	function gG():Float {
		return _g;
	}
	function sG(value:Float):Float {
		_g = max(0, min(1, value));
		return _g;
	}
		
	/**
	 * The blue component of this color.
	 */
	public var b(gB, sB):Float;
	function gB():Float {
		return _b;
	}
	function sB(value:Float):Float {
		_b = max(0, min(1, value));
		return _b;
	}
	
	
	
	/** Using methods **/
	/**
	 * Modifies the color of [a] by adding [b].
	 * @param	a The color to modify.
	 * @param	b The modifier.
	 * @return The modified [a].
	 */
	public inline static function add(a:Rgb, b:IFixedRgb):Rgb {
		a.r = min(1, a.r + b.r);
		a.g = min(1, a.g + b.g);
		a.b = min(1, a.b + b.b);
		a.a = min(1, a.a + b.a);
		return a;
	}
	
	/**
	 * Clones [a].
	 * @param	a The color to clone.
	 * @return A clone of [a].
	 */
	public static inline function clone(a:IFixedRgb):Rgb
		return new Rgb(a.r, a.g, a.b, a.a)
	
	/**
	 * Modifies the color of [a] by avaraging with [b].
	 * @param	a The color to modify.
	 * @param	b The modifier.
	 * @param	padding The scale to apply what.
	 * @return The modified [a].
	 */
	public static function avarage(a:Rgb, b:IFixedRgb, padding:Float = 0.5):Rgb {
		if (a == null) throw new ArgumentNullException("a");
		if (b == null) throw new ArgumentNullException("b");
		var inverse = 1 - padding;
		a.r = a.r * inverse + b.r * padding;
		a.g = a.g * inverse + b.g * padding;
		a.b = a.b * inverse + b.b * padding;
		a.a = a.a * inverse + b.a * padding;
		return a;
	}
	
	/**
	 * Modifies the color of [a] by subtracting [b].
	 * @param	a The color to modify.
	 * @param	b The modifier.
	 * @return The modified [a].
	 */
	public inline static function subtract(a:Rgb, b:IFixedRgb):Rgb {
		a.r = max(0, a.r - b.r);
		a.g = max(0, a.g - b.g);
		a.b = max(0, a.b - b.b);
		a.a = max(0, a.a - b.a);
		return a;
	}
	
	/** Converters **/
	/** Hsl to Rgb * http://en.wikipedia.org/wiki/HSL_and_HSV#Conversion_from_HSL_to_RGB **/
	/**
	 * Converts a rgb color to the hsl color space.
	 * @param	rgb The color to convert.
	 * @return the converted color.
	 */
	public static function toHsl(rgb:IFixedRgb):Hsl {
		var r = rgb.r;
		var g = rgb.g;
		var b = rgb.b;
		var max = max(r, max(b, g));
		var min = min(r, min(g, b));
		var h = if (max == min)
				0;
			else if (max == r)
				(60 * (g - b) / (max - min) + 360) % 360;
			else if (max == g)
				60 * (b - r) / (max - min) + 120;
			else//if(max == b)
				60 * (r - g) / (max - min) + 240;
		var l = 1 / 2 * (max - min);
		var s = if (max == min)
				0;
			else if (l <= 1 / 2)
				(max - min) / (2 * l);
			else
				(max - min) / (2 - 2 * l);
		return new Hsl(h, s, l, rgb.a);
	}
	
	/**
	 * Converts a rgb color to the rgb32 color space.
	 * @param	rgb The color to convert.
	 * @return the converted color.
	 */
	public static function toRgb32(rgb:IFixedRgb):Rgb32 {
		return new Rgb32(
			(rgb.r * 255).int(),
			(rgb.g * 255).int(),
			(rgb.b * 255).int(),
			(rgb.a * 255).int()
		);
	}
	
	
	/** Default **/
	static inline function max(a:Float, b) return a > b ? a : b	
	static inline function min(a:Float, b) return a < b ? a : b
	static inline function m(color) return color & 0xFF // masks.
	
	/** Presets **/
	
	static var init = (function() {
		known = new ReadOnlyArray([		
		red = new Rgb(1, 0, 0),
		green = new Rgb(0, 1, 0),
		blue = new Rgb(0, 0, 1),
		
		magenta = blue.clone().add(red),
		cyan = green.clone().add(blue),
		yellow = red.clone().add(green),
		
		rose = red.clone().avarage(magenta),
		violet = magenta.clone().avarage(blue),
		azure = blue.clone().avarage(cyan),
		springGreen = cyan.clone().avarage(green),
		chartreuse = green.clone().avarage(yellow),
		orange = yellow	.clone().avarage(red)
		]);
		
		clear = new Rgb(1, 1, 1, 1);
	})();
	
	/** Primary * http://en.wikipedia.org/wiki/Primary_color **/
	public static var red(default, null):IFixedRgb;
	public static var green(default, null):IFixedRgb;
	public static var blue(default, null):IFixedRgb;
	
	/** Secondary * http://en.wikipedia.org/wiki/Secondary_color **/
	public static var yellow(default, null):IFixedRgb;
	public static var cyan(default, null):IFixedRgb;
	public static var magenta(default, null):IFixedRgb;
	
	/** Tertiary * http://en.wikipedia.org/wiki/Tertiary_color **/
	public static var azure(default, null):IFixedRgb;
	public static var violet(default, null):IFixedRgb;
	public static var rose(default, null):IFixedRgb;
	public static var orange(default, null):IFixedRgb;
	public static var chartreuse(default, null):IFixedRgb;
	public static var springGreen(default, null):IFixedRgb;
	
	/** Obvious ones **/
	public static var clear(default, null):IFixedRgb;
	
	public static var known(default, null):ReadOnlyArray<IFixedRgb>;	
	
	/** Creation methods **/
	/**
	 * Creates a new color from the specified arguments.
	 * @param	rgb The rgb value of for the new color.
	 * @param	a The alpha component value of for the new color.
	 * @return a new color from the specified arguments.
	 */
	public static function fromRgb(rgb:Int, a:Float = 0):Rgb {
		return new Rgb(m(rgb >> 16) / 255, m(rgb >> 8) / 255, m(rgb) / 255, a);
	}
}