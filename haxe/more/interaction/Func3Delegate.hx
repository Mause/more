/** Func3Delegate.hx
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

class Func3Delegate<A1, A2, A3, R> {
	var _handlers:DoubleLinkedList<Func3<A1, A2, A3, R>>;
	
	public function new() {
	}
	
	public var isEmpty(gIsEmpty, null):Bool;
	function gIsEmpty() return _handlers.isEmpty
	
	public function add(handler:Func3<A1, A2, A3, R>):Void {
		_handlers.push(handler);
	}
	
	public function remove(handler:Func3<A1, A2, A3, R>):Void {
		var current = _handlers.head;
		while (current != null && current.value != handler) current = current.next;
		if (current != null) {
			current.remove();
		}
	}
	
	public function invoke(arg1:A1, arg2:A2, arg3:A3):R {
		var current = _handlers.head;
		var result:R = null;
		while (current != null) {
			result = current.value(arg1, arg2, arg3);
		}
		return result;
	}
	
	public function invokeAll(arg1:A1, arg2:A2, arg3:A3):ReadOnlyArray<R> {
		var current = _handlers.head;
		var result = new Array<R>();
		while (current != null) {
			result.push(current.value(arg1, arg2, arg3));
		}
		return new ReadOnlyArray(result);
	}
	
	public function iterator(arg1:A1, arg2:A2, arg3:A3):Iterator<R> {
		return _handlers.select(function(handler) return handler(arg1, arg2, arg3)).iterator();
	}
}