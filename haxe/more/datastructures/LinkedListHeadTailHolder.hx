/**
 * ...
 * @author Mark
 */

package haxe.more.datastructures;
import haxe.more.datastructures.iterators.LinkedListIterator;

class LinkedListHeadTailHolder < T, L : SingleLinkedList<T> > {
	public var head:L;
	public var tail:L;
	public function new(list:L) {
		head = tail = list;
	}
	public function iterator():Iterator < T > {
		return new LinkedListIterator(head, tail);
	}
}