/** BitArray.hx
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