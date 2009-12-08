/** String.hx
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
package haxe.more.data.sources;
import haxe.more.exceptions.ArgumentNullException;

class StringSource {
	public static function iterator(string:String):Iterator<String> {
		if (string == null) throw new ArgumentNullException("string");
		return new StringIterator(string);
	}
	public static function iterable(string:String):Iterable<String> {
		if (string == null) throw new ArgumentNullException("string");
		return new StringIterable(string);
	}
}

class StringIterable {	
	var _string:String;
	public function new(string:String) {
		_string = string;
	}
	
	public function iterator():Iterator<String> {
		return new StringIterator(_string);
	}
}

class StringIterator {
	private var index:Int;
	private var string:String;
	private var r:Bool;
	public function new(s:String, ?reverse:Bool) {
		r = reverse;
		index = reverse ? s.length : 0;
		string = s;
	}
	public function hasNext():Bool {
		return r ? (index > 0) : (index < string.length);
	}
	public function next():String {
		return string.charAt(r ? --index : index++);
	}

}