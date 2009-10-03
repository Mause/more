/** BinaryTreeNode.hx
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
import haxe.more.exceptions.ArgumentNullException;

typedef Comperator<T> = T -> T -> Int;
typedef Finder<T, K> = K -> T -> Int;

class BinaryTree<T> {	
	public static function integerComparator(left:Int, right:Int):Int
		return left - right
	
	public var comperator(default, default):Comperator<T>;		
	public var node(default, null):BinaryTreeNode<T>;
	function sNode(value) node = value
	public var operator:BinaryTreeNodeOperator<T>;
	
	public function new(comperator:Comperator<T>) {
		if (comperator == null) throw new ArgumentNullException("comperator");
		this.comperator = comperator;		
		operator = new BinaryTreeNodeOperator(this);
	}
	
	public function add(value:T):BinaryTree<T> {
		operator.add(value);
		return this;
	}
	
	public function find<K>(value:K, finder:Finder<T, K>):T {
		if (finder == null) throw new ArgumentNullException("finder");
		var current = node;
		while (current != null) {
			var contrast = finder(value, current.value);
			if (contrast < 0) {
				current = current.left;
			} else if(contrast != 0) {
				current = current.right;
			} else {
				return current.value;
			}
		}
		return null;
	}
	
	public function iterator():Iterator<T> 	return node.iterator()	
	public function preOrderIterator():Iterator<T> return node.preOrderIterator()
	public function postOrderIterator():Iterator<T> return node.postOrderIterator()
	public function inOrderIterator():Iterator<T>  return node.inOrderIterator()
	public function levelOrderIterator():Iterator<T> return node.levelOrderIterator()
}
// I want acces to the BinaryTreeNode's internals, but not expose this in the public BinaryTree. This internal class solves the problem nicely.
class BinaryTreeNodeOperator<T> extends BinaryTreeNode<T> {
	var _tree:BinaryTree<T>;
	public function new(tree:BinaryTree<T>) {
		super(null);
		_tree = tree;
	}
	public function add(value:T):Void {
		var created = new BinaryTreeNode(value);
		var comperator = _tree.comperator;
		var current = _tree.node;
		if (current == null) {
			var tree: { private function sNode(value:BinaryTreeNode<T>):Void; } = _tree;
			tree.sNode(created);
			return;
		}
		while (true) {
			var contrast = comperator(value, current.value);
			if (contrast < 0) {
				if (current.left == null) {
					current.left = created;
					return;
				}
				else {
					current = current.left;
				}
			} else if (contrast > 0) {
				if (current.right == null) {
					current.right = created;
					return;
				}
				else {
					current = current.right;
				}
			} else return;
		}
	}
}