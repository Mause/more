/** HistoryTrioEnumerator.hx
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

class HistoryTrioEnumerator<T, V> implements Enumerator<V> {
	var _subject:Enumerator<T>;
	var _selector: T -> T -> T -> V;
	var _first:T;
	var _second:T;
	
	public var current(default, null):V;
	
	public function new(subject:Enumerator<T>, selector: T -> T -> T -> V) {
		_subject = subject;
		_selector = selector;
		if (subject.hasNext()) {
			_first = subject.next();			
			if (subject.hasNext()) {
				_second = subject.next();
			}
		}
	}
	
	public function moveNext():Bool		
		throw new NotImplementedException("moveNext");
}