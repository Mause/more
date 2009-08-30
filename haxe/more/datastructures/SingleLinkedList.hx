/**
 * ...
 * @author Mark
 */

package haxe.more.datastructures;
import flash.Error;

class SingleLinkedList < T > {
	public var next(default, null):SingleLinkedList<T>;
	public var value:T;
	private var headTail:LinkedListHeadTailHolder<T, SingleLinkedList<T>>;
	public function new(value:T):Void {
		this.value = value;	
	}
	public function append(value:SingleLinkedList<T>):Void {
		value.next = next;
		next = value;
	}
	public function iterator():Iterator < T > {
		return headTail.iterator();
	}
}