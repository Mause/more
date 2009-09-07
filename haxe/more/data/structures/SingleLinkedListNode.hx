/** SingleLinkedList.hx
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

class SingleLinkedListNode<T> {
	// ugh.. blech... needed.
	public var list(default, null):SingleLinkedList<T>;
	public var next(default, null):SingleLinkedListNode<T>;
	public var value:T;
	
	function new(list:SingleLinkedList<T>, ?value:T):Void {
		this.list = list;
		this.value = value;	
	}
	
	public function append(?value:T):Void {
		var result = new SingleLinkedListNode(list, value);
		if(next == null) {
			var list: {
				private function sTail(value:SingleLinkedListNode<T>):SingleLinkedListNode<T>;
			} = list;
			list.sTail(result);
		} else {
			result.next = next;
		}
		next = result;
	}
	
	public function prepend(?value:T, ?previous:SingleLinkedListNode<T>):Void {		
		var result = new SingleLinkedListNode(list, value);
		
		var list: {
			private var sentinel: { var next:SingleLinkedListNode<T>; };
			var tail(default, null):SingleLinkedListNode<T>;
			private function sTail(value:SingleLinkedListNode<T>):SingleLinkedListNode<T>;
		} = list;
		// make sure the previous is in fact really the previous node
		if (previous != null && previous.next != this) {
			previous = cast list.sentinel;
			while (previous != null && previous.next != this)
				previous = previous.next;
		}
		previous.next = result;
		result.next = this;		
	}
	
	public function remove(?previous:SingleLinkedListNode < T > ):T {
		var list: {
			private var sentinel: { var next:SingleLinkedListNode<T>; };
			var tail(default, null):SingleLinkedListNode<T>;
			private function sTail(value:SingleLinkedListNode<T>):SingleLinkedListNode<T>;
		} = list;
		
		// make sure the previous is in fact really the previous node
		if (previous != null && previous.next != this) {
			previous = cast list.sentinel;
			while (previous != null && previous.next != this)
				previous = previous.next;
		}
		
		previous.next = next;
		var result = value;
		value = null;
		list = null;
		next = null;
		return value;
	}
	
	public function iterator():Iterator<T> {
		return new SingleLinkedListIterator(this, list.tail);
	}
}

/*
{ private var sentinel: { var next:SingleLinkedListNode<T>; }; var tail(default, null):SingleLinkedListNode<T>; };
 */