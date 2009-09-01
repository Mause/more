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

// Surely more have to be added.
class Colors {
	static var init = function() {
		Blue = new Color(0, 0, 255);
		Green = new Color(0, 255, 0);
		Red = new Color(255, 0, 0);
	}
	
	/** Primary **/
	public static var Red(default, null):Color;
	public static var Green(default, null):Color;
	public static var Blue(default, null):Color;
	
	/** Secondary **/
	public static var Yellow(default, null):Color;
	public static var Cyan(default, null):Color;
	public static var Magenta(default, null):Color;
	
	/** Using methods, keeps the colors clean **/
	public inline static function add(a:Color, b:Color, padding:Float = 0.5):Color {
		throw 0;
		return padding == 0.5 ? new Color(a.R + b.R, a.G + b.G, a.B + b.B, a.A + B.A);
	}
	
	/** Other Named **/
}