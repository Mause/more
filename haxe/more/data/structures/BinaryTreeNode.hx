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
import haxe.more.data.structures.Queue;
import haxe.more.data.structures.Stack;

class BinaryTreeNode<T> {
	public var left(default, null):BinaryTreeNode<T>;
	public var right(default, null):BinaryTreeNode<T>;
	public var value(default, null):T;
	public var root(default, null):BinaryTree<T>;
	
	function new(value:T) this.value = value
	
	public var leftMost(gLeftMost, null):T;
	function gLeftMost():T {
		var current = this;
		while (current.left != null)
			current = current.left;
		return current.value;
	}
	
	public var rightMost(gRightMost, null):T;
	function gRightMost():T {
		var current = this;
		while (current.right != null)
			current = current.right;
		return current.value;
	}
	
	public function inOrderIterator():Iterator<T> return new InOrderIterator(this)
	public function iterator():Iterator<T> 	return inOrderIterator()
	public function preOrderIterator():Iterator<T> return new PreOrderIterator(this)
	public function postOrderIterator():Iterator<T> return new PostOrderIterator(this)
	public function levelOrderIterator():Iterator<T> return new LevelOrderIterator(this)
	public function toString():String return Std.string(value)
}
class TreeIterator<T> {	
	var _tree:BinaryTree<T>;
	var _current:BinaryTreeNode<T>;
	public function new(tree:BinaryTree<T>) {
		_tree = tree;
	}
	
	public function hasNext() return _current != null
}
class PreOrderIterator<T> extends TreeIterator<T>  {
	var _stack:Stack<BinaryTreeNode<T>>;
	public function new(root:BinaryTreeNode<T>) {
		super(root.root);
		_stack = new Stack<BinaryTreeNode<T>>();
		_stack.push(root);
		_current = root;
	}
	
	public override function hasNext() return super.hasNext() && _stack.length != 0
	
	public function next():T {
		if (!hasNext()) return null;
		
		_current = _stack.pop();
		
		if (_current.left != null)
			_stack.push(_current.left);
		if (_current.right != null)
			_stack.push(_current.right);
		return _current.value;
	}
}
class InOrderIterator<T> extends TreeIterator<T>  {
	public function new(root:BinaryTreeNode<T>) {
		super(root.root);
	}
	
	public function next():T {
		return null;
	}
}
class PostOrderIterator<T> extends TreeIterator<T>  {
	var _stack:Stack<BinaryTreeNode<T>>;
	public function new(root:BinaryTreeNode<T>) {
		super(root.root);
	}
	
	public function next():T {
		return null;
	}
}
class LevelOrderIterator<T> {
	var _queue:Queue<BinaryTreeNode<T>>;
	public function new(root:BinaryTreeNode<T>) {
		_queue = new Queue<BinaryTreeNode<T>>();
		_queue.push(root);
	}
	
	public function hasNext() return _queue.length != 0
	
	public function next():T {
		if (hasNext()) {
			var node = _queue.pop();
			if (node.left != null)
				_queue.push(node.left);
			if (node.right != null)
				_queue.push(node.right);
			return node.value;
		}
		throw "End reached";
	}
}