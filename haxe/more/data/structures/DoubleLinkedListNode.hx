/** DoubleLinkedListNode.hx
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
import haxe.more.data.flow.Enumerator;
using haxe.more.data.IterableManipulation;

class DoubleLinkedListNode<T> {
	public var list(default, null):DoubleLinkedList<T>;
	public var next(default, null):DoubleLinkedListNode<T>;
	public var previous(default, null):DoubleLinkedListNode<T>;
	public var value:T;
	
	public inline var isAlive(gIsAlive, null):Bool;
	inline function gIsAlive() return (list != null)
	
	/**
	 * Constructs a new node. This is a private action.
	 * @param	list
	 * @param	?value
	 */
	function new(list:DoubleLinkedList<T>, ?value:T):Void {
		this.list = list;
		this.value = value;	
	}
	
	/**
	 * Appends a value to the current node.
	 * @param	?value The value to append. After the operation, the next node will contain this value.
	 */
	public function append(value:T):Void {
		if (!isAlive) throw "This Node is not used anymore";
		
		var subject = new DoubleLinkedListNode(list, value);
		
		DoubleLinkedListOperator.setLength(list, list.length + 1);		
		
		subject.previous = this;
		subject.next = next;
		next.previous = subject;
		next = subject;
		
		if (subject.next == null)
			DoubleLinkedListOperator.setTail(list, subject);
	}
	
	/**
	 * Prepends a value to the current node.
	 * @param	?value The value to prepend. After the operation, the previous node will contain this value.
	 * @param	?previous The node previous to this one. Supplying this can greatly speed up things.
	 * @usage	This is a slow method when not properly used. Try to supply the previous node wherever you can.
	 */
	public function prepend(value:T):Void {
		if (!isAlive) throw "This Node is not used anymore";
		previous.append(value);		
	}
	
	/**
	 * Removes the current node out of the list. All references to the containing list are in this node removed.
	 * @param	?previous The node previous to this one. Supplying this can greatly speed up things.
	 * @return	The value this node contained.
	 * @usage	This is a slow method when not properly used. Try to supply the previous node wherever you can.
	 */
	public function remove():T {
		if (!isAlive) throw "This Node is not used anymore";
		
		DoubleLinkedListOperator.setLength(list, list.length - 1);
		
		var result = value;
		
		previous.next = next;
		next.previous = previous;
		
		list = null;
		next = previous = null;
		value = null;
		
		return result;
	}
	
	/**
	 * Returns an iterator to iterate this linked list from this node to the tail.
	 * @return An iterator to iterate this linked list from this node to the tail.
	 */
	public inline function getEnumerator():Enumerator<T> {
		return new DoubleLinkedListEnumerator(this, list.tail);
	}
	
	/**
	 * Returns an iterator to iterate this linked list from this node to the tail.
	 * @return An iterator to iterate this linked list from this node to the tail.
	 */
	public inline function iterator():Iterator<T> {
		return getEnumerator().asIterator();
	}
	
	/**
	 * Returns an iterator to iterate this linked list from this node to the head.
	 * @return An iterator to iterate this linked list from this node to the head.
	 */
	public inline function getReversedEnumerator():Enumerator<T> {
		return new DoubleLinkedListReversedEnumerator(this, list.head);
	}
	
	/**
	 * Returns an iterator to iterate this linked list from this node to the head.
	 * @return An iterator to iterate this linked list from this node to the head.
	 */
	public inline function reversedIterator():Iterator<T> {
		return getReversedEnumerator().asIterator();
	}
}

private class DoubleLinkedListEnumerator<T> implements Enumerator<T> {
	var _current:DoubleLinkedListNode<T>;
	var _last:DoubleLinkedListNode<T>;
	
	public var current(default, null):T;
	
	public function new(first:DoubleLinkedListNode<T>, last:DoubleLinkedListNode<T>):Void {
		_current = first;
		_last = last;
	}
	
	public function moveNext():Bool {
		if (_current != null && _current.next != null && _current != _last) {
			_current = _current.next;
			current = _current.value;
			return true;
		}
		return false;
	}
}

private class DoubleLinkedListReversedEnumerator<T> implements Enumerator<T> {
	var _current:DoubleLinkedListNode<T>;
	var _first:DoubleLinkedListNode<T>;
	
	public var current(default, null):T;
	
	public function new(last:DoubleLinkedListNode<T>, first:DoubleLinkedListNode<T>):Void {
		_current = last;
		_first = first;
	}
	
	public function moveNext():Bool {
		if (_current != null || _current != _first) {
			_current = _current.previous;
			current = _current.value;
			return true;
		}
		return false;
	}
}

/**
 * Allows acces to the internals of DoubleLinkedList. Bye nasty hacks.
 */
private class DoubleLinkedListOperator<T> extends DoubleLinkedList<T> {
	public inline static function getSentinel<T>(list:DoubleLinkedList<T>):DoubleLinkedListNode<T> {
		return list.sentinel;
	}
	public inline static function setLength<T>(list:DoubleLinkedList<T>, value:Int) {
		list.length = value;
	}
	public inline static function setTail<T>(list:DoubleLinkedList<T>, node:DoubleLinkedListNode<T>) {
		list.tail = node;
	}
}