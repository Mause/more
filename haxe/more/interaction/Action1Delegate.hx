/** Action1Delegate.hx
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
 * WIA, RHOUA, R WAA, RA, RANA, RIES OA, R CONDIA, RIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/
package haxe.more.interaction;
import haxe.more.data.structures.ReadOnlyArray;
import haxe.more.data.structures.DoubleLinkedList;
import haxe.more.Functional;

using haxe.more.data.Manipulation;

class Action1Delegate#if!H<A>#end {
	var _handlers:DoubleLinkedList<Action1<A>>;

	public function new() {
	}

	public var isEmpty(get_isEmpty, null):Bool;
	function get_isEmpty() return _handlers.isEmpty;

	public function add(handler:Action1<A>):Void {
		_handlers.push(handler);
	}

	public function remove(handler:Action1<A>):Void {
		var current = _handlers.head;
		while (current != null && current.value != handler) current = current.next;
		if (current != null) {
			current.remove();
		}
	}

	public function invoke(arg:A):Void {
		for (handler in _handlers) {
			handler(arg);
		}
	}

	public function iterator(arg:A):Iterator<Void> {
		return _handlers.select(function(handler) return handler(arg)).iterator();
	}
}
