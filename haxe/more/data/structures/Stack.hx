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
import flash.Error;

/**
 * Warning, not errorless.
 */
class Stack<T> {
	private var head:SingleLinkedList<T>;
	private var tail:SingleLinkedList<T>;
	public var length(default, null):Int;
	public function new():Void {
		length = 0;
	}
	public function iterator():Iterator < T > {
		return new LinkedListIterator(head, tail);
	}
	public function peek():T {
		return head == null ? null : head.value;
	}
	public function pop():T {
		if (head == null) {
			return null;
		}
		var result:T = head.value;
		if(head == tail) {
			head = tail = null;
		} else {
			head = head.next;
		}
		length--;
		return result;
	}
	public function push(value:T):T {
		if (head == null) {
			head = tail = new SingleLinkedList<T>(value);
		} else {
			var newOne:SingleLinkedList<T> = new SingleLinkedList<T>(value);
			newOne.append(head);
			head = newOne;
		}
		length++;
		return value;
	}
}