/**
 * ...
 * @author Mark
 */

package haxe.more.datastructures;

class DoubleLinkedList < T > {
	public var next(default, null):DoubleLinkedList<T>;
	public var previous(default, null):DoubleLinkedList<T>;
	public var value:T;
	private var headTail:LinkedListHeadTailHolder < T, DoubleLinkedList < T >>;
	public function new(value:T):Void  {
		this.value = value;
	}
	public function append(value:SingleLinkedList < T > ):Void {
		
	}
	public function iterator():Iterator < T > {
		return headTail.iterator();
	}
	public function prepend(value:SingleLinkedList < T > ):Void {
		
	}
}