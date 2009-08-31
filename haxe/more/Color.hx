/**
 * Copyright (c) 2009 Mark de Bruijn (kramieb@gmail.com | Dykam.nl)
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the University of California, Berkeley nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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