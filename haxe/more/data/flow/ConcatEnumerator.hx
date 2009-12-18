/** ConcatEnumerator.hx
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

class ConcatEnumerator<T> implements Enumerator<T> {
	var _subjects:Enumerator<Enumerator<T>>;
	var _currentEnumer:Enumerator<T>;
	var _done:Bool;
	
	public var current(default, null):T;
	
	public function new(subjects:Enumerable<Enumerator<T>>) {
		_subjects = subjects.getEnumerator();
		_done = false;
	}
	
	public function moveNext():Bool	{
		if (_done)
			return false;
		
		if (_currentEnumer == null || !_currentEnumer.moveNext()) {
			if (_subjects.moveNext()) {
				_currentEnumer = _subjects.current;
			}
			else {
				_done = true;
			}
			return moveNext(); // No fun, try again
		}
		
		current = _currentEnumer.current;
		return true;
	}
}