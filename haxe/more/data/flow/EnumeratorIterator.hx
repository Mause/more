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
	var _state:Int; //0=end;1=loaded;2=unloaded
	
	public function new(enumerator:Enumerator<T>) {
		_enumerator = enumerator;
		_state = 2;
	}
	
	public function hasNext():Bool {
		switch(_state) {
			case 1:
				return true;
			case 2:
				_state = _enumerator.moveNext() ? 1 : 0;
				return hasNext();
			}
		return false;
	}
		
	public function next():T {
		if (hasNext()) {
			_state = 2;
			return _enumerator.current;
		}
		return null;
	}
}