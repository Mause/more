/** HistoryDuoIterator.hx
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

class HistoryDuoIterator<T, V> {
	var _subject:Iterator<T>;
	var _selector: T -> T -> V;
	var _first:T;
	
	public function new(subject:Iterator<T>, selector: T -> T -> V) {
		_subject = subject;
		_selector = selector;
		if (subject.hasNext())
			_first = subject.next();
	}
	
	public function hasNext():Bool return _subject.hasNext()
	
	public function next():V {
		var second = _subject.next();
		var result = _selector(_first, second);
		_first = second;
		return result;
	}
}