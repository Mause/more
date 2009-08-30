/**
 * ...
 * @author Mark
 */

package haxe.more.datastructures;
import haxe.rtti.Generic;
import haxe.more.datastructures.iterators.LinkedListIterator;

class Queue<T> {
	private var head:SingleLinkedList<T>;
	private var tail:SingleLinkedList<T>;
	public var length(default, null):Int;
	public function new():Void {
		length = 0;
	}
	public function iterator():Iterator < T > {
		return new LinkedListIterator(head, tail);
	}
	public function peek():T {
		return head == null ? null : head.value;
	}
	public function pop():T {
		if (head == null && tail == null) {
			return null;
		} else {
			var result:T = head.value;
			if(head == tail) {
				head = tail = null;
			} else {				
				head = head.next;
			}
			length--;
			return result;
		}
	}
	public function push(value:T):T {
		if (head == null && tail == null) {
			head = tail = new SingleLinkedList<T>(value);
			length++;
		} else {
			tail.append(head);
			tail = tail.next;
			length++;
		}
		return value;
	}
}