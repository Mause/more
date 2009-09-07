/**
 * ...
 * @author Mark
 */

package haxe.more.data.structures;

class SingleLinkedListIterator<T> {
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