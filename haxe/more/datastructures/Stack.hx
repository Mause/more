/**
 * ...
 * @author Mark
 */

package haxe.more.datastructures;
import flash.Error;
import haxe.more.datastructures.iterators.LinkedListIterator;

/**
 * Warning, not errorless.
 */
class Stack<T> {
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
		if (head == null) {
			return null;
		}
		var result:T = head.value;
		if(head == tail) {
			head = tail = null;
		} else {
			head = head.next;
		}
		length--;
		return result;
	}
	public function push(value:T):T {
		if (head == null) {
			head = tail = new SingleLinkedList<T>(value);
		} else {
			var newOne:SingleLinkedList<T> = new SingleLinkedList<T>(value);
			newOne.append(head);
			head = newOne;
		}
		length++;
		return value;
	}
}