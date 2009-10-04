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
package haxe.more.color;
import haxe.more.data.structures.ReadOnlyArray;

using haxe.more.color.Color;
using haxe.more.color.Colors;
using haxe.more.data.Manipulation;
using Std;

/** Additive colors here * http://en.wikipedia.org/wiki/Additive_color **/
class Colors {
	static var init = (function() {
		known = new ReadOnlyArray([		
		red = new KnownColor("red", new Color(255, 0, 0)),
		green = new KnownColor("green", new Color(0, 255, 0)),
		blue = new KnownColor("green", new Color(0, 0, 255)),
		
		magenta = blue		.named("magenta")		.add(red),
		cyan = green		.named("cyan")			.add(blue),
		yellow = red		.named("yellow")		.add(green),
		
		rose = red			.named("rose")			.avarage(magenta),
		violet = magenta	.named("violet")		.avarage(blue),
		azure = blue		.named("azure")			.avarage(cyan),
		springGreen = cyan	.named("springGreen")	.avarage(green),
		chartreuse = green	.named("chartreuse")	.avarage(yellow),
		orange = yellow		.named("orange")		.avarage(red)
		]);
	})();
	
	/** Primary * http://en.wikipedia.org/wiki/Primary_color **/
	public static var red(default, null):FixedColor;
	public static var green(default, null):FixedColor;
	public static var blue(default, null):FixedColor;
	
	/** Secondary * http://en.wikipedia.org/wiki/Secondary_color **/
	public static var yellow(default, null):FixedColor;
	public static var cyan(default, null):FixedColor;
	public static var magenta(default, null):FixedColor;
	
	/** Tertiary * http://en.wikipedia.org/wiki/Tertiary_color **/
	public static var azure(default, null):FixedColor;
	public static var violet(default, null):FixedColor;
	public static var rose(default, null):FixedColor;
	public static var orange(default, null):FixedColor;
	public static var chartreuse(default, null):FixedColor;
	public static var springGreen(default, null):FixedColor;
	
	public static var known(default, null):ReadOnlyArray<FixedColor>;
	
	
	/** Creation methods **/
	/**
	 * Creates a new color from the specified arguments.
	 * @param	rgb The rgb value of for the new color.
	 * @param	a The alpha component value of for the new color.
	 * @return a new color from the specified arguments.
	 */
	public static function fromRgbA(rgb:Int, a:Int = 0):Color {
		var known:KnownColor = cast known.first(function(color) return color.rgb == rgb && color.a == a);
		return known == null ? new Color(rgb >> 16, rgb >> 8, rgb, a) : new KnownColor(known.name, known);
	}
}
class KnownColor extends Color {
	public var name:String;
	public function new(name:String, origin:FixedColor) {
		super(origin.r, origin.g, origin.b, origin.a);
		this.name = name;
	}
	public override function toString() return "Color \"" + name + "\""
	public static function named(origin:FixedColor, name:String) return new KnownColor(name, origin)
}