﻿/** WhereIterator.hx
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
	
	public function hasNext() return _hasNext
	
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