/** Manipulation.hx
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

using haxe.more.data.Manipulation;

/**
 * If you know Microsofts Linq, this will feel familiar to you.
 * Need restructuring.
 */

class Manipulation {	
	public static function where<T>(subject:Iterable<T>, predicate: T -> Bool):Iterable<T> {
		return new WhereIterable(subject, predicate);
	}
	
	public static function after<T>(subject:Iterable<T>, predicate: T -> Bool):Iterable<T> {
		return new AfterIterable(subject, predicate);
	}
	
	public static function until<T>(subject:Iterable<T>, predicate: T -> Bool):Iterable<T> {
		return new UntilIterable(subject, predicate);
	}
	
	public static function select<T, V>(subject:Iterable<T>, selector: T -> V):Iterable<V> {
		return new SelectIterable(subject, selector);
	}
	
	public static function first<T>(subject:Iterable<T>, ?predicate: T -> Bool):T {
		return predicate != null ? subject.where(predicate).iterator().next() : subject.iterator().next();
	}
	
	public static function toList<T>(subject:Iterable<T>):List<T> {
		var result = new List<T>();
		for (item in subject) {
			result.add(item);
		}
		return result;
	}
	
	public static function join<T>(scattered:Iterable<Iterable<T>>):Iterable<T> {
		return new ConcatIterable(scattered);
	}
	
	public static function toArray<T>(subject:Iterable<T>):Array<T> {
		var result = new Array<T>();
		for (item in subject) {
			result.push(item);
		}
		return result;
	}
	
	public static function avarage(subject:Iterable<Int>):Float {
		var amount = 0;
		var total = 0.0;
		var iter = subject.iterator();
		while (iter.hasNext()) {
			total += iter.next();
			amount++;
		}
		return total / amount;
	}
	
	public static function execute<T>(subject:Iterable<T>, action: T -> Void):Iterable<T> {
		return new ExecuteIterable(subject, action);
	}
	
	public static function fold<T, C>(subject:Iterable<T>, ?seed:C, aggregator: T -> C -> C):C {
		for (item in subject) {
			seed = aggregator(item, seed);
		}
		return seed;
	}
	
	public static function selectMany<T, U, V>(subject:Iterable<T>, collection:Iterable<U>, selector: T -> U -> V):Iterable<V> {
		return new ConcatIterable(
			subject.select(function(first)
				return collection.select(function(second)
					return selector(first, second)
				))
			);
	}
	
