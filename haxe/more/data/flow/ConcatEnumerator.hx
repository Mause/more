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
	var _hasNext:Bool;
	var _current:Enumerator<T>;
	
	public var current(default, null):T;
	
	public function new(subjects:Enumerator<Enumerator<T>>) {
		_subjects = subjects;
		_current = subjects.next();
		_hasNext = true;
	}
	
	public function moveNext():Bool		
		throw new NotImplementedException("moveNext");
}