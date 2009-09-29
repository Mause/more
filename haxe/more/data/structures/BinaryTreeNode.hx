/**
 * ...
 * @author Mark
 */

package haxe.more.data.structures;
import flash.Error;

class BinaryTreeNode<T> {
	public var left(default, null):BinaryTreeNode<T>;
	public var right(default, null):BinaryTreeNode<T>;
	public var value(default, null):T;
	public var root(default, null):BinaryTree<T>;
	
	function new(value:T) this.value = value
	
	public function insert(value:T):BinaryTreeNode<T> {
		var created = new BinaryTreeNode(value);
		var comperator = root.comperator;
		var current = this;
		while (current.left != null || current.right != null) {
			var contrast = comperator(value, this.value);
			if (contrast < 0) {
				if (left == null) {
					left = created;
					break;
				}
				else {
					current = left;
				}
			} else if(contrast > 0) {
				if (right == null) {
					right = created;
					break;
				}
				else {
					current = right;
				}
			} else {
				var leftDistance = comperator(value, left.value);
				var rightDistance = comperator(value, right.value);
				if (leftDistance < rightDistance) {					
					if (left == null) {
						left = created;
						break;
					}
					else {
						current = left;
					}
				} else {
					if (right == null) {
						right = created;
						break;
					}
					else {
						current = right;
					}
				}
			}
		}
		return created;
	}
}