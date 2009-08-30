/**
 * ...
 * @author Mark
 */

package haxe.more.datastructures.iterators;
import haxe.more.datastructures.SingleLinkedList;

class LinkedListIterator <T> {
	private var current:SingleLinkedList<T>;
	private var tail:SingleLinkedList<T>;
	public function new(first:SingleLinkedList < T > , last:SingleLinkedList < T > ):Void {
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