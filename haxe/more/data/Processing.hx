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