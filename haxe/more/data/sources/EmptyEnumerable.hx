/** EmptyIterable.hx
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
import haxe.more.data.flow.Enumerable;

class EmptyIterable#if!H<T>#end implements Enumerable<T> {
	var _enumerator:EmptyEnumerator<T>;
	/**
	 * Creates a new nothing iterator.
	 */
	public function new() _enumerator = new EmptyEnumerator();

	/**
	 * Returns always an empty iterator.
	 * @return always an empty iterator.
	 */
	public function getEnumerator():Iterator<T> return _enumerator;

	/**
	 * Returns the string representation of this.
	 * @return the string representation of this.
	 */
	public function toString():String return "An empty enumerable.";
}
