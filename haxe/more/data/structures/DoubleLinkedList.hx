/** DoubleLinkedList.hx
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

class DoubleLinkedList<T> {
	var sentinel:DoubleLinkedListNode<T>;
	var endtinel:DoubleLinkedListNode<T>;
	
	/**
	 * The first node of the list.
	 */
	public var head(gHead, null):DoubleLinkedListNode<T>;
	function gHead() return return sentinel.next == endtinel ? null : sentinel.next
	
	public var length(default, null):Int;
	
	/**
	 * The last node of the list.
	 */
	public var tail(gTail, null):DoubleLinkedListNode<T>;
	function gTail() return endtinel.previous == sentinel ? null : endtinel.previous
	
	/**
	 * Returns true if this list does not contain any nodes.
	 */
	public inline var empty(gEmpty, null):Bool;
	inline function gEmpty():Bool return length == 0
	
	/**
	 * Constructs a new list.
	 */
	public function new<T>() {
		var sendtinel = DoubleLinkedListNodeOperator.createSendtinel(this);
		sentinel = sendtinel.sentinel;
		endtinel = sendtinel.endtinel;
	}
	
	/**
	 * Adds value to the tail of the list.
	 * @param	value The value to add to the tail.
	 */
	public function push(value:T):Void {
		endtinel.prepend(value);
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
		return head.remove();
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
		return new DoubleLinkedListIterator(head, tail);
	}
	
	/**
	 * Returns an iterator to iterate trough this list from tail to head.
	 * @return an iterator to iterate trough this list from tail to head.
	 */
	public function reversedIterator():Iterator<T> {
		return new DoubleLinkedListReversedIterator(tail, head);
	}
}

/**
 * Allows acces to the internals of DoubleLinkedListNode. Bye nasty hacks.
 */
class DoubleLinkedListNodeOperator<T> extends DoubleLinkedListNode<T>  {
	public static function create<T>(list:DoubleLinkedList<T>, value:T):DoubleLinkedListNode<T> {
		return new DoubleLinkedListNode(list, value);
	}
	public static function createSendtinel<T>(list:DoubleLinkedList<T>):
			{ sentinel:DoubleLinkedListNode<T>, endtinel:DoubleLinkedListNode<T> } {
		var sentinel = new DoubleLinkedListNode(list, null);
		var endtinel = new DoubleLinkedListNode(list, null);
		sentinel.next = endtinel;
		endtinel.previous = sentinel;
		return {
			sentinel: sentinel,
			endtinel: endtinel
		};
	}
}