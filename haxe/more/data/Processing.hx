/**
 * ...
 * @author Dykam
 */

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