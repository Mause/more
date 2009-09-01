/** IntegerTools.hx
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

class IntegerTools {
	public static function even(value:Int):Bool {
		return (value % 2) == 0;
	}
	public static function to(from:Int, to:Int):Iterable<Int> {
		return new IntRangeIterable(from, to);
	}
}
class IntRangeIterable {
	private var _from:Int;
	private var _to:Int;
	public function new(from:Int, to:Int):Void {
		_from = from;
		_to = to;
	}
	public function iterator():Iterator<Int> {
		return new IntRangeIterator(_from, _to);
	}
}
class IntRangeIterator {
	private var _from:Int;
	private var _to:Int;
	public function new(from:Int, to:Int):Void {
		_from = from;
		_to = to;
	}
	public function hasNext():Bool {
		return _from < _to;
    }

    public function next():Int {
		return _from++;
    }
}