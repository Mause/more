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

class SingleLinkedList<T> {
	var sentinel:SingleLinkedListNode<T>;
	var operator:SingleLinkedListNodeOperator<T>;
	
	public var head(gHead, null):SingleLinkedListNode<T>;
	function gHead() return sentinel.next
	
	public var length(default, null):Int;
	
	public var tail(default, null):SingleLinkedListNode<T>;
	
	public inline var empty(gEmpty, null):Bool;
	inline function gEmpty():Bool return length == 0
	
	public function new<T>() {
		operator = new SingleLinkedListNodeOperator(this);
		sentinel = cast operator.create(null);
	}
	
	/**
	 * Adds value to the tail of the list.
	 * @param	value The value to add to the tail.
	 */
	public function push(value:T):Void {
		if (empty)
			sentinel.append(value);
		else
			tail.append(value);
	}
	
	/**
	 * Removes the node at the tail of the list.
	 * @return The value of the removed node.
	 */
	public function pop():T {
		if (empty) throw "List is empty";	
		return tail.remove();
	}
	
	/**
	 * Removes the node at the head of the list.
	 * @return The value of the removed node.
	 */
	public function shift():T {
		if (empty) throw "List is empty";	
		return sentinel.removeNext();
	}
	
	/**
	 * Adds value to the head of the list.
	 * @param	value The value to add to the head.
	 */
	public function unshift(value:T):Void {
		sentinel.append(value);
	}
	
	public function iterator():Iterator<T> {
		return new SingleLinkedListIterator(head, tail);
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