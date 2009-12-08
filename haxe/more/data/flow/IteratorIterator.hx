/** IteratorIterator.hx
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

class IteratorIterator<T> {
	var _subject:IteratorIterable<T>;
	var _index:Int;
	var _iter:Iterator<T>;
	
	public function new(subject:IteratorIterable<T>) {
		_subject = subject;
		_index = 0;
		_iter = subject.iterated.iterator();
	}
	
	public function hasNext():Bool
		return _iter.hasNext() || _subject.subject.hasNext()
	
	public function next():T {
		if (_iter.hasNext()) {
			return _iter.next();
		} else if(_subject.subject.hasNext()) {
			var result = _subject.subject.next();
			_subject.iterated.push(result);
			return result;
		}
		return null;
	}
}