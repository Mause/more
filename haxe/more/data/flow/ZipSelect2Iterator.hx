﻿/** ZipSelect2Iterator.hx
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

/**
 * Does do a select on two iterables synchonous.
 */
class ZipSelect2Iterator<T1, T2, V> {
	var _subject1:Iterator<T1>;
	var _subject2:Iterator<T2>;
	var _selector: T1 -> T2 -> V;
	
	/**
	 * Creates a new ZipSelect2Iterator
	 * @param	subject1 The first iterable to iterate through.
	 * @param	subject2 The second iterable to iterate through.
	 * @param	selector The selector selecting the resulting data.
	 */
	public function new(subject1:Iterator<T1>, subject2:Iterator<T2>, selector: T1 -> T2 -> V) {
		_subject1 = subject1;
		_subject2 = subject2;
		_selector = selector;
	}
	
	/**
	 * Returns if there is a next item available on both streams.
	 * @return if there is a next item available on both streams.
	 */
	public function hasNext():Bool return _subject1.hasNext() || _subject2.hasNext()
	
	/**
	 * Returns the next item generated by the selector.
	 * @return the next item generated by the selector.
	 */
	public function next():V return _selector(_subject1.next(), _subject2.next())
}