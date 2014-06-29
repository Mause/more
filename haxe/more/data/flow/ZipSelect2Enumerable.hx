/** ZipSelect2Enumerable.hx
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
package haxe.more.data.flow;

class ZipSelect2Enumerable#if!H<T1, T2, V>#end implements Enumerable<V> {
	var _subject1:Enumerable<T1>;
	var _subject2:Enumerable<T2>;
	var _selector: T1 -> T2 -> V;

	public function new(subject1:Enumerable<T1>, subject2:Enumerable<T2>, selector: T1 -> T2 -> V) {
		_subject1 = subject1;
		_subject2 = subject2;
		_selector = selector;
	}

	public function getEnumerator():Enumerator<V>
		return new ZipSelect2Enumerator(_subject1.getEnumerator(), _subject2.getEnumerator(), _selector);
}
