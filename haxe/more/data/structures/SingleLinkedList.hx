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
	
	/**
	 * The first node of the list.
	 */
	public var head(gHead, null):SingleLinkedListNode<T>;
	function gHead() return sentinel.next
	
	public var length(default, null):Int;
	
	/**
	 * The last node of the list.
	 */
	public var tail(default, null):SingleLinkedListNode<T>;
	
	/**
	 * Returns true if this list does not contain any nodes.
	 */
	public inline var empty(gEmpty, null):Bool;
	inline function gEmpty():Bool return length == 0
	
	/**
	 * Constructs a new list.
	 */
	public function new<T>() {
		sentinel = SingleLinkedListNodeOperator.create(this, null);
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
	
	/**
	 * Returns an iterator to iterate trough this list.
	 * @return an iterator to iterate trough this list.
	 */
	public function iterator():Iterator<T> {
		return new SingleLinkedListIterator(head, tail);
	}
}

/**
 * Allows acces to the internals of SingleLinkedListNode. Bye nasty hacks.
 */
class SingleLinkedListNodeOperator<T> extends SingleLinkedListNode<T>  {
	public static function create<T>(list:SingleLinkedList<T>, value:T):SingleLinkedListNode<T> {
		return new SingleLinkedListNode(list, value);
	}
}