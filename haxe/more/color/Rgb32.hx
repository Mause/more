/** Rgb32.hx
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
using haxe.more.color.Rgb32;
using haxe.more.data.Manipulation;
using haxe.more.Default;
using Std;
#if neko
import haxe.Int32;
using haxe.Int32;
#end

class Rgb32 implements IRgb32 {
	var _rgb:Int; // The _rgb part, 24 bits are used
	var _a:Int; // The alpha shade, 8 bits for him

	public function new(r:Int, g:Int, b:Int, a:Int = 0) {
		rgb = m(r) << 16 | m(g) << 8 | m(b);
		this.a = a;
	}

	public function toString():String
		return "rgba32( " + r + ", " + g + ", " + b + ", " + a + ")";


	/** Below all the code to correctly apply the colors **/
	/**
	 * The rgb value of this color.
	 */
	public var rgb(gRgb, sRgb):Int;
	function gRgb():Int {
		return _rgb;
	}
	function sRgb(value:Int):Int {
		_rgb = value & 0xFFFFFF;
		return _rgb;
	}

	/**
	 * The alpha component of this color.
	 */
	public var a(gA, sA):Int;
	function gA():Int {
		return _a;
	}
	function sA(value:Int):Int {
		_a = m(value);
		return _a;
	}

	/**
	 * The red component of this color.
	 */
	public var r(gR, sR):Int;
	function gR():Int {
		return m(rgb >> 16);
	}
	function sR(value:Int):Int {
		rgb = rgb & 0x00FFFF | m(value) << 16;
		return r;
	}

	/**
	 * The green component of this color.
	 */
	public var g(gG, sG):Int;
	function gG():Int {
		return m(rgb >> 8);
	}
	function sG(value:Int):Int {
		rgb = rgb & 0x00FFFF | m(value) << 8;
		return g;
	}

	/**
	 * The blue component of this color.
	 */
	public var b(gB, sB):Int;
	function gB():Int {
		return m(rgb);
	}
	function sB(value:Int):Int {
		rgb = rgb & 0x00FFFF | m(value);
		return b;
	}

	/**
	 * The rgba value of this color.
	 */
	#if neko
	public var rgba(gRgba, sRgba):Int32;
	function gRgb32a():Int32 {
		return Int32.make(rgb >> 8 & 0xFFFF, rgb << 8 & 0xFF00 | _a);
	}
	function sRgba(value:Int32):Int32 {
		rgb = value.shr(8).toInt() & 0xFFFFFF;
		_a = m(value.toInt());
		return rgba;
	}
	#else
	public var rgba(gRgba, sRgba):Int;
	function gRgba():Int {
		return rgb << 8 | _a;
	}
	function sRgba(value:Int):Int {
		rgb = value >> 8 & 0xFFFFFF;
		_a = m(value);
		return rgba;
	}
	#end

	/**
	 * The argb value of this color.
	 */
	#if neko
	public var argb(gArgb, sArgb):Int32;
	function gArgb():Int32 {
		return Int32.make(_a << 8 | (_rgb >> 16 & 0xFF) | _rgb & 0xFFFF);
	}
	function sRgba(value:Int32):Int32 {
		rgb = value.toInt();
		_a = m(value.shr(24).toInt());
		return rgba;
	}
	#else
	public var argb(gArgb, sArgb):Int;
	function gArgb():Int {
		return (_a << 24) | _rgb;
	}
	function sArgb(value:Int):Int {
		rgb = value;
		_a = m(value >> 24);
		return rgba;
	}
	#end



	/** Using methods **/
	/**
	 * Modifies the color of [a] by adding [b].
	 * @param	a The color to modify.
	 * @param	b The modifier.
	 * @return The modified [a].
	 */
	public inline static function add(a:Rgb32, b:IFixedRgb32):Rgb32 {
		a._rgb = min(255, a.r + b.r) << 16  | min(255, a.g + b.g) << 8 | min(255, a.b + b.b);
		return a;
	}

	/**
	 * Clones [a].
	 * @param	a The color to clone.
	 * @return A clone of [a].
	 */
	public static inline function clone(a:IFixedRgb32):Rgb32
		return new Rgb32(a.r, a.g, a.b, a.a);

	/**
	 * Modifies the color of [a] by avaraging with [b].
	 * @param	a The color to modify.
	 * @param	b The modifier.
	 * @param	padding The scale to apply what.
	 * @return The modified [a].
	 */
	public static function avarage(a:Rgb32, b:IFixedRgb32, padding:Float = 0.5):Rgb32 {
		if (a == null) throw new ArgumentNullException("a");
		if (b == null) throw new ArgumentNullException("b");

		if (padding == 0.5) {
			if (b.is(Rgb32)) {
				var b:Rgb32 = cast b;
				a._rgb = ((a._rgb & 0xFF00FF) + (b._rgb & 0xFF00FF)) >> 1 & 0xFF00FF
					| m((m(a._rgb >> 8) + m(b._rgb >> 8)) >> 1) << 8;
				a._a = m((a._a + b._a) >> 1);
			} else {
				var rgb = b.rgb;
				a._rgb = ((a._rgb & 0xFF00FF) + (rgb & 0xFF00FF)) >> 1 & 0xFF00FF
					| m((m(a.rgb >> 8) + m(rgb >> 8)) >> 1) << 8;
				a._a = m((a._a + b.a) >> 1);
			}
		} else {
			var inverse = 1 - padding;
			if (b.is(Rgb32)) {
				var b:Rgb32 = cast b;
				a._rgb =
					m((m(a._rgb >> 16) * inverse + m(b._rgb >> 16) * padding).int()) << 16
					| m((m(a._rgb >> 8) * inverse + m(b._rgb >> 8) * padding).int()) << 8
					| m((m(a._rgb) * inverse + m(b._rgb) * padding).int());
				a._a = m((a._a + b._a) >> 1);
			} else {
				var rgb = b.rgb;
				a._rgb =
					m((m(a._rgb >> 16) * inverse + m(rgb >> 16) * padding).int()) << 16
					| m((m(a._rgb >> 8) * inverse + m(rgb >> 8) * padding).int()) << 8
					| m((m(a._rgb) * inverse + m(rgb) * padding).int());
				a._a = m((a._a + b.a) >> 1);
			}
		}
		return a;
	}

	/**
	 * Modifies the color of [a] by subtracting [b].
	 * @param	a The color to modify.
	 * @param	b The modifier.
	 * @return The modified [a].
	 */
	public inline static function subtract(a:Rgb32, b:IFixedRgb32):Rgb32 {
		a._rgb = max(0, a.r - b.r) << 16  | max(0, a.g - b.g) << 8 | max(0, a.b - b.b);
		return a;
	}

	/** Converters **/
	/** Hsl to Rgb * http://en.wikipedia.org/wiki/HSL_and_HSV#Conversion_from_HSL_to_RGB **/
	/**
	 * Convert a rgb32 color to the hsl color space.
	 * @param	rgb The color to convert.
	 * @return the converted color.
	 */
	public static function toHsl(rgb:IFixedRgb32):Hsl {
		var r = rgb.r / 255;
		var g = rgb.g / 255;
		var b = rgb.b / 255;
		var a = rgb.a / 255;
		var max = maxF(r, maxF(b, g));
		var min = minF(r, minF(g, b));
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
		return new Hsl(h, s, l, a);
	}

	/**
	 * Convert a rgb32 color to the rgb color space.
	 * @param	rgb The color to convert.
	 * @return the converted color.
	 */
	public static function toRgb(rgb:IFixedRgb32):Rgb {
		return new Rgb(
			rgb.r / 255,
			rgb.g / 255,
			rgb.b / 255,
			rgb.a / 255
		);
	}


	/** Default **/
	static inline function max(a, b) return a > b ? a : b;
	static inline function min(a, b) return a < b ? a : b;
	static inline function m(color) return color & 0xFF; // masks.
	static inline function maxF(a:Float, b):Float return a > b ? a : b;
	static inline function minF(a:Float, b) return a < b ? a : b;

	/** Presets **/

	static var init = (function() {
		known = new ReadOnlyArray([
		red = new Rgb32(255, 0, 0),
		green = new Rgb32(0, 255, 0),
		blue = new Rgb32(0, 0, 255),

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

		clear = new Rgb32(255, 255, 255, 255);
	})();

	/** Primary * http://en.wikipedia.org/wiki/Primary_color **/
	public static var red(default, null):IFixedRgb32;
	public static var green(default, null):IFixedRgb32;
	public static var blue(default, null):IFixedRgb32;

	/** Secondary * http://en.wikipedia.org/wiki/Secondary_color **/
	public static var yellow(default, null):IFixedRgb32;
	public static var cyan(default, null):IFixedRgb32;
	public static var magenta(default, null):IFixedRgb32;

	/** Tertiary * http://en.wikipedia.org/wiki/Tertiary_color **/
	public static var azure(default, null):IFixedRgb32;
	public static var violet(default, null):IFixedRgb32;
	public static var rose(default, null):IFixedRgb32;
	public static var orange(default, null):IFixedRgb32;
	public static var chartreuse(default, null):IFixedRgb32;
	public static var springGreen(default, null):IFixedRgb32;

	/** Obvious ones **/
	public static var clear(default, null):IFixedRgb32;

	public static var known(default, null):ReadOnlyArray<IFixedRgb32>;

	/** Creation methods **/
	/**
	 * Creates a new color from the specified arguments.
	 * @param	rgb The rgb value of for the new color.
	 * @param	a The alpha component value of for the new color.
	 * @return a new color from the specified arguments.
	 */
	public static function fromInt(rgb:Int, a:Int = 0):Rgb32 {
		return new Rgb32(rgb >> 16, rgb >> 8, rgb, a);
	}
}
