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

using haxe.more.Color;
using Std;

/** Additive colors here * http://en.wikipedia.org/wiki/Additive_color **/
class Colors {
	static var init = (function() {
		red = new Color(255, 0, 0);
		green = new Color(0, 255, 0);
		blue = new Color(0, 0, 255);
		
		magenta = blue.clone().add(red);
		cyan = green.clone().add(blue);
		yellow = red.clone().add(green);
		
		rose = red.clone().avarage(magenta);
		violet = magenta.clone().avarage(blue);
		azure = blue.clone().avarage(cyan);
		springGreen = cyan.clone().avarage(green);
		chartreuse = green.clone().avarage(yellow);	
		orange = yellow.clone().avarage(red);
	})();
	
	/** Primary * http://en.wikipedia.org/wiki/Primary_color **/
	public static var red(default, null):Color;
	public static var green(default, null):Color;
	public static var blue(default, null):Color;
	
	/** Secondary * http://en.wikipedia.org/wiki/Secondary_color **/
	public static var yellow(default, null):Color;
	public static var cyan(default, null):Color;
	public static var magenta(default, null):Color;
	
	/** Tertiary * http://en.wikipedia.org/wiki/Tertiary_color **/
	public static var azure(default, null):Color;
	public static var violet(default, null):Color;
	public static var rose(default, null):Color;
	public static var orange(default, null):Color;
	public static var chartreuse(default, null):Color;
	public static var springGreen(default, null):Color;
	
	
	/** Creation methods **/
	public static inline function fromRgbA(rgb:Int, a:Int = 0) {
		return new Color(rgb >> 16, rgb >> 8, rgb, a);
	}
}