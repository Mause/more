/** UntilEnumerator.hx
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

class UntilEnumerator<T> implements Enumerator<T> {
	var _subject:Enumerator<T>;
	var _predicate: T -> Bool;
	var _finished:Bool;
	
	public var current(default, null):T;
	
	public function new(subject:Enumerator<T>, predicate: T -> Bool) {
		_subject = subject;
		_predicate = predicate;
		_finished = false;
	}
	
	public function moveNext():Bool {
		if (_finished) return false;
		if (_subject.moveNext() && !_predicate(_subject.current)) {
			return true;
		}
		_finished = true;
		return false;
	}
}