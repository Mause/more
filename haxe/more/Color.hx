/** Color.hx
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
package haxe.more;
#if neko
import haxe.Int32;
using haxe.Int32;
#end

class Color {		
	var _rgb:Int; // The _rgb part, 24 bits are used
	var _a:Int; // The alpha shade, 8 bits for him
	
	public function new(r:Int, g:Int, b:Int, a:Int = 0) {
		rgb = m(r) << 16 | m(g) << 8 | m(b);
		this.a = a;
	}
	
	
	/** Below _all the code to correctly _apply the colors **/
	public var rgb(gRgb, sRgb):Int;
	function gRgb():Int {
		return _rgb;
	}
	function sRgb(value:Int):Int {
		_rgb = value & 0xFFFFFF;
		return _rgb;
	}
	
	public var a(ga, sa):Int;
	function ga():Int {
		return _a;
	}
	function sa(value:Int):Int {
		_a = m(value);
		return _a;
	}
	
	public var r(gR, sR):Int;
	function gR():Int {
		return m(rgb >> 16);
	}
	function sR(value:Int):Int {
		rgb = rgb & 0x00FFFF | m(value) << 16;
		return r;
	}
	
	public var g(gG, sG):Int;
	function gG():Int {
		return m(rgb >> 8);
	}
	function sG(value:Int):Int {
		rgb = rgb & 0x00FFFF | m(value) << 8;
		return g;
	}
	
	public var b(gB, sB):Int;
	function gB():Int {
		return m(rgb);
	}
	function sB(value:Int):Int {
		rgb = rgb & 0x00FFFF | m(value);
		return b;
	}
	
	#if neko
	public var rgba(gRgba, sRgba):Int32;
	function gRgba():Int32 {
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
	
	
	
	/** Using methods **/
	/**
	 * Adds a color
	 * @param	a The color to be modified
	 * @param	b The source color
	 */
	public inline static function add(a:Color, b:Color):Color {
		a._rgb = min(255, a.r + b.r) << 16  | min(255, a.g + b.g) << 8 | min(255, a.b + b.b);
		return a;
	}
	
	public static function clone(a:Color):Color {
		return new Color(a.r, a.g, a.b, a.a);
	}
	
	public static function avarage(a:Color, b:Color, padding:Float = 0.5):Color {
		if(padding == 0.5) {
			a._rgb = ((a._rgb & 0xFF00FF) + (b._rgb & 0xFF00FF)) >> 1 & 0xFF00FF
				| m((m(a._rgb >> 8) + m(b._rgb >> 8)) >> 1) << 8;
			a._a = m((a._a + b._a) >> 1);
		} else {
			
		}
		return a;
	}
	
	public inline static function subtract(a:Color, b:Color):Color {
		a._rgb = max(0, a.r - b.r) << 16  | max(0, a.g - b.g) << 8 | max(0, a.b - b.b);
		return a;
	}
	
	
	/** Helpers **/
	static inline function max(a, b) {
		return a > b ? a : b;
	}
	
	static inline function min(a, b) {
		return a < b ? a : b;
	}
	
	static inline function m(color) {
		return color & 0xFF;
	}
}