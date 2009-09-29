/**
 * ...
 * @author Mark
 */

package haxe.more.data.structures;

typedef Comperator < T > = T -> T -> Int;

class BinaryTree<T> extends BinaryTreeNode<T> {
	static var init = (function() {
		left = -1;
	})();
	
	public static var left(default, null):Int;
	public static function integerComparator(child:Int, ancestor:Int):Int {
		return child - ancestor;
	}
	
	public var comperator(default, default):Comperator<T>;
	public function new(value:T, comperator:Comperator<T>) {
		super(value);
		this.comperator = comperator;
	}
}