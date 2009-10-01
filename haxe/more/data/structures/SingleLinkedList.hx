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
	var operator:SingleLinkedListNodeOperator<T>;
	
	public var head(gHead, null):SingleLinkedListNode<T>;
	function gHead() return sentinel.next
	
	public var length(default, null):Int;
	
	public var tail(default, null):SingleLinkedListNode<T>;
	
	public function new<T>() {
		operator = new SingleLinkedListNodeOperator(this);
		sentinel = cast operator.create(null);
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
	
	function prepare(value:T):Bool {
		if (tail != null) return true;
		var result = operator.create(value);
		tail = sentinel.next = result;
		length++;
		return false;
	}
}

/**
 * Allows acces to the internals of SingleLinkedListNode. Bye nasty hacks.
 */
class SingleLinkedListNodeOperator<T> extends SingleLinkedListNode<T>  {
	var _list:SingleLinkedList<T>;
	public function new(list:SingleLinkedList<T>) {
		super(null, null);
		_list = list;
	}
	public function create(value:T):SingleLinkedListNode<T> {
		return new SingleLinkedListNode(_list, value);
	}
}