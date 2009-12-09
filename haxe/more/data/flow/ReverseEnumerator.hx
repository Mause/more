/** ReverseEnumerator.hx
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

class ReverseEnumerator<T> {
	var _subject:Enumerator<T>;
	var _elements:Array<T>;
	var _index:Int;
	public function new(subject:Enumerator<T>) {
		_subject = subject;
		_index = -1;
	}
	
	public function hasNext():Bool
		return _index != 0 && ((_index == -1 && _subject.hasNext()) || _index <= _elements.length)
		
	public function next():T {
		if (_index == -1) {		
			_elements = new Array();
			while (_subject.hasNext())
				_elements.push(_subject.next());
			_index = _elements.length;
		} else if (_index == 0) {
			return null;
		}
		return _elements[--_index];
	}
}