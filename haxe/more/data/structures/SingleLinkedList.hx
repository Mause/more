/** SingleLinkedList.hx
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
package haxe.more.data.structures;
import haxe.rtti.CType;

class SingleLinkedList<T> {
	var sentinel: { private var next:SingleLinkedListNode<T>; };
	
	public var head(gHead, null):SingleLinkedListNode<T>;
	function gHead() return sentinel.next
	
	public var length(default, null):Int;
	function sLength(value:Int) return length = value
	
	public var tail(default, null):SingleLinkedListNode<T>;
	function sTail(value:SingleLinkedListNode<T>) return tail = value
	
	public function new<T>() {
		sentinel = cast create(null);
	}
	
	public function push(value:T):Void {
		if (prepare(value)) {
			tail.append(value);
		}
	}
	public function pop():T {
		return tail.remove();
	}
	public function shift():T {
		return head.remove();
	}
	public function unshift(value:T):Void {
		if (prepare(value)) {
			var first:SingleLinkedListNode<T> = cast sentinel;
			first.append(value);
		}
	}
	
	public function iterator():Iterator<T> {
		return new SingleLinkedListIterator(head, tail);
	}
	
	function create(value:T):SingleLinkedListNode<T> {
		var result:SingleLinkedListNode<T> = cast Type.createInstance(SingleLinkedListNode, [this, value]);
		return result;
	}
	
	function prepare(value:T):Bool {
		if (tail != null) return true;
		var result = create(value);
		tail = sentinel.next = result;
		length++;
		return false;
	}
}
/*
{ 
	var list(default, null):SingleLinkedList<T>;
	var next(default, null):SingleLinkedListNode<T>;
	public var value:T;
}
*/