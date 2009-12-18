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
import haxe.Timer;
import haxe.more.exceptions.ArgumentNullException;
using haxe.more.data.Processing;

class Processing {	
	public static function evaluate<T>(subject:Iterable<T>, timeSpan:Int = 0, evaluationsPerTick:Int = 1, ?completed:Void -> Void):Void {
		if (subject == null) throw new ArgumentNullException("subject");
		var iter = subject.iterator();
		if (timeSpan != 0) {
			if (evaluationsPerTick != 1) {
				var evaluations:Int;
				var t = new Timer(timeSpan);
				t.run = function() {
					evaluations = evaluationsPerTick;
					while(evaluations-- != 0) {
						if (iter.hasNext()) {
							iter.next();
						} else {
							t.stop();
							if(completed != null) completed();
							break;
						}
					}
				};
			} else {
				var t = new Timer(timeSpan);
				t.run = function() {
					if (iter.hasNext()) {
						iter.next();
					} else {
						t.stop();
						if(completed != null) completed();
					}
				};
			}
		} else {
			while (iter.hasNext()) iter.next();
			if(completed != null) completed();
		}
	}
	
	public static function trace<T>(subject:Iterable<T>):Iterable<T> {
		return subject.apply(function(item) trace(item));
	}
	
	public static function apply<T>(subject:Iterable<T>, action: T -> Void):Iterable<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		if (action == null) throw new ArgumentNullException("action");
		return new ApplyIterable(subject, action);
	}
	
	public static function range<T>(generator: T -> T, to:T, ?seed:T):Iterable<T> {
		if (generator == null) throw new ArgumentNullException("generator");
		return new RangeIterable(generator, to, seed);
	}
}

private class ApplyIterable<T> {
	var _subject:Iterable<T>;
	var _action: T -> Void;
	
	public function new(subject:Iterable<T>, action: T -> Void) {
		_subject = subject;
		_action = action;
	}
	
	public function iterator():Iterator<T> {
		return new ApplyIterator(_subject.iterator(), _action);
	}
}
private class ApplyIterator<T> {
	var _subject:Iterator<T>;
	var _action: T -> Void;
	
	public function new(subject:Iterator<T>, action: T -> Void) {
		_subject = subject;
		_action = action;
	}
	
	public function hasNext():Bool {
		return _subject.hasNext();
	}
	
	public function next():T {
		if (hasNext()) {
			var result = _subject.next();
			_action(result);
			return result;
		}
		return null;
	}
}

private class RangeIterable<T> {
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
private class RangeIterator<T> {
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