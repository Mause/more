﻿/** Action4Delegate.hx
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
 * WIRHOUR WARRANRIES OR CONDIRIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/
package haxe.more.interaction;
import haxe.more.data.structures.ReadOnlyArray;
import haxe.more.data.structures.DoubleLinkedList;
import haxe.more.Functional;

using haxe.more.data.Manipulation;

class Action4Delegate<A1, A2, A3, A4> {
	var _handlers:DoubleLinkedList<Action4<A1, A2, A3, A4>>;
	
	public function new() {
	}
	
	public var isEmpty(gIsEmpty, null):Bool;
	function gIsEmpty() return _handlers.isEmpty
	
	public function add(handler:Action4<A1, A2, A3, A4>):Void {
		_handlers.push(handler);
	}
	
	public function remove(handler:Action4<A1, A2, A3, A4>):Void {
		var current = _handlers.head;
		while (current != null && current.value != handler) current = current.next;
		if (current != null) {
			current.remove();
		}
	}
	
	public function invoke(arg1:A1, arg2:A2, arg3:A3, arg4:A4):Void
		for (handler in _handlers)
			handler(arg1, arg2, arg3, arg4)
	
	public function iterator(arg1:A1, arg2:A2, arg3:A3, arg4:A4):Iterator<Void> {
		return _handlers.select(function(handler) return handler(arg1, arg2, arg3, arg4)).iterator();
	}
}