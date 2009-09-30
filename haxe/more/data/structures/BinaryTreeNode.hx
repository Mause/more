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
	
	public function toString():String {
		return Std.string(value);
	}
	
	public function iterator():Iterator<T> 	return inOrderIterator()
	public function preOrderIterator():Iterator<T> return new PreOrderIterator(this)
	public function postOrderIterator():Iterator<T> return new PostOrderIterator(this)
	public function inOrderIterator():Iterator<T> return new InOrderIterator(this)
	public function depthFirstIterator():Iterator<T> return null	
	public function breathFirstIterator():Iterator<T> return null
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
}
class PreOrderIterator<T> {
	var _queue:Queue<BinaryTreeNode<T>>;
	public function new(root:BinaryTreeNode<T>) {
		_queue = new Queue();
		_queue.push(root);
	}
	
	public function hasNext() return _queue.length != 0
	
	public function next():T {
		if(hasNext()) {
			var current = _queue.pop();
			if (current.left != null)
				_queue.push(current.left);
			if (current.right != null)
				_queue.push(current.right);
			return current.value;
		}
		return null;
	}
}
class InOrderIterator<T> {
	var _stack:Stack<BinaryTreeNode<T>>;
	var _current:BinaryTreeNode<T>;
	var _state:Int;
	public function new(root:BinaryTreeNode<T>) {
		_stack = new Stack();
		_stack.push(root);
		_state = 0;
	}
	
	public function hasNext() return _stack.length != 0
	
	public function next():T {
		while (hasNext()) {
			switch(_state) {
				case 0:
				_current = _stack.peek();
				if (_current.left != null) {
					_stack.push(_current.left);					
					break;
				}
				_state = 1;
				return _stack.pop().value;
				case 1:
				if(_current.right != null) {
					_stack.push(_current.right);
				}
				_state = 0;
			}
		}
		return null;
	}
}
class PostOrderIterator<T> {
	var _stack:Stack<BinaryTreeNode<T>>;
	public function new(root:BinaryTreeNode<T>) {
		_stack = new Stack();
		_stack.push(root);
	}
	
	public function hasNext() return _stack.length != 0
	
	public function next():T {
		while (hasNext()) {
			var current = _stack.peek();
			if (current.left != null) {
				_stack.push(current.left);
			} else if(current.right != null) {
				_stack.push(current.right);
			} else {
				return _stack.pop().value;
			}
		}
		return null;
	}
}