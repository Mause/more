/** Stack.hx
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

class Stack#if!H<T>#end {
	var list:SingleLinkedList<T>;
	
	public var length(gLength, null):Int;
	function gLength() return list.length
	
	public function new():Void {
		length = 0;
		list = new SingleLinkedList();
	}
	
	public function iterator():Iterator<T>
		return list.iterator()
	public function peek():T
		return list.length == 0 ? null : list.tail.value
	public function pop():T {
		var result = list.shift();
		return result;
	}
	public function push(value:T):Void{
		list.unshift(value);
	}
}