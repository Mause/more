/** Functions.hx
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
import haxe.more.data.flow.Enumerable;
import haxe.more.data.flow.Enumerator;
import haxe.more.exceptions.ArgumentNullException;

class Functions {	
	/**
	 * @param source	A function accepting a break function and returning the next value.
	 */
	public static function gather<T>(source: (Void -> Void) -> T):Enumerable<T> {
		if (source == null) throw new ArgumentNullException("source");
		return new GatherEnumerable(source);
	}
	
	/**
	 * @param source	A function accepting a break function and returning the next value.
	 */
	public static function endlessGather<T>(source: Void -> T):Enumerable<T> {
		if (source == null) throw new ArgumentNullException("source");
		return new EndlessGatherEnumerable(source);
	}
	
	/**
	 * @param source	A function accepting a break function, a state value and returning the next value.
	 */
	public static function statefullStatefullGather<T, S>(
		source: (Void -> Void) -> S -> T,
		startupStateGenerator: Void -> S):Enumerable<T> {
		if (source == null) throw new ArgumentNullException("source");
		if (startupStateGenerator == null) throw new ArgumentNullException("startupStateGenerator");
		return new StatefullGatherEnumerable(source, startupStateGenerator);
	}
}

private class StatefullGatherEnumerable<T, S> implements Enumerable<T> {
	var _source: (Void -> Void) -> S -> T;
	var _startupStateGenerator: Void -> S;
	public function new(source: (Void -> Void) -> S -> T, startupStateGenerator: Void -> S) {
		_source = source;
		_startupStateGenerator = startupStateGenerator;
	}
	
	public function getEnumerator():Enumerator<T> {
		return new StatefullGatherEnumerator(_source, _startupStateGenerator());
	}
}
private class StatefullGatherEnumerator<T, S> implements Enumerator<T> {
	var _source: (Void -> Void) -> S -> T;
	var _continue:Bool;
	var _state:S;
	
	public var current(default, null):T;
	
	public function new(source: (Void -> Void) -> S -> T, startupState:S) {
		_source = source;
		_continue = true;
		_state = startupState;
	}
	
	public function moveNext():Bool {
		if (!_continue) return false;
		current = _source(stop, _state);
		return _continue;
	}
	
	function stop():Void {
		_continue = false;
	}
}

private class GatherEnumerable<T> implements Enumerable<T> {
	var _source: (Void -> Void) -> T;
	public function new(source: (Void -> Void) -> T) {
		_source = source;
	}
	
	public function getEnumerator():Enumerator<T> {
		return new GatherEnumerator(_source);
	}
}
private class GatherEnumerator<T> implements Enumerator<T> {
	var _source: (Void -> Void) -> T;
	var _continue:Bool;
	
	public var current(default, null):T;
	
	public function new(source: (Void -> Void) -> T) {
		_source = source;
		_continue = true;
	}
	
	public function moveNext():Bool {
		if (!_continue) return false;
		current = _source(stop);
		return _continue;
	}
	
	function stop() {
		_continue = false;
	}
}

private class EndlessGatherEnumerable<T> implements Enumerable<T> {
	var _source: Void -> T;
	public function new(source: Void -> T) {
		_source = source;
	}
	
	public function getEnumerator():Enumerator<T> {
		return new EndlessGatherEnumerator(_source);
	}
}
private class EndlessGatherEnumerator<T> implements Enumerator<T> {
	var _source: Void -> T;
	
	public var current(default, null):T;
	
	public function new(source: Void -> T) {
		_source = source;
	}
	
	public function moveNext():Bool {
		current = _source();
		return true;
	}
}