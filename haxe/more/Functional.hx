/**
 * ...
 * @author Dykam
 */

package haxe.linq;

class Functional
{
	private function new();
	
	/**
	 * @param source	A function accepting a break function and returning the next value.
	 */
	private static function Gather<T>(source: (Void -> Void) -> T):Iterable<T> {
		return new GatherIterable(source);
	}
	
	/**
	 * @param source	A function accepting a break function, a state value and returning the next value.
	 */
	public static function statefullStatefullGather<T, S>(source: (Void -> Void) -> S -> T, startupStateGenerator: Void -> S):Iterable<T> {
		return new StatefullGatherIterable(source, startupStateGenerator);
	}
}

class StatefullGatherIterable<T, S> {
	var _source: (Void -> Void) -> S -> T;
	var _startupStateGenerator: Void -> S;
	public function new(source: (Void -> Void) -> S -> T, startupStateGenerator: Void -> S) {
		_source = source;
		_startupStateGenerator = startupStateGenerator;
	}
	
	public function iterator():Iterator<T> {
		return new StatefullGatherIterator(_source, _startupStateGenerator());
	}
}
class StatefullGatherIterator<T, S> {
	var _source: (Void -> Void) -> S -> T;
	var _hasNext:Bool;
	var _state:S;
	public function new(source: (Void -> Void) -> S -> T, startupState:S) {
		_source = source;
		_hasNext = true;
		_state = startupState;
	}
	
	function stop():Void {
		_hasNext = false;
	}
	
	public function hasNext():Bool {
		return _hasNext;
	}
	
	public function next():T {
		if(hasNext()) {
			return _source(stop, _state);
		}
		return null;
	}
}



class GatherIterable<T, S> {
	var _source: (Void -> Void) -> T;
	var _startupStateGenerator: Void -> S;
	public function new(source: (Void -> Void) -> T) {
		_source = source;
	}
	
	public function iterator():Iterator<T> {
		return new GatherIterator(_source);
	}
}
class GatherIterator<T, S> {
	var _source: (Void -> Void) -> T;
	var _hasNext:Bool;
	public function new(source: (Void -> Void) -> T) {
		_source = source;
		_hasNext = true;
	}
	
	function stop():Void {
		_hasNext = false;
	}
	
	public function hasNext():Bool {
		return _hasNext;
	}
	
	public function next():T {
		if(hasNext()) {
			return _source(stop);
		}
		return null;
	}
}