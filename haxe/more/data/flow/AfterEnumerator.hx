/** AfterEnumerator.hx
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

class AfterEnumerator#if!H<T>#end extends BaseEnumerator<T> {
	var _subject:Enumerator<T>;
	var _predicate: T -> Bool;
	var _initialized:Bool;

	public function new(subject:Enumerator<T>, predicate: T -> Bool) {
		_subject = subject;
		_predicate = predicate;
		_initialized = false;
	}

	public override function moveNext():Bool	{
		if (!_initialized) {
			_initialized = true;
			while (_subject.moveNext()) {
				if (_predicate(_subject.current))
					break;
			}
		}
		if (_subject.moveNext()) {
			current = _subject.current;
			return true;
		}
		return false;
	}
}
