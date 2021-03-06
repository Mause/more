﻿/** ExposedIterable.hx
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
package haxe.more.data.sources;

class ExposedIterable#if!H<T>#end {
	var _next: Void -> T;
	var _hasNext: Void -> Bool;
	public function new(next: Void -> T, hasNext: Void -> Bool) {
		_next = next;
		_hasNext = hasNext;
	}

	public function iterator():Iterator<T>
		return new ExposedIterator(_next, _hasNext);
}
class ExposedIterator#if!H<T>#end {
	var _next: Void -> T;
	var _hasNext: Void -> Bool;
	public function new(next: Void -> T, hasNext: Void -> Bool) {
		_next = next;
		_hasNext = hasNext;
	}

	public function hasNext() return _hasNext();
	public function next() return _next();
}
