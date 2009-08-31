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
package haxe.more.datastructures;
import flash.Error;
import flash.Vector;

class BitArray /*implements ArrayAccess<Bool>*/ {
	static inline var intUse:Int = 31;
	var internal:Array<Int>;
	public function new():Void {
		internal = new Array<Int>();
		new Vector<Bool>()
		;
	}
	public var length(default, null):Int;
	function getByteWiseLength():Int {
		throw new Error("Not implemented");
		return 0;
	}
	public function concat(a:BitArray):BitArray {
		var result = slice(0);
		for (i in 0...a.length) {
			result.push(a.internal[Std.int(i / intUse)] & 0x1 << i % intUse == 0);
		}
		return result;		
	}
	
	public function iterator():Iterator < Bool > {
		throw new Error("Not implemented");
		return null;
	}
	
	public function join(?sep:String):String {
		var result = "";
		sep = sep == null ? "," : sep;
		var cycled = false;
		for (i in this) {
			result = (cycled ? sep : "" ) + i;
			cycled = true;
		}
		return result;
	}
	public function reverse():Void {		
		throw new Error("Not implemented");
	}
	public function slice(pos:Int, ?end:Int):BitArray{
		var result = new BitArray();
		end = end == null ? length : end;
		for (i in pos...end) {
			result.push(internal[Std.int(i / intUse)] & 0x1 << i % intUse != 0);
		}
		return result;	
	}
	public function sort(f : Bool -> Bool -> Int):Void {
		
	}
	public function splice(pos:Int, len:Int):BitArray {
		/**
		 * Start:
		 *| 10001010|10101101|10100101|10101101|10100101|10010   |
		 * Split at:     ^                ^
		 * Remove whole sections:
		 * |10001010|10101101|10101101|10100101|10010   |
		 * Split at:     ^       ^
		 * Delete bits:
		 * |10001010|10101   |    1101|10100101|10010   |
		 * Move bits to solidify sections:
		 * |10001010|10101110|       1|10100101|10010   |
		 * Move Bits to solifify sections:
		 * |10001010|10101110|11010010|110010  |        |
		 * Delete empty sections:
		 * |10001010|10101110|11010010|110010  |
		 */
		var resultTemp:Array<Bool>;
		var resultMiddle = internal.splice(Std.int(pos / intUse) + (pos % intUse != 0 ? 1 : 0), Std.int((len - pos % intUse) / intUse) + ((len - pos %intUse) % intUse != 0 ? 1 : 0));
		for (i in pos...(len % intUse)) {
			resultTemp.push(internal[Std.int(i / intUse)] & 0x1 << i % intUse != 0);
		}
		
	}
	public function toBoolArray():Array < Bool > {
		var result:Array<Bool> = new Array<Bool>();
		for (i in 0...length) {
			result.push(internal[Std.int(i / intUse)] & 0x1 << i % intUse == 0);
		}
		return result;
	}
	public function toByteArray():Array<Int> {
		var result:Array<Int> = new Array<Int>();
		throw new Error("Not implemented");
		return result;
	}
	//public function maskOr(mask:BitArray, offset:Int, ?bitOffset:Int):Void;
	//public function maskXor(mask:BitArray, offset:Int, ?bitOffset:Int):Void;
	//public function maskAnd(mask:BitArray, offset:Int, ?bitOffset:Int):Void;
	//public function maskInverse(offset:Int, length:Int, ?bitOffset:Int, ?bitLength:Int):Void
	
	/**
	 * The popshiftusnhiftpush methods
	 */
	
	/**
	 * Adds one or more elements to the end of the array and returns the new length of the array.
	 * @param	value
	 * @return	The new length of the array.
	 */
	public function push(value:Bool):UInt {
		return length;
	}
	public function pop():Null<Bool> {
		return null;
	}	
	public function shift(value:Bool):UInt {
		return length;
	}
	public function unshift():Null<Bool> {
		return null;
	}	
	
	/**
	 * Getters and Setters
	 */
	
	 
	public function getAtIndex(index:Int):Bool {
		return false;
	}
	public function setAtIndex(index:Int, value:Bool):Bool {
		return false;
	}
}