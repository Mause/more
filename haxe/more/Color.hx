/** Color.hx
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
#if neko
import haxe.Int32;
using haxe.Int32;
#end

class Color {		
	var rgb:Int; // The rgb part, 24 bits are used
	var a:Int; // The alpha shade, 8 bits for him
	
	public function new(r:Int, g:Int, b:Int, a:Int = 0) {
		RGB = m(r) << 16 | m(g) << 8 | m(b);
		A = a;
	}
	
	
	/** Below all the code to correctly apply the colors **/
	public var RGB(gRGB, sRGB):Int;
	function gRGB():Int {
		return rgb;
	}
	function sRGB(value:Int):Int {
		rgb = value & 0xFFFFFF;
		return RGB;
	}
	
	public var A(gA, sA):Int;
	function gA():Int {
		return a;
	}
	function sA(value:Int):Int {
		a = m(value);
		return A;
	}
	
	public var R(gR, sR):Int;
	function gR():Int {
		return m(RGB  >> 16);
	}
	function sR(value:Int):Int {
		RGB = RGB & 0x00FFFF | m(value) << 16;
		return R;
	}
	
	public var G(gG, sG):Int;
	function gG():Int {
		return m(RGB >> 8);
	}
	function sG(value:Int):Int {
		RGB = RGB & 0x00FFFF | m(value) << 8;
		return G;
	}
	
	public var B(gB, sB):Int;
	function gB():Int {
		return m(RGB);
	}
	function sB(value:Int):Int {
		RGB = RGB & 0x00FFFF | m(value);
		return B;
	}
	
	#if neko
	public var RGBA(gRGBA, sRGBA):Int32;
	function gRGBA():Int32 {
		return Int32.make(RGB >> 8 & 0xFFFF, RGB << 8 & 0xFF00 | A);
	}
	function sRGBA(value:Int32):Int32 {
		RGB = value.shr(8).toInt() & 0xFFFFFF;
		A = m(value.toInt());
		return RGBA;
	}
	#else
	public var RGBA(gRGBA, sRGBA):Int;
	function gRGBA():Int {
		return RGB << 8 | A;
	}
	function sRGBA(value:Int):Int {
		RGB = value >> 8 & 0xFFFFFF;
		A = m(value);
		return RGBA;
	}
	#end
	
	inline function m(color:Int):Int {
		return color & 0xFF;
	}
}