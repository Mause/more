/** UntilIterator.hx
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

class UntilIterator<T> {
	var _subject:Iterator<T>;
	var _predicate: T -> Bool;
	var _validated:Bool;
	var _current:T;
	var _hasNext:Bool;
	
	public function new(subject:Iterator<T>, predicate: T -> Bool) {
		_subject = subject;
		_predicate = predicate;
		_hasNext = true;
		_validated = false;
	}
	
	public function hasNext() return _hasNext && valid() && _subject.hasNext()
	
	public function next():T {
		if (hasNext()) {
			_validated = false;
			return _current;
		}
		return null;
	}
	
	function valid() {
		if (!_validated) {
			_current = _subject.next();
			_hasNext = !_predicate(_current);
			_validated = true;
			return _hasNext;
		}
		return true;
	}
}