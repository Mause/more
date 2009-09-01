/** Processing.hx
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
package haxe.more.data;

class Processing {	
	public static function range<T>(generator: T -> T, to:T, ?seed:T):Iterable<T> {
		return new RangeIterable(generator, to, seed);
	}
	
}

class RangeIterable<T> {
	var _generator: T -> T;
	var _to:T;
	var _seed:T;
	
	public function new(generator: T -> T, to:T, ?seed:T) {
		_generator = generator;
		_to = to;
		_seed = seed;
	}
	
	public function iterator():Iterator<T> {
		return new RangeIterator(_generator, _to, _seed);
	}
}
class RangeIterator<T> {
	var _generator: T -> T;
	var _to:T;
	var _current:T;
	var _previous:T;
	var _hasNext:Bool;
	
	public function new(generator: T -> T, to:T, ?seed:T) {
		_generator = generator;
		_to = to;
		_previous = seed;
		_hasNext = true;
	}
	
	public function hasNext():Bool {
		return _hasNext;
	}
	
	public function next():T {
		if (hasNext()) {
			_previous = _current;
			_current = _generator(_current);
			if (_current == _to) _hasNext = false;
			return _previous;
		}
		return null;
	}
}