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
package haxe.more.data.datastructures.bare;

class BareBinaryTree#if!H<T>#end {
	public var left:BareBinaryTree<T>;
	public var right:BareBinaryTree<T>;
	public var value:T;
	public var root:BareBinaryTree<T>;
	public function new(value:T) this.value = value
}
