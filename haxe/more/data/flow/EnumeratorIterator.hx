/** EnumeratorIterator.hx
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

class EnumeratorIterator<T> {
	var _enumerator:Enumerator<T>;
	var _movedNext:Bool;
	var _hasNext:Bool;
	
	public function new(enumerator:Enumerator<T>) {
		_enumerator = enumerator;
		_movedNext = true;
		_hasNext = false;
	}
	
	public function hasNext():Bool {
		if (_hasNext && !_movedNext) {
			_hasNext = _enumerator.moveNext();
			_movedNext = false;
		}
		return _hasNext;
	}
		
	public function next():T {
		if (hasNext()) {
			_movedNext = true;
			return _enumerator.current;
		}
		return null;
	}
}