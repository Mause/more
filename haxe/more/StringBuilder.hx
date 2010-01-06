/** StringBuilder.hx
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
#if flash
import flash.utils.ByteArray;
#else
import StringBuf;
#end

class StringBuilder {
	var _strings:#if flash ByteArray #else StringBuf #end;
	
	public var length(default, null):Int;
	
	public function new() {
		_strings = new #if flash ByteArray #else add #end();
	}
	
	public inline function append(string:String):StringBuilder {
		#if flash
			_strings.writeUTFBytes(string);
		#else
			_strings.add(string);
		#end
		length += string.length;
		return this;
	}
	
	public inline function appendX(?value:Dynamic):StringBuilder {
		return append(Std.string(value));
	}
	
	public inline function appendChar(char:Int) {
		#if flash
			_strings.writeInt(char);
		#else
			_strings.addChar(char);
		#end
		length += 1;
		return this;
	}
	
	public inline function appendNumber(number:Float):StringBuilder {
		return append(Std.string(number));
	}
	
	public inline function appendLine(string:String = ""):StringBuilder {
		return append(string).append(Default.newLine);
	}
	
	/**
	 * Returns the builded string.
	 * @return the builded string.
	 */
	public inline function toString():String {
		_strings.position = 0;
		var result = _strings.readUTFBytes(_strings.length);
		_strings.position = _strings.length;
		return result;
	}
}