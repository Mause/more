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