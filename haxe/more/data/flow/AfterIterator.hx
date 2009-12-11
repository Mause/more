/** AfterIterator.hx
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
package haxe.more.data.flow;

class AfterIterator<T> {
	var _subject:Iterator<T>;
	var _predicate: T -> Bool;
	var _initialized:Bool;
	var _current:T;
	
	public function new(subject:Iterator<T>, predicate: T -> Bool) {
		_subject = subject;
		_predicate = predicate;
		_initialized = false;
	}
	
	public function hasNext():Bool {
		if (!_initialized)
			initialize();
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
	
	function initialize() {
		if (_subject.hasNext()) {
			_current = _subject.next();
			while (!_predicate(_current)) {
				_current = _subject.next();
			}
			_initialized = true;
		}
	}
}