	public static function evaluate<T>(subject:Iterable<T>, ?timeSpan:Int, ?evaluationsPerTick:Int, ?completed:Void -> Void):Void {
		var iter = subject.iterator();
		if (timeSpan != null) {
			if (evaluationsPerTick != null) {
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
	
	public static function iterable<T>(subject:Iterator<T>):Iterable<T> {
		return new IteratorIterable(subject);
	}
	
	public static function concat<T>(subject:Iterable<T>, postfix1:Iterable<T>, ?postfix2:Iterable<T>, ?postfix3:Iterable<T>, ?postfix4:Iterable<T>):Iterable<T> {
		if (postfix2 != null) {
			if (postfix3 != null) {
				if (postfix4 != null) {
					return new ConcatIterable([subject, postfix1, postfix2, postfix3, postfix4]);
				}
				return new ConcatIterable([subject, postfix1, postfix2, postfix3]);
			}
			return new ConcatIterable([subject, postfix1, postfix2]);
		}
 		return new ConcatIterable([subject, postfix1]);
	}	
}

class ConcatIterable<T> {
	var _subjects:Iterable<Iterable<T>>;
	
	public function new(subjects:Iterable<Iterable<T>>) {
		_subjects = subjects;
	}
	
	public function iterator():Iterator<T> {
		return new ConcatIterator(_subjects.select(function(iter) return iter.iterator()).iterator());
	}
}
class ConcatIterator<T> {
	var _subjects:Iterator<Iterator<T>>;
	var _hasNext:Bool;
	var _current:Iterator<T>;
	
	public function new(subjects:Iterator<Iterator<T>>) {
		_subjects = subjects;
		_current = subjects.next();
		_hasNext = true;
	}
	
	public function hasNext():Bool {
		return _hasNext;
	}
	
	public function next():T {
		if (_hasNext) {
			var result = _current.next();
			if (!_current.hasNext()) {
				if (_subjects.hasNext()) {
					_current = _subjects.next();
				} else {
					_hasNext = false;
				}
			}
			return result;
		}
		return null;
	}
}


class ExecuteIterable<T> {
	var _subject:Iterable<T>;
	var _action: T -> Void;
	
	public function new(subject:Iterable<T>, action: T -> Void) {
		_subject = subject;
		_action = action;
	}
	
	public function iterator():Iterator<T> {
		return new ExecuteIterator(_subject.iterator(), _action);
	}
}
class ExecuteIterator<T> {
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

class AfterIterable<T> {
	var _subject:Iterable<T>;
	var _predicate: T -> Bool;
	
	public function new(subject:Iterable<T>, predicate: T -> Bool) {
		_subject = subject;
		_predicate = predicate;
	}
	
	public function iterator():Iterator<T> {
		return new AfterIterator(_subject.iterator(), _predicate);
	}
}
class AfterIterator<T> {
	var _subject:Iterator<T>;
	var _predicate: T -> Bool;
	var _evaluated:Bool;
	var _current:T;
	
	public function new(subject:Iterator<T>, predicate: T -> Bool) {
		_subject = subject;
		_predicate = predicate;
		_evaluated = false;
	}
	
	public function hasNext():Bool {
		if (!_evaluated)
			evaluate();
		return _subject.hasNext();
	}
	
	public function next():T {
		if (hasNext()) {
			var result = _current;
			_current = _subject.next();
			return result;
		}
		return null;
	}
	
	function evaluate() {
		if (_subject.hasNext()) {
			_current = _subject.next();
			while (!_predicate(_current)) {
				_current = _subject.next();
			}
			_evaluated = true;
		}
	}
}

class UntilIterable<T> {
	var _subject:Iterable<T>;
	var _predicate: T -> Bool;
	
	public function new(subject:Iterable<T>, predicate: T -> Bool) {
		_subject = subject;
		_predicate = predicate;
	}
	
	public function iterator():Iterator<T> {
		return new UntilIterator(_subject.iterator(), _predicate);
	}
}
class UntilIterator<T> {
	var _subject:Iterator<T>;
	var _predicate: T -> Bool;
	var _current:T;
	var _hasNext:Bool;
	
	public function new(subject:Iterator<T>, predicate: T -> Bool) {
		_subject = subject;
		_predicate = predicate;
		_hasNext = true;
	}
	
	public function hasNext():Bool {
		return _hasNext && _subject.hasNext();
	}
	
	public function next():T {
		if (hasNext()) {
			var result = _current;
			_hasNext = !_predicate(_current = _subject.next());
			return result;
		}
		return null;
	}
}

class IteratorIterable<T> {
	public var subject(default, null):Iterator<T>;
	public var iterated(default, null):Array<T>;
	
	public function new(subject:Iterator<T>) {
		this.subject = subject;
		iterated = new Array();
	}
	
	public function iterator():Iterator<T> {
		return new IteratorIterator(this);
	}
}
class IteratorIterator<T> {
	var _subject:IteratorIterable<T>;
	var _count:Int;
	public function new(subject:IteratorIterable<T>) {
		_subject = subject;
		_count = 0;
	}
	
	public function hasNext():Bool {
		return _count < _subject.iterated.length || _subject.subject.hasNext();
	}
	
	public function next():T {
		if (_count < _subject.iterated.length) {
			return _subject.iterated[_count];
			_count++;
		} else if(_subject.subject.hasNext()) {
			var result = _subject.subject.next();
			_count++;
			_subject.iterated.push(result);
			return result;
		}
		return null;
	}
}

class SelectIterable<T, V> {
	var _subject:Iterable<T>;
	var _selector: T -> V;
	
	public function new(subject:Iterable<T>, selector: T -> V) {
		_subject = subject;
		_selector = selector;
	}
	
	public function iterator():Iterator<V> {
		return new SelectIterator(_subject.iterator(), _selector);
	}
}
class SelectIterator<T, V> {
	var _subject:Iterator<T>;
	var _selector: T -> V;
	
	public function new(subject:Iterator<T>, selector: T -> V) {
		_subject = subject;
		_selector = selector;
	}
	
	public function hasNext():Bool {
		return _subject.hasNext();
	}
	
	public function next():V {
		return _selector(_subject.next());
	}
}

class SelectManyIterable<T, U, V> {
	var _subject:Iterable<T>;
	var _collection:Iterable<U>;
	var _selector: T -> U -> V;
	
	public function new(subject:Iterable<T>, collection:Iterable<U>, selector: T -> U -> V) {
		_subject = subject;
		_collection = collection;
		_selector = selector;
	}
	
	public function iterator():Iterator<V> {
		return new SelectManyIterator(_subject.iterator(), _collection, _selector);
	}
}
class SelectManyIterator<T, U, V> {
	var _subject:Iterator<T>;
	var _collection:Iterable<U>;
	var _selector: T -> U -> V;
	var _second:Iterator<U>;
	var _first:T;
	
	public function new(subject:Iterator<T>, collection:Iterable<U> , selector: T -> U -> V) {
		_subject = subject;
		_collection = collection;
		_selector = selector;
		_second = collection.iterator();
	}
	
	public function hasNext():Bool {
		return _subject.hasNext() || _second.hasNext();
	}
	
	public function next():V {
		if (hasNext()) {
			if (!_second.hasNext()) {
				_second = _collection.iterator();
				_first = _subject.next();
			}
			return _selector(_first, _second.next());
		}
		return null;
	}
	
}

class WhereIterable<T> {
	var _subject:Iterable<T>;
	var _predicate: T -> Bool;
	
	public function new(subject:Iterable<T>, predicate: T -> Bool) {
		_subject = subject;
		_predicate = predicate;
	}
	
	public function iterator():Iterator<T> {
		return new WhereIterator(_subject.iterator(), _predicate);
	}
}
class WhereIterator<T> {
	var _subject:Iterator<T>;
	var _predicate: T -> Bool;
	var _hasNext:Bool;
	var _current:T;
	
	public function new(subject:Iterator<T>, predicate: T -> Bool) {
		_subject = subject;
		_predicate = predicate;
		_hasNext = true;
		skipToNext();
	}
	
	public function hasNext():Bool {
		return _hasNext;
	}
	
	public function next():T {
		if(_hasNext) {
			var result = _current;
			skipToNext();
			return result;
		}
		return null;
	}
	
	function skipToNext():Void {
		if (_hasNext) {
			while (_subject.hasNext()) {
				_current = _subject.next();
				if (_predicate(_current)) {
					return;
				}
			}
			_hasNext = false;
			_current = null;
		}
	}
}
