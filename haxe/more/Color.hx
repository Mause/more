/**
 * ...
 * @author Dykam
 */

package haxe.more;
#if neko
import haxe.Int32;
using haxe.Int32;
#end

class Color {	
	public function new(r:Int, g:Int, b:Int, a:Int = 0) {
		RGB = m(r) << 16 | m(g) << 8 | m(b);
		A = a;
	}
	
	var rgb:Int;
	public var RGB(gRGB, sRGB):Int;
	function gRGB():Int {
		return rgb;
	}
	function sRGB(value:Int):Int {
		rgb = value & 0xFFFFFF;
		return RGB;
	}
	
	var a:Int;
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