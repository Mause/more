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
import haxe.more.Default;
import haxe.CallStack;
using haxe.more.color.Hsl;
using haxe.more.data.Manipulation;
using haxe.more.Default;
using Std;
#if neko
import haxe.Int32;
using haxe.Int32;
#end

class Hsl implements IHsl {
	var _h:Float;
	var _s:Float;
	var _l:Float;
	var _a:Float;

	public function new(h:Float, s:Float, l:Float, a:Float = 0) {
		this.h = h;
		this.s = s;
		this.l = l;
		this.a = a;
	}

	public function toString():String
		return "hsla(" + h + ", " + s + ", " + l + ", " + a + ")";

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
		return new Hsl(a.h, a.s, a.l, a.a);

	/**
	 * Modifies the color of [a] by avaraging with [b].
	 * @param	a The color to modify.
	 * @param	b The modifier.
	 * @param	padding The scale to apply what.
	 * @return The modified [a].
	 */
	public static function avarageRight(a:Hsl, b:IFixedHsl, padding:Float = 0.5):Hsl {
		if (a == null) throw new ArgumentNullException("a");
		if (b == null) throw new ArgumentNullException("b");
		var inverse = 1 - padding;
		var correctedH = b.h < a.h ? b.h + 360 : b.h;
		a.h = a.h * inverse + correctedH * padding;
		a.s = a.s * inverse + b.s * padding;
		a.l = a.l * inverse + b.l * padding;
		a.a = a.a * inverse + b.a * padding;
		return a;
	}
	public static function avarageLeft(a:Hsl, b:IFixedHsl, padding:Float = 0.5):Hsl {
		if (a == null) throw new ArgumentNullException("a");
		if (b == null) throw new ArgumentNullException("b");
		var inverse = 1 - padding;
		var correctedH = b.h < a.h ? a.h - 360 : a.h;
		a.h = correctedH * padding + b.h * inverse;
		a.s = a.s * padding + b.s * inverse;
		a.l = a.l * padding + b.l * inverse;
		a.a = a.a * padding + b.a * inverse;
		return a;
	}

	/** Converters **/
	/** Hsl to Rgb * http://en.wikipedia.org/wiki/HSL_and_HSV#Conversion_from_HSL_to_RGB **/
	/**
	 * Convert a hsl color to the rgb32 color space.
	 * @param	rgb The color to convert.
	 * @return the converted color.
	 */
	public static function toRgb32(hsl:IFixedHsl):Rgb32 {
		var s = hsl.s;
		var l = hsl.l;
		if (s == 0) {
			var value = (l * 255).int();
			return new Rgb32(value.int(), value.int(), value.int(), (hsl.a * 255).int());
		}

		var h = hsl.h / 360;
		var q = if (l < 1 / 2)
				l * (1 + s)
			else
				l + s - (l * s);
		var p = 2 * l - q;
		var tr = h + 1 / 3;
		var tg = h;
		var tb = h - 1 / 3;

		if (tr < 0) tr += 1;
		else if (tr > 1) tr -= 1;
		if (tg < 0) tg  += 1;
		else if (tg  > 1) tg  -= 1;
		if (tb < 0) tb += 1;
		else if (tb > 1) tb -= 1;

		tr = if (tr < 1 / 6)
				p + ((q - p) * 6 * tr)
			else if (tr < 1 / 2)
				q
			else if (tr < 2 / 3)
				p + ((q - p) * 6 * (2 / 3 - tr))
			else
				p;
		tg = if (tg < 1 / 6)
				p + ((q - p) * 6 * tg)
			else if (tg < 1 / 2)
				q
			else if (tg < 2 / 3)
				p + ((q - p) * 6 * (2 / 3 - tg))
			else
				p;
		tb = if (tb < 1 / 6)
				p + ((q - p) * 6 * tb)
			else if (tb < 1 / 2)
				q
			else if (tb < 2 / 3)
				p + ((q - p) * 6 * (2 / 3 - tb))
			else
				p;

		var r = (tr * 255).int();
		var g = (tg * 255).int();
		var b = (tb * 255).int();

		return new Rgb32(r, g, b, (hsl.a * 255).int());
	}

	/**
	 * Convert a hsl color to the rgb color space.
	 * @param	rgb The color to convert.
	 * @return the converted color.
	 */
	public static function toRgb(hsl:IFixedHsl):Rgb {
		var s = hsl.s;
		var l = hsl.l;
		if (s == 0) {
			return new Rgb(l, l, l, hsl.a);
		}

		var h = hsl.h / 360;
		var q = if (l < 1 / 2)
				l * (1 + s)
			else
				l + s - (l * s);
		var p = 2 * l - q;
		var tr = h + 1 / 3;
		var tg = h;
		var tb = h - 1 / 3;

		if (tr < 0) tr += 1;
		else if (tr > 1) tr -= 1;
		if (tg < 0) tg  += 1;
		else if (tg  > 1) tg  -= 1;
		if (tb < 0) tb += 1;
		else if (tb > 1) tb -= 1;

		tr = if (tr < 1 / 6)
				p + ((q - p) * 6 * tr)
			else if (tr < 1 / 2)
				q
			else if (tr < 2 / 3)
				p + ((q - p) * 6 * (2 / 3 - tr))
			else
				p;
		tg = if (tg < 1 / 6)
				p + ((q - p) * 6 * tg)
			else if (tg < 1 / 2)
				q
			else if (tg < 2 / 3)
				p + ((q - p) * 6 * (2 / 3 - tg))
			else
				p;
		tb = if (tb < 1 / 6)
				p + ((q - p) * 6 * tb)
			else if (tb < 1 / 2)
				q
			else if (tb < 2 / 3)
				p + ((q - p) * 6 * (2 / 3 - tb))
			else
				p;
		return new Rgb(tr, tg, tb, hsl.a);
	}

		/** Default **/
	static inline function max(a:Float, b) return a > b ? a : b;
	static inline function min(a:Float, b) return a < b ? a : b;
	static inline function cap(minimum:Float, maximum, value) return min(maximum, max(minimum, value));
	static inline function mod(moderator:Float, value) return value >= moderator ? value % moderator : value < 0 ? value % moderator + moderator : value;
	static inline function sMod(c:Float, value) return value < 0 ? value + c : value > c ? value - c : value;

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
