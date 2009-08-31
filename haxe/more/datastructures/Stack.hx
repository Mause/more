/**
 * Copyright (c) 2009 Mark de Bruijn (kramieb@gmail.com | Dykam.nl)
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the University of California, Berkeley nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
package haxe.more.datastructures;
import flash.Error;
import haxe.more.datastructures.iterators.LinkedListIterator;

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