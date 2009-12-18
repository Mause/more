/** SingleLinkedListNode.hx
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

class SingleLinkedListNode<T> {
	// ugh.. blech... needed.
	public var list(default, null):SingleLinkedList<T>;
	public var next(default, null):SingleLinkedListNode<T>;
	public var value:T;
	
	public inline var isAlive(gIsAlive, null):Bool;
	inline function gIsAlive() return (list != null)
	
	/**
	 * Constructs a new node. This is a private action.
	 * @param	list
	 * @param	?value
	 */
	function new(list:SingleLinkedList<T>, ?value:T):Void {
		this.list = list;
		this.value = value;
	}
	
	/**
	 * Appends a value to the current node.
	 * @param	?value The value to append. After the operation, the next node will contain this value.
	 */
	public function append(value:T):Void {
		if (!isAlive) return;
		var subject = new SingleLinkedListNode(list, value);
		SingleLinkedListOperator.setLength(list, list.length + 1);		
		
		subject.next = next;
		next = subject;
		
		if (subject.next == null)
			SingleLinkedListOperator.setTail(list, subject);
	}
	
	/**
	 * Prepends a value to the current node.
	 * @param	?value The value to prepend. After the operation, the previous node will contain this value.
	 * @param	?previous The node previous to this one. Supplying this can greatly speed up things.
	 * @usage	This is a slow method when not properly used. Try to supply the previous node wherever you can.
	 */
	public function prepend(value:T, ?previous:SingleLinkedListNode<T>):Void {
		if (!isAlive) return;
		
		previous = getPrevious(previous);
		
		previous.append(value);		
	}
	
	/**
	 * Removes the current node out of the list. All references to the containing list are in this node removed.
	 * @param	?previous The node previous to this one. Supplying this can greatly speed up things.
	 * @return	The value this node contained.
	 * @usage	This is a slow method when not properly used. Try to supply the previous node wherever you can.
	 */
	public function remove(?previous:SingleLinkedListNode<T>):T {
		if (!isAlive) return value;
		
		previous = getPrevious(previous);
		
		return previous.removeNext();
	}
	
	/**
	 * Removes the next node out of the list. All references to the containing list are in that node removed.
	 * @return	The value the next node contained.
	 */
	public function removeNext():T {
		if (!isAlive) return null;
		
		var subject = next;
		var result = subject.value;
		
		SingleLinkedListOperator.setLength(list, list.length - 1);
		
		next = next.next;
		
		if (next == null)
			if (this == SingleLinkedListOperator.getSentinel(list))
				SingleLinkedListOperator.setTail(list, null);
			else
				SingleLinkedListOperator.setTail(list, this);
		
		subject.next = null;
		subject.list = null;
		return result;
	}
	
	/**
	 * Makes sure the supplied node is really the previous node. If not, the real previous node is returned.
	 * @param	previous The node maybe being the previous node.
	 * @return	The real previous node.
	 */
	inline function getPrevious(previous:SingleLinkedListNode<T>):SingleLinkedListNode<T> {
		
		// Make sure the right "previous" was given
		if (previous != null && previous.next != this)
			previous = null;
		
		// make sure the previous is in fact really the previous node
		if (previous == null) {
			previous = cast SingleLinkedListOperator.getSentinel(list);
			while (previous.next != this)
				previous = previous.next;
		}
		return previous;
	}
	
	/**
	 * Returns an iterator to iterate this linked list from this node to the tail.
	 * @return An iterator to iterate this linked list from this node to the tail.
	 */
	public inline function iterator():Iterator<T> {
		return new SingleLinkedListIterator(this, list.tail);
	}
	
	public function toString():String
		return Std.string(value)
}

private class SingleLinkedListIterator<T> {
	var current:SingleLinkedListNode<T>;
	var tail:SingleLinkedListNode<T>;
	public function new(first:SingleLinkedListNode<T>, last:SingleLinkedListNode<T>):Void {
		current = first;
		tail = last;
	}
	public function hasNext():Bool {
		return tail != null && current != tail.next;
    }

    public function next():T {
		if (current == null) {
			return null;
		}
		var result:T = current.value;
		current = current.next;
		return result;
    }
}

/**
 * Allows acces to the internals of SingleLinkedList. Bye nasty hacks.
 */
private class SingleLinkedListOperator<T> extends SingleLinkedList<T> {
	public inline static function getSentinel<T>(list:SingleLinkedList<T>):SingleLinkedListNode<T> {
		return list.sentinel;
	}
	public inline static function setLength<T>(list:SingleLinkedList<T>, value:Int) {
		list.length = value;
	}
	public inline static function setTail<T>(list:SingleLinkedList<T>, node:SingleLinkedListNode<T>) {
		list.tail = node;
	}
}